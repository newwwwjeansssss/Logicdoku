namespace LumaPairs
{
    /// <summary>教学逐步鼓励；普通落子只在一段有效思考时间后鼓励，不按每步重播。</summary>
    public sealed class LumaFeedbackTiming
    {
        // ADB 观测：连续落子不点赞，停顿 10 秒未触发，15/20 秒触发。
        // 采用已观测触发的保守值，不声称这是竞品内部的精确常量。
        public const double QuietBeforePraiseSeconds = 15;
        private double quietSeconds;

        public void Tick(double seconds)
        {
            if (double.IsNaN(seconds) || double.IsInfinity(seconds) || seconds <= 0) return;
            quietSeconds = System.Math.Min(QuietBeforePraiseSeconds, quietSeconds + seconds);
        }

        /// <summary>任何有效提交都结束本次思考间隔；错误与普通终局不产生点赞。</summary>
        public bool Resolve(bool correct, bool guided, bool won)
        {
            bool praise = correct && (guided || (!won && quietSeconds >= QuietBeforePraiseSeconds));
            Reset();
            return praise;
        }

        public void Reset() => quietSeconds = 0;
    }
}
