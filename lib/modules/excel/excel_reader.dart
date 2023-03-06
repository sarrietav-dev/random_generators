import 'dart:io';

import 'package:excel/excel.dart';

class ExcelReader {
  final Excel book;

  ExcelReader({required this.book});

  ExcelReader.fromPath({required String path})
      : book = Excel.decodeBytes(File(path).readAsBytesSync());

  List<double> getNumbers() {
    final Sheet sheetObject = book['Sheet1'];

    final List<double> numbers = [];

    for (int i = 0; i < sheetObject.maxRows; i++) {
      var value = sheetObject.cell(CellIndex.indexByString('A${i + 1}')).value;

      final double? number = value is int ? value.toDouble() : value;

      if (number != null) {
        numbers.add(number);
      }
    }

    return numbers;
  }
}
