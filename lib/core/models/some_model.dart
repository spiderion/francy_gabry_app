import 'package:flutter_app_template/core/models/opponent.dart';

class SomeModel {
  final List<Opponent> opponents;
  static const opponents_key = "opponents";

  SomeModel(this.opponents);

  Map<String, dynamic> toJson({bool isStoreLocal = false}) => {opponents_key: opponents};

  @override
  SomeModel.fromJson(List<Map<String, dynamic>>? json)
      : opponents = json?.map((e) => Opponent.fromJson(e)).toList() ?? [];
}
