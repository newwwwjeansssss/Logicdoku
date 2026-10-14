using Xs.Singleton;

/// <summary>
/// symbolSkin 配置表管理器。
/// </summary>
public class SymbolSkinConfigMgr : DataSingleton<SymbolSkinConfigMgr, SymbolSkinConfig, string>
{
    /// <summary>
    /// 返回当前配置类对应的配置表名称。
    /// </summary>
    /// <returns>配置表名称 symbolSkin。</returns>
    public override string getTableName()
    {
        return "symbolSkin";
    }
}

/// <summary>
/// symbolSkin 配置表单行数据。
/// </summary>
public class SymbolSkinConfig : DataConfigBase<string>
{
    /// <summary>
    /// StyleKey。
    /// </summary>
    public string StyleKey { get; set; }

    /// <summary>
    /// Slot。
    /// </summary>
    public string Slot { get; set; }

    /// <summary>
    /// IconAddress。
    /// </summary>
    public string IconAddress { get; set; }

    /// <summary>
    /// LabelKey。
    /// </summary>
    public string LabelKey { get; set; }

    /// <summary>
    /// PlaceSfxAddress。
    /// </summary>
    public string PlaceSfxAddress { get; set; }

    /// <summary>
    /// DisplayScale。
    /// </summary>
    public float DisplayScale { get; set; }
}
