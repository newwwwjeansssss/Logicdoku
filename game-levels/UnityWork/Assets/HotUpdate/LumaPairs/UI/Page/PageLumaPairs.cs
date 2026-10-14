using System;
using System.Linq;
using System.Collections.Generic;
using LumaPairs;
using UnityEngine;
using Xs.Data;
using Xs.UI;
using Xs.Event;
using DG.Tweening;

/// <summary>展示首页、棋盘和提示证据；所有游戏状态交给 LumaSession。</summary>
public partial class PageLumaPairs : PageBase
{
    public LumaSession Session { get; private set; }
    private bool inGame;
    public bool IsInGame => inGame;
    public static bool IsGmEnabled => PlatMgr.Ins.GetPlatConfig() != null && PlatMgr.Ins.GetPlatConfig().platEvn == PlatEvn.Test;
    private bool suppressRender, entrancePending, dialogOpen;
    private float entranceUntil, lastInputTime;
    private float clockCheckpoint;
    private bool appPaused, winPending;
    private bool prepareMusicPending;
    private float winAt;
    private LumaHint weakHint;
    private int feedbackCell = -1, feedbackSymbol;
    private bool feedbackCorrect;
    private bool feedbackPraise, feedbackGuided;
    private readonly LumaFeedbackTiming feedbackTiming = new LumaFeedbackTiming();
    private LumaSession guideAudioSession;
    private int soundedGuideStep = -1;
    private float feedbackUntil;
    private LumaConstraint[] conflicts = Array.Empty<LumaConstraint>();
    private readonly List<RectTransform> cellViews = new List<RectTransform>();
    private int selected = -1;
    private int wrong = -1;
    private int justPlaced = -1;
    private readonly Dictionary<int, LumaTapGesture> pendingTaps = new Dictionary<int, LumaTapGesture>();
    private LumaHint hint;
    private RectTransform boardRoot;
    private RectTransform gameBackButton, gameSettingsButton;
    private RectTransform screenMask;
    private Vector2 selectorPosition;
    private bool selectorAnimate;
    private const string AudioRoot = "Assets/Res/LumaPairsSub/Audio/";
    private static readonly Color Cream = LumaVisuals.Lavender;
    private static readonly Color[] RegionColors = { new Color32(225,178,244,255), new Color32(255,235,166,255), new Color32(255,200,166,255), new Color32(166,228,237,255), new Color32(249,219,210,255), new Color32(214,215,242,255), new Color32(234,236,189,255), new Color32(206,232,224,255) };

    /// <summary>从统一配置表和框架存档建立游戏会话。</summary>
    public override void PageInit()
    {
        SymbolThemeResolver.UseConfiguredStyle(ConstantConfigMgr.Instance.GetDataById("ActiveSymbolStyle")?.value ?? "classic");
        m_Visuals.Get(SymbolThemeResolver.IconKey(1)); m_Visuals.Get(SymbolThemeResolver.IconKey(2));
        Session = new LumaSession(LumaLevel.FromConfig(), UserData.Instance.GetLumaPairsProgress(), UserData.Instance.SetLumaPairsProgress);
        dealTop = false; Render();
    }

    /// <summary>订阅状态和语言变化。</summary>
    protected override void AddListenner() { Session.Changed += RequestRender; LanuageConfigMgr.Instance.LanguageChanged += RequestLanguageRender; EventMgr.Instance.Add(EventName.BgmEnabledChanged, this, OnBgmEnabledChanged); }
    /// <summary>对称释放订阅。</summary>
    protected override void RemoveListenner() { Session.Changed -= RequestRender; LanuageConfigMgr.Instance.LanguageChanged -= RequestLanguageRender; EventMgr.Instance.Remove(EventName.BgmEnabledChanged, this, OnBgmEnabledChanged); }
    /// <summary>打开首页并恢复背景音乐。</summary>
    public override void PageOpen(params object[] args) { base.PageOpen(args); if (Session.NeedsGuidedTutorial) { StartGame(); return; } PlayMusic(); Render(); }

    /// <summary>页面离开后取消所有尚未确认的点击。</summary>
    public override void PageClose() { ClearErrorPresentation(); StopRuleDemoPresentation(); pendingTaps.Clear(); renderPending = false; prepareMusicPending = false; ClearFeedbackViews(); Session.Checkpoint(); base.PageClose(); }
    private void OnApplicationPause(bool paused) { appPaused = paused; if (paused) Session?.Checkpoint(); }

    /// <summary>集中完成单击，重绘一个格子不会丢失其他格子的快速输入。</summary>
    private void Update()
    {
        if (Session == null) return;
        if (prepareMusicPending && !appPaused && !dialogOpen && (!inGame || Time.unscaledTime >= entranceUntil))
        {
            prepareMusicPending = false;
            AudioMgr.Instance.PrepareBgm(AudioRoot + (inGame ? "hd_music_velvet_steps" : "hd_music_tidal_room"), suffix: ".wav");
        }
        if (inGame && !dialogOpen && !appPaused && Time.unscaledTime >= entranceUntil)
        {
            if (!Session.Won && !Session.Failed && !Session.NeedsRuleDemo)
                feedbackTiming.Tick(Time.unscaledDeltaTime);
            Session.Tick(Time.unscaledDeltaTime);
            if (Time.unscaledTime >= clockCheckpoint) { Session.Checkpoint(); clockCheckpoint = Time.unscaledTime + 5f; }
        }
        if (winPending && Time.unscaledTime >= winAt)
        {
            winPending = false; Sound("hd_victory_homecoming"); OpenDialog("win");
        }
        if (!winPending && feedbackCell >= 0 && Time.unscaledTime >= feedbackUntil)
        {
            feedbackCell = -1; wrong = -1; ClearFeedbackViews();
            conflicts = LumaSolver.Conflicts(Session.Level, Session.Snapshot());
            if (!dialogOpen) RequestRender();
        }
        if (inGame && !dialogOpen && Session.LevelNumber <= 2 && !Session.Won && hint == null && weakHint == null && selected < 0 && Time.unscaledTime - lastInputTime > 4f && Time.unscaledTime > feedbackUntil)
        {
            weakHint = Session.GetWeakGuide(); if (weakHint != null) RequestRender();
        }
        foreach (var entry in pendingTaps.ToArray())
        {
            if (!pendingTaps.ContainsKey(entry.Key)) continue;
            int symbol = entry.Value.Poll(Time.unscaledTime);
            if (symbol == 0) continue;
            pendingTaps.Remove(entry.Key);
            SubmitCell(entry.Key, symbol);
        }
    }

    /// <summary>原版选择器模式：仅空格和错误格可打开太阳/月亮浮层。</summary>
    private void TapCell(int index)
    {
        if (hint != null || Session.Won || Session.Failed || Session.NeedsRuleDemo || !inGame || dialogOpen || Time.unscaledTime < entranceUntil) return;
        lastInputTime = Time.unscaledTime;
        if (weakHint != null) { weakHint = null; RequestRender(); }
        if (Session.GuideStep >= 0 && index != Session.GuideCell) return;
        // 原版对预填格和正确锁定格也有点击反馈，空洞不产生交互。
        if (index < 0 || index >= Session.Level.Initial.Length || Session.Cell(index) < 0) return;
        VibrationMgr.Instance.PlayLightFeedback();
        if (Session.Level.Initial[index] != 0) { Sound("hd_ui_muted_knock"); return; }
        if (!Session.CanSelectCell(index)) return;
        pendingTaps.Clear(); selected = index; selectorAnimate = true; PlayInteractionSound("hd_cell_focus"); Render();
    }

    /// <summary>适应父 Canvas 尺寸与手机安全区，不改变棋盘纵横比。</summary>
    private void LateUpdate()
    {
        if (renderPending) Render();
        LumaVisuals.FitSafeArea((RectTransform)transform, m_Artboard, new Vector2(Screen.width, Screen.height), Screen.safeArea, new Vector2(1080, inGame ? 2400 : 1920));
        if (inGame && m_Artboard != null && Screen.width > 0 && Screen.height > 0)
        {
            // 局内画布更高；补偿缩放，让导航按钮与首页具有相同的屏幕尺寸。
            var safe = Screen.safeArea;
            if (safe.width <= 0 || safe.height <= 0 || safe.xMin < 0 || safe.yMin < 0 || safe.xMax > Screen.width + 1 || safe.yMax > Screen.height + 1)
                safe = new Rect(0, 0, Screen.width, Screen.height);
            var pageSize = ((RectTransform)transform).rect.size;
            float homeScale = Mathf.Min(pageSize.x * safe.width / Screen.width / 1080f,
                pageSize.y * safe.height / Screen.height / 1920f);
            float scale = m_Artboard.localScale.x > 0 ? homeScale / m_Artboard.localScale.x : 1f;
            if (gameBackButton != null) gameBackButton.localScale = Vector3.one * scale;
            if (gameSettingsButton != null) gameSettingsButton.localScale = Vector3.one * scale;
        }
        if (screenMask != null) LumaVisuals.CoverPage(screenMask, (RectTransform)transform);
    }

    /// <summary>在语言或状态变化后重绘页面，动态网格尺寸来自关卡。</summary>
    private void Render()
    {
        if (m_Artboard == null || Session == null || suppressRender) return;
        renderPending = false;
        EnsurePageViews();
        m_Artboard.sizeDelta = new Vector2(1080, inGame ? 2400 : 1920);
        SetVisible(homeView, !inGame);
        SetVisible(gameView, inGame);
        if (inGame) RefreshGameView(); else RefreshHomeView();
        SetVisible(gmButton, IsGmEnabled);
        gmButton.anchoredPosition = new Vector2(95, -(inGame ? 2315 : 1870));
    }

    /// <summary>首页法律入口复用页面栈中的现有说明页。</summary>
    private void OpenPrivacy() => LumaLegalLinks.OpenPrivacy();
    /// <summary>首页服务条款入口。</summary>
    private void OpenTerms() => LumaLegalLinks.OpenTerms();

    /// <summary>蓝色数字表示首个目标位置，棕色数字表示交点附近数量。</summary>
    private void DrawNumberBadge(Transform parent, float x, float y, int value, bool corner, float size, int symbol = 1)
    {
        m_Visuals.Image(parent, corner ? "icon_brown_num" : "icon_blue_num", x, y, size, size);
        m_Visuals.Label(parent, value.ToString(), x, y - size * .025f, size * .85f, size * .85f, size * .68f, Color.white);
        m_Visuals.Image(parent, SymbolThemeResolver.IconKey(symbol), x + size * .57f, y - size * .35f, size * .6f, size * .6f);
    }

    /// <summary>重开与下一关共用按对角线依次出现的格子动画。</summary>
    public void RequestBoardEntrance() { ClearErrorPresentation(); ClearFeedbackViews(); entrancePending = true; feedbackUntil = 0; weakHint = null; conflicts = Array.Empty<LumaConstraint>(); }
    private void AnimateBoardEntrance()
    {
        entrancePending = false;
        feedbackTiming.Reset();
        PlayInteractionSound("hd_board_arrival");
        entranceUntil = Time.unscaledTime + .28f + (Session.Level.Size - 1) * .07f;
        foreach (var cell in cellViews)
        {
            int i = int.Parse(cell.name.Substring(5));
            float delay = (i / Session.Level.Size + i % Session.Level.Size) * .035f;
            cell.DOKill(false);
            float step = 970f / Session.Level.Size;
            Position(cell, (i % Session.Level.Size + .5f) * step, (i / Session.Level.Size + .5f) * step, step - 9, step - 9);
            reusableCells[i].Character.transform.DOKill(false);
            reusableCells[i].Character.transform.localScale = Vector3.one;
            if (reusableCells[i].Burst != null) SetVisible(reusableCells[i].Burst, false);
            cell.localScale = Vector3.zero;
            cell.DOScale(1,.28f).SetDelay(delay).SetEase(Ease.OutBack).SetUpdate(true).SetLink(cell.gameObject);
        }
    }

    /// <summary>正确落子保留粒子；教学或有效思考间隔后的正确落子才显示点赞爱心。</summary>
    private void DrawMoveFeedback()
    {
        ClearFeedbackViews();
        float step = 970f / Session.Level.Size;
        float x = (feedbackCell % Session.Level.Size + .5f) * step, y = (feedbackCell / Session.Level.Size + .5f) * step;
        if (feedbackCorrect)
        {
            PlayMoveBurst(feedbackCell, step);
            if (!feedbackPraise) return;
            PlayInteractionSound(feedbackGuided ? "hd_tutorial_nod" : "hd_praise_skip");
            // 以 6×6 棋盘为基准，让成功提示与格子保持相同尺寸比例。
            float feedbackScale = 6f / Session.Level.Size;
            // 点赞与爱心整体向右下偏移，保持两者的相对位置。
            x += step * .15f;
            y += step * .15f;
            var hand = feedbackThumb;
            SetVisible(hand, true);
            hand.color = Color.white;
            Position(hand.rectTransform,x+step*.2f,y+step*.62f,145*feedbackScale,160*feedbackScale);
            hand.transform.localScale = Vector3.zero;
            hand.transform.DOScale(1,.2f).SetEase(Ease.OutBack).SetUpdate(true).SetLink(hand.gameObject);
            for(int i=0;i<3;i++)
            {
                var heart=feedbackHearts[i];
                SetVisible(heart,true); heart.color=Color.white;
                float heartSize = (27+i*7)*feedbackScale;
                Position(heart.rectTransform,x+(30+i*26)*feedbackScale,y+(30-i*18)*feedbackScale,heartSize,heartSize);
                heart.transform.DOLocalMoveY(heart.transform.localPosition.y+100*feedbackScale,.8f).SetUpdate(true).SetLink(heart.gameObject);
                FadeGraphic(heart,.85f);
            }
            FadeGraphic(hand,1f);
        }
        else
        {
            var cell = cellViews.FirstOrDefault(c=>c.name == "Cell_"+feedbackCell);
            if(cell!=null)
            {
                cell.DOKill(false); cell.localScale = Vector3.one;
                Position(cell,x,y,step-9,step-9);
                cell.DOPunchPosition(new Vector3(14,0,0),.4f,8).SetUpdate(true).SetLink(cell.gameObject);
            }
        }
    }
    private static void FadeGraphic(UnityEngine.UI.Graphic image,float duration)
    {
        DOTween.To(()=>image.color.a,a=>image.color=new Color(image.color.r,image.color.g,image.color.b,a),0,duration).SetTarget(image).SetUpdate(true).SetLink(image.gameObject, LinkBehaviour.KillOnDisable);
    }
    private UnityEngine.UI.Image DrawOutline(Transform parent, float x, float y, float width, float height, float thickness)
    {
        var border = m_Visuals.Image(parent,"rectangle",x,y,width,height,new Color32(255,70,70,255));
        border.type = UnityEngine.UI.Image.Type.Sliced;
        border.fillCenter = false;
        border.pixelsPerUnitMultiplier = 20f / Mathf.Max(1f, thickness);
        return border;
    }
    private void OpenGm() { if (IsGmEnabled) OpenDialog("gm"); }
    /// <summary>由 GM 确认后清除会话缓存与玩法存档，重新启动首关教学。</summary>
    public void ResetForTutorial()
    {
        if (!IsGmEnabled) return;
        pendingTaps.Clear(); hint=null; weakHint=null; feedbackUntil=0; wrong=-1; selected=-1;
        suppressRender=true; try { Session.ResetProgress(); } finally { suppressRender=false; }
        StartGame();
    }

    /// <summary>GM 更换关卡并清理旧关的输入、提示及结算状态，由当前弹窗承接解锁说明。</summary>
    public bool JumpForGm(int level)
    {
        if (!IsGmEnabled) return false;
        if (level < 1 || level > Session.LevelCount) return false;
        ClearErrorPresentation();
        pendingTaps.Clear(); hint = null; weakHint = null; winPending = false;
        feedbackCell = -1; feedbackUntil = 0; wrong = -1; selected = -1;
        conflicts = Array.Empty<LumaConstraint>();
        suppressRender = true;
        try { Session.JumpToLevel(level); Session.BeginTutorial(); }
        finally { suppressRender = false; }
        inGame = true; entrancePending = true; lastInputTime = Time.unscaledTime;
        PlayMusic(); Render();
        return true;
    }

    /// <summary>读取当前语言中的页面文本。</summary>
    private static string T(string key, params object[] args) => LumaVisuals.Text(key, args);
    /// <summary>播放通过框架按地址加载的音效。</summary>
    private static void Sound(string name) => AudioMgr.Instance.PlayAudio(AudioRoot + name, suffix: ".wav");
    /// <summary>音乐重新开启时按当前页面恢复曲目，关闭仍由框架停止。</summary>
    private void OnBgmEnabledChanged(object[] args)
    {
        if (AudioMgr.Instance.GetBgmEnabled()) PlayMusic();
    }

    /// <summary>交互声音允许与落子及弹窗声音叠加，统一遵守框架音效开关。</summary>
    public static void PlayInteractionSound(string name) => AudioMgr.Instance.PlayAudio(AudioRoot + name, useSeparateSource: true, suffix: ".wav");

    /// <summary>根据页面状态切换背景音乐。</summary>
    private void PlayMusic()
    {
        AudioMgr.Instance.PlayBgm(AudioRoot + (inGame ? "hd_music_tidal_room" : "hd_music_velvet_steps"), suffix: ".wav");
        prepareMusicPending = true;
    }
    /// <summary>进入当前关，首次进入展示规则教学。</summary>
    private void StartGame()
    {
        ClearErrorPresentation();
        feedbackTiming.Reset(); soundedGuideStep = -1;
        inGame = true; selected = -1; weakHint = null; conflicts = Array.Empty<LumaConstraint>(); feedbackUntil = 0; lastInputTime = Time.unscaledTime; entrancePending = true; suppressRender = true; try { Session.BeginTutorial(); } finally { suppressRender = false; } PlayMusic(); Render();
        if (Session.Failed) { OpenDialog("revive"); return; }
        if (Session.GuideStep >= 0) return;
        if (Session.PendingFeature != null) OpenDialog(Session.PendingFeature + "_unlock");
        else if (Session.NeedsTutorial && !Session.NeedsRuleDemo) OpenDialog("tutorial");
        else if (Session.Won) OpenDialog("win");
    }
    /// <summary>返回首页，当前棋盘由会话保留。</summary>
    private void BackHome() { ClearErrorPresentation(); Session.Checkpoint(); winPending = false; weakHint = null; feedbackUntil = 0; pendingTaps.Clear(); inGame = false; hint = null; selected = -1; PlayMusic(); Render(); }
    /// <summary>提交选择器选项；灰显项、预填格和已结束棋盘拒绝操作。</summary>
    private void SubmitCell(int index, int symbol)
    {
        if (!Session.CanSelectSymbol(index, symbol)) return;
        if (hint != null || Session.Won || Session.Failed) return;
        if (Session.GuideStep >= 0 && index != Session.GuideCell) return;
        if (Session.Level.Initial[index] != 0) { Sound("hd_ui_muted_knock"); return; }
        if (Session.GuideStep >= 0 && symbol != Session.GuideSymbol) return;
        if (Session.GuideStep >= 0) pendingTaps.Clear();
        selected = index; wrong = -1; Choose(symbol);
    }
    /// <summary>执行完整落子操作后播放反馈并选择结算页面。</summary>
    private void Choose(int symbol)
    {
        int index = selected; selected = -1;
        if (index < 0) return;
        var trial = Session.Snapshot(); trial[index] = symbol;
        conflicts = LumaSolver.Conflicts(Session.Level, trial);
        string mistakeRule = LumaSolver.MistakeRule(Session.Level, trial, index);
        feedbackGuided = Session.GuideStep >= 0;
        int previousHearts = Session.Hearts;
        suppressRender = true;
        bool correct;
        try { correct = Session.Place(index, symbol); } finally { suppressRender = false; }
        feedbackCell = index; feedbackSymbol = symbol; feedbackCorrect = correct;
        feedbackPraise = feedbackTiming.Resolve(correct, feedbackGuided, Session.Won);
        feedbackUntil = Time.unscaledTime + (correct ? 1.1f : 1.6f);
        if (correct) conflicts = LumaSolver.Conflicts(Session.Level, Session.Snapshot());
        weakHint = null; lastInputTime = Time.unscaledTime;
        justPlaced = correct ? index : -1;
        wrong = correct ? -1 : index;
        if (!correct)
        {
            if (mistakeRule != null || Session.Hearts == previousHearts)
                PlayInteractionSound("hd_rule_soft_stop");
            if (Session.Hearts < previousHearts)
                PlayInteractionSound("hd_heart_dip");
        }
        else
        {
            string address = SymbolThemeResolver.Active.Get(symbol).PlaceSfxAddress;
            if (string.IsNullOrEmpty(address)) Sound("hd_cell_focus");
            else AudioMgr.Instance.PlayAudio(address, suffix: ".wav");
        }
        if (correct) VibrationMgr.Instance.PlayLightFeedback();
        else VibrationMgr.Instance.PlayErrorFeedback();
        // 落子反馈仅随本次操作播放一次，普通重绘或打开选择器不能重播。
        Render(); DrawMoveFeedback();
        if (!correct)
        {
            PlayRuleError(mistakeRule);
            if (Session.LastMoveWasFirstLifeLoss) PlayLifeWarning(mistakeRule == null ? 0 : RuleErrorDuration);
        }
        CheckEnd();
    }
    /// <summary>请求提示且保留推导依据，不提前填入答案。</summary>
    private void ShowHint()
    {
        if (Session.HintCount <= 0) { Sound("hd_ui_muted_knock"); return; }
        if (Session.Failed || Session.Won) { CheckEnd(); return; }
        pendingTaps.Clear(); selected = -1; hint = Session.GetHint(); if (hint != null) Sound("hd_hint_unveil"); Render();
    }
    /// <summary>应用提示后按正常完成条件结算。</summary>
    private void ApplyHint() { LumaHint value = hint; hint = null; if (Session.ApplyHint(value)) { justPlaced = value.Cell; feedbackTiming.Reset(); Sound("hd_hint_unveil"); } Render(); CheckEnd(); }
    /// <summary>展示失败或胜利弹窗。</summary>
    private void CheckEnd()
    {
        if (Session.Won && !winPending && !dialogOpen)
        {
            pendingTaps.Clear(); winPending = true; winAt = Time.unscaledTime + 1.65f;
            PlayInteractionSound("hd_finish_small_arc");
            var glow=winOutline; SetVisible(glow,true);
            glow.color=new Color32(255,222,105,255);
            glow.transform.DOScale(1.025f,.65f).SetLoops(2,LoopType.Yoyo).SetUpdate(true).SetLink(glow.gameObject);
            foreach (var cell in cellViews)
            {
                int i = int.Parse(cell.name.Substring(5));
                cell.DOPunchScale(Vector3.one * .07f, .35f, 1).SetDelay((i / Session.Level.Size + i % Session.Level.Size) * .04f).SetUpdate(true).SetLink(cell.gameObject);
            }
        }
        else if (Session.Failed) { Sound("hd_retry_exhale"); OpenDialog("revive"); }
    }
    /// <summary>通过框架页面栈打开设置。</summary>
    private void OpenSettings() { if (!winPending) OpenDialog("settings"); }
    /// <summary>向独立弹窗传递页面上下文。</summary>
    private void OpenDialog(string mode) { ClearErrorPresentation(); Session.Checkpoint(); dialogOpen = true; weakHint = null; pendingTaps.Clear(); LumaUiAccess.OpenUI(LumaDialogRoutes.Resolve(mode), null, this); }
    /// <summary>弹窗关闭只刷新展示；入场由进入、换关或重开显式请求，不能因动画尚未结束而重播。</summary>
    public void RefreshAfterDialog() { dialogOpen = false; lastInputTime = Time.unscaledTime; selected = -1; hint = null; wrong = -1; Render(); }
}
