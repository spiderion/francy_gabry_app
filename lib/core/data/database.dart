import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_template/core/models/opponent.dart';

import 'dao.dart';

class DataBase extends Dao {
  FirebaseFirestore _db;

  DataBase(this._db);

  @override
  Stream<List<Map<String, dynamic>>> getStreamData() {
    final streamResult = _db.collection("OPPONENTS").snapshots();
    return streamResult.transform(StreamTransformer.fromHandlers(handleData: (data, sink) {
      sink.add(data.docs.map((e) => e.data()).toList());
    }));
  }

  @override
  Future<dynamic> setSomeData(dynamic someData) async {}

  @override
  Future<void> setPoints(String userID, int newPoints) async {
    return _db.collection('OPPONENTS').doc(userID).update({Opponent.points_key: newPoints});
  }

  @override
  Future<Map<String, dynamic>?> getPrizeUrl() async {
    final result = await _db.collection('PRIZE').doc('PRIZE').get();
    return result.data();
  }
}
