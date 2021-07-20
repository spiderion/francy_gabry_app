import 'dart:async';

import 'package:flutter_app_template/core/models/opponent.dart';
import 'package:flutter_app_template/core/models/some_model.dart';
import 'package:flutter_app_template/core/states/primary_states/error_states/error_full_screen.dart';
import 'package:flutter_app_template/core/use_cases/user_use_case.dart';
import 'package:flutter_app_template/features/initial/initial_event.dart';
import 'package:flutter_app_template/features/initial/initial_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template_package/analytics/base_analytics.dart';
import 'package:template_package/primary_states/common.dart';
import 'package:template_package/template_bloc/template_bloc.dart';
import 'package:template_package/template_package.dart';

class InitialBloc extends TemplateBloc {
  final SomeUseCase useCase;
  final ImagePicker _imagePicker = ImagePicker();
  final scoreDataStateController = StreamController<ScoreDataState>();
  final prizeDataState = StreamController<PrizeDateState>();

  InitialBloc(BaseAnalytics analytics, this.useCase) : super(analytics) {
    registerStreams([
      scoreDataStateController.stream,
      prizeDataState.stream,
    ]);
    init();
  }

  void init() async {
    scoreDataStateController.sink.add(ScoreDataState(opponents: []));
    fetchScoreData();
    fetchPrizeData();
  }

  @override
  void onUiDataChange(BaseBlocEvent event) {
    if (event is RemovePointEvent) {
      removePoint(event.opponent);
    } else if (event is AddPointEvent) {
      addPoint(event.opponent);
    } else if (event is PrizeLongPressedEvent) {
      onPrizeLongPressed();
    }
  }

  void onPrizeLongPressed() async {
    final XFile? file = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      saveImageUrl(file.path);
    }
  }

  void saveImageUrl(String filePath) {
    final requestObserver = RequestObserver(
        requestData: filePath,
        onListen: (String? imageUrl) {
          sinkState!.add(MaybePopState());
          prizeDataState.sink.add(PrizeDateState(imageUrl: imageUrl ?? ''));
        },
        onError: (Error e) {
          LoggerDefault.log.e('error could not get prize url');
        });
    useCase.saveImageUrl(requestObserver);
  }

  void fetchPrizeData() {
    final requestObserver = RequestObserver(onListen: (String? imageUrl) {
      prizeDataState.sink.add(PrizeDateState(imageUrl: imageUrl ?? ''));
    }, onError: (Error e) {
      LoggerDefault.log.e('error could not get prize url');
    });
    useCase.getPrizeUrl(requestObserver);
  }

  void removePoint(Opponent opponent) {
    if (opponent.points > 0) {
      opponent.points = opponent.points - 1;
      setPoint(opponent);
    }
  }

  void addPoint(Opponent opponent) {
    opponent.points = opponent.points + 1;
    setPoint(opponent);
  }

  void setPoint(Opponent opponent) {
    final requestObserver = RequestObserver(
        requestData: opponent,
        onListen: (SomeModel? someModel) {},
        onError: (Error e) {
          LoggerDefault.log.e('error could not set points');
        });
    useCase.setPoints(requestObserver);
  }

  void fetchScoreData() {
    useCase.getSomeData(RequestObserver(onListen: (SomeModel? someModel) {
      final List<Opponent> opponentsResult = someModel?.opponents ?? [];
      scoreDataStateController.sink.add(ScoreDataState(opponents: opponentsResult.toList()));
    }, onError: (Error e) {
      sinkState?.add(ErrorFullScreenState(
          error: e,
          onCtaTap: () {
            sinkState?.add(MaybePopState());
          }));
    }));
  }

  @override
  void dispose() {
    scoreDataStateController.close();
    prizeDataState.close();
    super.dispose();
  }
}
