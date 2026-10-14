using Xs.Singleton;

/// <summary>
/// puzzleClause 配置表管理器。
/// </summary>
public class PuzzleClauseConfigMgr : DataSingleton<PuzzleClauseConfigMgr, PuzzleClauseConfig, string>
{
    /// <summary>
    /// 返回当前配置类对应的配置表名称。
    /// </summary>
    /// <returns>配置表名称 puzzleClause。</returns>
    public override string getTableName()
    {
        return "puzzleClause";
    }
}

/// <summary>
/// puzzleClause 配置表单行数据。
/// </summary>
public class PuzzleClauseConfig : DataConfigBase<string>
{
    /// <summary>
    /// SetRef。
    /// </summary>
    public string SetRef { get; set; }

    /// <summary>
    /// Order。
    /// </summary>
    public int Order { get; set; }

    /// <summary>
    /// Op。
    /// </summary>
    public string Op { get; set; }

    /// <summary>
    /// Axis。
    /// </summary>
    public string Axis { get; set; }

    /// <summary>
    /// CellRefs。
    /// </summary>
    public string CellRefs { get; set; }

    /// <summary>
    /// ZoneLabel。
    /// </summary>
    public int ZoneLabel { get; set; }

    /// <summary>
    /// Relation。
    /// </summary>
    public string Relation { get; set; }

    /// <summary>
    /// Edge。
    /// </summary>
    public string Edge { get; set; }

    /// <summary>
    /// Lane。
    /// </summary>
    public int Lane { get; set; }

    /// <summary>
    /// Slot。
    /// </summary>
    public string Slot { get; set; }

    /// <summary>
    /// Amount。
    /// </summary>
    public int Amount { get; set; }
}
