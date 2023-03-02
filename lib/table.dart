import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'dbf_controller.dart';
import 'table_source.dart';

class Table extends StatefulWidget {
  const Table({super.key, required this.startFile});
  final String startFile;

  @override
  State<Table> createState() => _TableState();
}

class _TableState extends State<Table> {
  DbfController dbfController = DbfController();
  final TableSource tableSource = TableSource();

  bool readDone = false;

  @override
  void initState() {
    super.initState();
    initDbf();
  }

  void initDbf() async {
    dbfController = await compute(dbfController.init, widget.startFile);
    tableSource.init(context, dbfController.field, dbfController.data);
    setState(() {
      readDone = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.startFile),
      ),
      body: readDone
          ? SingleChildScrollView(
              child: PaginatedDataTable(
                // actions: [Text('actions')],
                // arrowHeadColor: Colors.red, // 切换首尾页按钮颜色
                availableRowsPerPage: const [20, 50, 100, 200, 500],
                // checkboxHorizontalMargin: 2.0, // 复选框周围的水平边距
                columns: dbfController.field.keys.map((field) {
                  return DataColumn(
                    label: Container(
                      // width: 70,
                      // height: 30,
                      // color: Colors.grey[300],
                      // child: Center(
                      child: Text(field),
                      // ),
                    ),
                  );
                }).toList(),
                // columnSpacing: 50.0, // 每列之间的水平间距
                // dataRowHeight: 50.0, // 每行的高度
                // header: Text('header'), // 首行头部widget
                // headingRowHeight: 30.0, // 标题行的高度
                // horizontalMargin: 100.0, // 表格边缘与每行第一个和最后一个单元格中的内容之间的水平边距
                // initialFirstRowIndex: 0, // 首次创建小部件时要显示的第一行的索引
                // key: GlobalKey, // 控制一个小部件如何替换树中的另一个小部件
                // onPageChanged: (value) {
                //   print(value);
                // },
                onRowsPerPageChanged: (value) {
                  tableSource.rowsPerPage = value!;
                  setState(() {});
                },
                // onSelectAll: (value) {},
                rowsPerPage: tableSource.rowsPerPage,
                // showCheckboxColumn: true,
                showFirstLastButtons: true,
                // sortAscending: false,
                // sortColumnIndex: null,
                source: tableSource,
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
