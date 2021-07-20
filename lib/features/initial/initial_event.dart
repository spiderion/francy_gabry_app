import 'package:flutter_app_template/core/models/opponent.dart';
import 'package:template_package/template_package.dart';

class SaveDataEvent extends BaseBlocEvent {
  final String data;

  SaveDataEvent(String? analyticEventName, this.data) : super(analyticEventName);
}

class GetDataEvent extends BaseBlocEvent {
  GetDataEvent(String? analyticEventName) : super(analyticEventName);
}


class RemovePointEvent extends BaseBlocEvent {
  final Opponent opponent;

  RemovePointEvent(String analytic, {required this.opponent}) : super(analytic);
}

class AddPointEvent extends BaseBlocEvent {
  final Opponent opponent;

  AddPointEvent(String analytic, {required this.opponent}) : super(analytic);
}

class PrizeLongPressedEvent extends BaseBlocEvent {
  final dynamic variable;

  PrizeLongPressedEvent(String analytic, {this.variable}) : super(analytic);
}