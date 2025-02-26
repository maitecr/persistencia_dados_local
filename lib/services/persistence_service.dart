abstract class PersistenceModel {
  Future<void> saveData(String key, Map<String, dynamic> value);
  Future<Map<String, dynamic>?> getData(String key);
}
