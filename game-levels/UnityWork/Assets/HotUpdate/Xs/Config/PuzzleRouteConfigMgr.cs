using Xs.Singleton;

/// <summary>
/// puzzleRoute 配置表管理器。
/// </summary>
public class PuzzleRouteConfigMgr : DataSingleton<PuzzleRouteConfigMgr, PuzzleRouteConfig, string>
{
    /// <summary>
    /// 返回当前配置类对应的配置表名称。
    /// </summary>
    /// <returns>配置表名称 puzzleRoute。</returns>
    public override string getTableName()
    {
        return "puzzleRoute";
    }
}

/// <summary>
/// puzzleRoute 配置表单行数据。
/// </summary>
public class PuzzleRouteConfig : DataConfigBase<string>
{
    /// <summary>
    /// OrderIndex。
    /// </summary>
    public int OrderIndex { get; set; }

    /// <summary>
    /// CatalogKey。
    /// </summary>
    public string CatalogKey { get; set; }

    /// <summary>
    /// FormatRevision。
    /// </summary>
    public int FormatRevision { get; set; }

    /// <summary>
    /// ContentTag。
    /// </summary>
    public string ContentTag { get; set; }

    /// <summary>
    /// BoardRef。
    /// </summary>
    public string BoardRef { get; set; }

    /// <summary>
    /// ClauseSetRef。
    /// </summary>
    public string ClauseSetRef { get; set; }

    /// <summary>
    /// Grade。
    /// </summary>
    public int Grade { get; set; }

    /// <summary>
    /// Featured。
    /// </summary>
    public int Featured { get; set; }

    /// <summary>
    /// RuleDeck。
    /// </summary>
    public string RuleDeck { get; set; }

    /// <summary>
    /// CutoutMode。
    /// </summary>
    public string CutoutMode { get; set; }

    /// <summary>
    /// PuzzleHash。
    /// </summary>
    public string PuzzleHash { get; set; }
}
