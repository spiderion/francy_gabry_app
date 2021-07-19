import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_template/features/initial/initial_state.dart';
import 'package:template_package/base_widget/base_widget.dart';
import 'package:template_package/template_bloc/template_bloc.dart';
import 'package:template_package/template_package.dart';

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
          return Scaffold(
              floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              body: Center(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Flexible(child: prizeWidget()),
                    ...snapshot.data!.opponents.map((e) => track(e.name, e.points)),
                    SizedBox(height: 30),
                    buttons(),
                    SizedBox(height: 30),
                  ],
                ),
              )));
        });
  }

  Widget prizeWidget() {
    return Column(
      children: [
        Text('PREMIO', style: TextStyle(fontSize: 40)),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Flexible(child: Image.asset('assets/images/rc-car-removebg-preview.png'))]),
      ],
    );
  }

  Widget track(String userName, int points) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(userName),
            SizedBox(width: 8),
            Text(points.toString(), style: TextStyle(fontSize: 11)),
          ],
        ),
        SizedBox(height: 8),
        LinearProgressIndicator(value: points / 100),
      ],
    );
  }

  Widget buttons() {
    return Container();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            addRemoveButton('Francy'),
            addRemoveButton('Gabry'),
          ],
        ),
      ),
    );
  }

  Widget addRemoveButton(String name) {
    return Row(
      children: [
        FloatingActionButton(onPressed: () {}, child: Icon(Icons.remove)),
        Padding(padding: const EdgeInsets.all(12.0), child: Text(name)),
        FloatingActionButton(onPressed: () {}, child: Icon(Icons.add)),
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
