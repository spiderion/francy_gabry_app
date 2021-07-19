import 'package:flutter_app_template/core/data/dao.dart';
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
}
