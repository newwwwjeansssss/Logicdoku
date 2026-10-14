using Xs.Singleton;

/// <summary>
/// puzzleBoard 配置表管理器。
/// </summary>
public class PuzzleBoardConfigMgr : DataSingleton<PuzzleBoardConfigMgr, PuzzleBoardConfig, string>
{
    /// <summary>
    /// 返回当前配置类对应的配置表名称。
    /// </summary>
    /// <returns>配置表名称 puzzleBoard。</returns>
    public override string getTableName()
    {
        return "puzzleBoard";
    }
}

/// <summary>
/// puzzleBoard 配置表单行数据。
/// </summary>
public class PuzzleBoardConfig : DataConfigBase<string>
{
    /// <summary>
    /// Columns。
    /// </summary>
    public int Columns { get; set; }

    /// <summary>
    /// Rows。
    /// </summary>
    public int Rows { get; set; }

    /// <summary>
    /// Cells。
    /// </summary>
    public string Cells { get; set; }
}
