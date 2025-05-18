import 'package:evolution2048/app.dart';
import 'package:evolution2048/core/startup/app_config.dart';
import 'package:flutter/material.dart';

void main() async {
await AppConfig.setup();
  runApp(const MyApp());
}
