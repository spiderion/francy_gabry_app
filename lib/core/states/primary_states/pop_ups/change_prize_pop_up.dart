import 'package:flutter/material.dart';
import 'package:template_package/template_package.dart';

class ShowChangePrizePopUp extends BaseBlocPrimaryState {
  final Function(String? imageUrl) onSaveClick;
  String? imageUrl;

  ShowChangePrizePopUp({required this.onSaveClick});

  @override
  void call(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (String value) {
                  imageUrl = value;
                },
                decoration: InputDecoration(hintText: Translations.of(context)!.text('enter_image_url')),
              ),
              SizedBox(height: 50),
              ElevatedButton(
                  onPressed: () => onSaveClick.call(imageUrl),
                  child: Text(Translations.of(context)!.text('save'))),
            ],
          ));
        });
  }
}
