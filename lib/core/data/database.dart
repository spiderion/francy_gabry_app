import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

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
}
