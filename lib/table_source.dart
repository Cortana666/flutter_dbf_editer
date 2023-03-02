import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'table_source_state.dart';

class TableSource extends DataTableSource {
  TableSourceState tableSourceState = TableSourceState();

  int rowsPerPage = 20;

  List<Map<String, dynamic>> sourceData = [];
  List<Map<String, dynamic>> list = [];
  Map<String, Map<String, dynamic>> field = {};
  late BuildContext tableContext;

  void init(BuildContext context, Map<String, Map<String, dynamic>> dbfField,
      List<Map<String, dynamic>> dbfData) {
    sourceData = dbfData;
    list = sourceData;
    field = dbfField;
    tableContext = context;
  }

  @override
  DataRow? getRow(int index) {
    return DataRow(
      cells: field.keys.map((e) {
        return DataCell(
          ChangeNotifierProvider(
            create: (tableContext) => tableSourceState,
            child: Container(
              child: Provider.of<TableSourceState>(tableContext).selectUnit ==
                      '{$index}-{$e}'
                  ? TextField()
                  : SelectableText(
                      list[index][e].toString(),
                    ),
            ),
          ),
          onTap: () {
            Provider.of<TableSourceState>(tableContext, listen: false)
                .setSelectUnit('{$index}-{$e}');
          },
        );
      }).toList(),
    );
  }

  @override
  int get rowCount => list.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;

  // String keyword = '';
  // List<int> select = [];
  // // late Dbf dbfController;
  // late BuildContext mainContext;
  // List<Map<String, dynamic>> sourceData = [];
  // List<Map<String, dynamic>> list = [];
//   Map<int, Map<String, TextEditingController>> dataController = {};

  // void init(BuildContext context, List<Map<String, dynamic>> dbfData) {
  //   // dbfController = dbf;
  //   // mainContext = context;
  //   // keyword = '';
  //   sourceData = dbfData;
  //   list = sourceData;
  //   // select = [];
  //   // dataController = {};
  // }

//   void sort(String key, bool ascSort) {
//     list.sort((a, b) {
//       if (ascSort) {
//         return a[key].compareTo(b[key]);
//       } else {
//         return b[key].compareTo(a[key]);
//       }
//     });
//     flush();
//   }

//   void sync() {
//     // if (keyword.isNotEmpty) {
//     //   list = [];
//     //   for (var i = 0; i < dbfController.data.length; i++) {
//     //     bool isHave = false;
//     //     dbfController.data[i].forEach((key, value) {
//     //       if (value == keyword) {
//     //         isHave = true;
//     //       }
//     //     });

//     //     if (isHave) {
//     //       list.add(dbfController.data[i]);
//     //     }
//     //   }
//     // } else {
//     //   list = dbfController.data;
//     // }
//   }

  void flush() {
    notifyListeners();
  }

  // @override
  // DataRow? getRow(int index) {
  //   List<DataCell> row = [];
  // dbfController.field.forEach((key, value) {
  //   row.add(DataCell(
  //     TextField(
  //       controller: dataController[list[index]['_selfkey']]![key],
  //       onChanged: (String val) {
  //         Map<String, dynamic> res =
  //             dbfController.edit(list[index]['_selfkey'], key, val);
  //         if (res['code'] == 1) {
  //           for (var element in dbfController.data) {
  //             if (element['_selfkey'] == list[index]['_selfkey']) {
  //               element[key] = val;
  //             }
  //           }
  //         } else {
  //           for (var element in dbfController.data) {
  //             if (element['_selfkey'] == list[index]['_selfkey']) {
  //               dataController[list[index]['_selfkey']]![key]?.text =
  //                   element[key];
  //             }
  //           }
  //           ScaffoldMessenger.of(mainContext).showSnackBar(
  //             SnackBar(
  //               content: Text(res['message']),
  //               duration: const Duration(milliseconds: 1000),
  //               backgroundColor: Colors.red,
  //             ),
  //           );
  //         }
  //       },
  //       decoration: const InputDecoration(
  //         border: OutlineInputBorder(),
  //         enabledBorder: InputBorder.none,
  //       ),
  //     ),
  //   ));
  // });

  //   return DataRow(
  //     cells: row,
  //     // selected: select.contains(list[index]['_selfkey']),
  //     // onSelectChanged: (selected) {
  //     //   if (selected!) {
  //     //     select.add(list[index]['_selfkey']);
  //     //   } else {
  //     //     select.remove(list[index]['_selfkey']);
  //     //   }
  //     //   flush();
  //     // },
  //   );
  // }

  // @override
  // int get rowCount => list.length;

  // @override
  // bool get isRowCountApproximate => false;

  // @override
  // int get selectedRowCount => 0;
}
