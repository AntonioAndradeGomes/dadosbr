import 'package:dadosbr/app_module.dart';
import 'package:dadosbr/app_widget.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await appModule();
  runApp(const AppWidget());
}
