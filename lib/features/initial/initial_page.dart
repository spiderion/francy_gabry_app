import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_template/core/models/opponent.dart';
import 'package:flutter_app_template/features/initial/initial_state.dart';
import 'package:template_package/base_widget/base_widget.dart';
import 'package:template_package/template_bloc/template_bloc.dart';
import 'package:template_package/template_package.dart';

import 'initial_event.dart';

class InitialPage extends BaseWidget {
  InitialPage(TemplateBloc Function() getBloc) : super(getBloc);

  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends BaseState<InitialPage, BaseBloc> {
  @override
  Widget build(BuildContext context) => mainWidget();

  Widget mainWidget() {
    return StreamBuilder<ScoreDataState>(
        stream: bloc.getStreamOfType<ScoreDataState>(),
        builder: (BuildContext context, AsyncSnapshot<ScoreDataState> snapshot) {
          if (snapshot.data == null) return Material(child: Center(child: Text('Loading')));
          return Scaffold(
              appBar: AppBar(
                title: Text('PREMIO', style: TextStyle(fontSize: 30)),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              body: SingleChildScrollView(
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 40),
                      prizeWidget(),
                      SizedBox(height: 40),
                      ...snapshot.data!.opponents.map((e) => trackWithButton(e)),
                      SizedBox(height: 40),
                    ],
                  ),
                )),
              ));
        });
  }

  Widget prizeWidget() {
    return StreamBuilder(
        stream: bloc.getStreamOfType<PrizeDateState>(),
        builder: (context, AsyncSnapshot<PrizeDateState> snapshot) {
          if (snapshot.data == null) return Center(child: Text('Loading'));
          return InkWell(
            onLongPress: () {
              if (!kIsWeb) bloc.event.add(PrizeLongPressedEvent('on_prize_long_pressed'));
            },
            child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Flexible(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(snapshot.data!.imageUrl)))
                ]),
              ],
            ),
          );
        });
  }

  Widget trackWithButton(Opponent opponent) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(opponent.name),
            SizedBox(width: 8),
            Text(opponent.points.toString(), style: TextStyle(fontSize: 11)),
          ],
        ),
        SizedBox(height: 8),
        LinearProgressIndicator(
          value: opponent.points / 200,
          backgroundColor: Colors.white24,
        ),
        SizedBox(height: 20),
        addRemoveButton(opponent),
        SizedBox(height: 50)
      ],
    );
  }

  Widget buttons(List<Opponent> opponents) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: opponents.map((e) => addRemoveButton(e)).toList()),
      ),
    );
  }

  Widget addRemoveButton(Opponent opponent) {
    if (kIsWeb) return Container();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FloatingActionButton(
            onPressed: () {
              bloc.event.add(RemovePointEvent('remove_point', opponent: opponent));
            },
            child: Icon(Icons.remove),
            backgroundColor: Colors.red),
        Padding(padding: const EdgeInsets.all(12.0), child: Text(opponent.name)),
        FloatingActionButton(
            onPressed: () {
              bloc.event.add(AddPointEvent('add_point', opponent: opponent));
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.blue),
      ],
    );
  }

  Widget getCustomWidget(bool isHorizontalStyle) {
    return FlutterLogo(
      size: isHorizontalStyle
          ? MediaQuery.of(context).size.width * 0.8
          : MediaQuery.of(context).size.width * 0.5,
      duration: Duration(seconds: 3),
      style: isHorizontalStyle == true ? FlutterLogoStyle.horizontal : FlutterLogoStyle.markOnly,
    );
  }
}
