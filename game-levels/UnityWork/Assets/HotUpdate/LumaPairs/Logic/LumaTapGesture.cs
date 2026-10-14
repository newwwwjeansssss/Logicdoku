namespace LumaPairs
{
    /// <summary>将同格连续点击识别为单击月亮或双击太阳，等待窗口内不提交错误。</summary>
    public sealed class LumaTapGesture
    {
        public const float DoubleTapWindow = .3f;
        private bool pending;
        private float deadline;
        /// <summary>记录点击；窗口内第二次点击立即返回太阳，否则等待单击判定。</summary>
        public int Tap(float now)
        {
            if (pending && now <= deadline) { pending = false; return 1; }
            pending = true; deadline = now + DoubleTapWindow; return 0;
        }
        /// <summary>超出双击窗口才提交月亮，提交后不重复触发。</summary>
        public int Poll(float now)
        {
            if (!pending || now < deadline) return 0;
            pending = false; return 2;
        }
        /// <summary>页面关闭、刷新或禁用时取消未完成的触控。</summary>
        public void Cancel() => pending = false;
    }
}
