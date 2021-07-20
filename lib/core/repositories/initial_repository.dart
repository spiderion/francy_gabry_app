import 'package:flutter_app_template/core/data/dao.dart';
import 'package:flutter_app_template/core/models/opponent.dart';
import 'package:flutter_app_template/core/models/some_model.dart';
import 'package:template_package/template_package.dart';

class InitialRepository extends BaseRepository {
  final Dao _dao;

  InitialRepository(RemoteConfiguration remoteConfiguration, ExceptionCaptor exceptionCaptor, this._dao)
      : super(remoteConfiguration, exceptionCaptor);

  Future<void> getSomeData(RequestObserver<dynamic, SomeModel?> requestBehaviour) async {
    try {
      final Stream<List<Map<String, dynamic>>> streamResult = _dao.getStreamData();
      streamResult.listen((event) {
        requestBehaviour.onListen?.call(SomeModel.fromJson(event));
      });
    } catch (e, s) {
      requestBehaviour.onError?.call(ServerError(message: e.toString()));
      requestBehaviour.onDone?.call();
    }
  }

  Future<void> setSomeData(RequestObserver<SomeModel?, dynamic> requestBehaviour) async {
    try {
      final result = await _dao.setSomeData(requestBehaviour.requestData!.toJson());
      requestBehaviour.onListen?.call(result);
    } catch (e, s) {
      requestBehaviour.onError?.call(ServerError(message: e.toString()));
      requestBehaviour.onDone?.call();
    }
  }

  void setPoints(RequestObserver<Opponent, void> requestObserver) async {
    try {
      final result =
          await _dao.setPoints(requestObserver.requestData!.id, requestObserver.requestData!.points);
      requestObserver.onListen?.call(result);
    } catch (e, s) {
      requestObserver.onError?.call(ServerError(message: e.toString()));
      requestObserver.onDone?.call();
    }
  }

  void getPrizeUrl(RequestObserver<dynamic, String?> requestObserver) async {
    try {
      final result = await _dao.getPrizeUrl() ?? {};
      requestObserver.onListen?.call(result['imageUrl']);
    } catch (e, s) {
      requestObserver.onError?.call(ServerError(message: e.toString()));
      requestObserver.onDone?.call();
    }
  }
}
