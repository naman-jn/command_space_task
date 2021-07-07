import 'package:flutter/material.dart';
import 'package:command_space_task/provider/data_provider.dart';
import 'package:command_space_task/views/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DataProvider>(
        create: (_) => DataProvider(),
        builder: (context, snapshot) {
          return MaterialApp(
            home: HomePage(),
          );
        });
  }
}
