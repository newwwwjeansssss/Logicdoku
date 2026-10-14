namespace Xs.Singleton
{
    // Only framework storage is substituted; production records and parser are linked.
    public class DataConfigBase<K> { public K Id { get; set; } }
    public class DataSingleton<T,U,K> where T: new()
    {
        public static T Instance { get; } = new T();
        public List<U> Rows { get; } = new List<U>();
        public List<U> GetAllDatas() => Rows;
        public virtual string getTableName() => "";
    }
}
