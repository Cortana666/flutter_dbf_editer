import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.startFile});
  final String startFile;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(startFile),
        ),
        body: Center(
          child: ElevatedButton(onPressed: () async {}, child: Text(startFile)),
        ),
      ),
    );
  }
}
