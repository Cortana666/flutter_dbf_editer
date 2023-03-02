import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';

import 'table.dart' as data_table;

class Drag extends StatefulWidget {
  const Drag({super.key});

  @override
  State<Drag> createState() => _DragState();
}

class _DragState extends State<Drag> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('打开文件'),
      ),
      body: DropTarget(
        onDragDone: (detail) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  data_table.Table(startFile: detail.files[0].path),
            ),
          );
        },
        child: const Center(
          child: Text("拖入文件打开"),
        ),
      ),
    );
  }
}
