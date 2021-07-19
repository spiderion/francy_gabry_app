import 'package:flutter_app_template/core/models/opponent.dart';
import 'package:template_package/template_package.dart';

class ScoreDataState extends BaseBlocDataState {
  final List<Opponent> opponents;

  ScoreDataState({required this.opponents});
}
