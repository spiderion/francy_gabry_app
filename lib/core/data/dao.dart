abstract class Dao {
  Future<dynamic> setSomeData(Map<String, dynamic> mapData);

  Stream<List<Map<String, dynamic>>> getStreamData();

  Future<void> setPoints(String userID, int newPoints);

  Future<Map<String, dynamic>?> getPrizeUrl();

  Future<void> saveImageUrl(String imageUrl);
}
