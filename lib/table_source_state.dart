import 'package:flutter/foundation.dart';

class TableSourceState extends ChangeNotifier {
  String selectUnit = '';

  void setSelectUnit(String unit) {
    selectUnit = unit;
    notifyListeners();
  }
}
