import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_template/app.dart';
import 'package:flutter_app_template/dependency/dependency_module.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final dependencyModule = DependencyModule();
  final subModules = dependencyModule.getReadySubModules();
  runApp(App(subModules));
}
