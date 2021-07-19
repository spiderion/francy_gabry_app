abstract class Dao {
  Future<dynamic> setSomeData(Map<String, dynamic> mapData);

  Stream<List<Map<String, dynamic>>> getStreamData();
}
