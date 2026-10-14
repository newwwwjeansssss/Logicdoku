using System.Collections.Generic;
using Xs.Singleton;

/// <summary>
/// 统一保存 HotUpdate 启动阶段需要加载的正式配置表，避免入口层依赖具体配置管理器。
/// </summary>
public static class ConfigInsResgister
{
    private static readonly IReadOnlyList<DataIntetface> Tables = new DataIntetface[]
    {
        PuzzleBoardConfigMgr.Instance,
        PuzzleClauseConfigMgr.Instance,
        PuzzleRouteConfigMgr.Instance,
        SymbolSkinConfigMgr.Instance,
        ConstantConfigMgr.Instance,
        LanuageConfigMgr.Instance,
        ProductsConfigMgr.Instance,
        ResourceConfigMgr.Instance,
    };

    /// <summary>
    /// 获取本轮正式配置加载需要注册的全部配置表实例。
    /// </summary>
    /// <returns>只读的配置表实例列表。</returns>
    public static IReadOnlyList<DataIntetface> GetTables()
    {
        return Tables;
    }
}
