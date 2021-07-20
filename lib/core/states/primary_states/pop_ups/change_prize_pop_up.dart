import 'package:flutter/material.dart';
import 'package:template_package/template_package.dart';

class ShowModalReset extends BaseBlocPrimaryState {
  final Function() onResetClick;

  ShowModalReset({required this.onResetClick});

  @override
  void call(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  Translations.of(context)!.text("reset_points"),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                    onPressed: () {
                      onResetClick.call();
                    },
                    child: Text(Translations.of(context)!.text('reset'))),
              )
            ],
          );
        });
  }
}
