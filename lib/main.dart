import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'table.dart' as data_table;
import 'drag.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  final startFile = await getStartFile(args);

  runApp(MyApp(
    startFile: startFile,
  ));
}

Future<String> getStartFile(List<String> args) async {
  if (args.isNotEmpty) return args.first;
  if (Platform.isMacOS) {
    const hostApi = MethodChannel("myChannel");
    final String? currentFile = await hostApi.invokeMethod("getCurrentFile");
    if (currentFile != null) return currentFile;
  }
  return "";
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.startFile});
  final String startFile;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DBF Editer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: widget.startFile.isEmpty
          ? const Drag()
          : data_table.Table(startFile: widget.startFile),
    );
  }
}
