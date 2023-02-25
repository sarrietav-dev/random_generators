import 'dart:io';

import 'package:excel/excel.dart';

class ExcelFileBuilder {
  final List<int> randomNumbers;
  String filePath;

  ExcelFileBuilder(
      {required this.randomNumbers, this.filePath = 'random_numbers.xlsx'});

  build() {
    final excel = Excel.createExcel();

    final Sheet sheetObject = excel['Sheet1'];

    for (int i = 0; i < randomNumbers.length; i++) {
      sheetObject.cell(CellIndex.indexByString('A${i + 1}')).value =
          randomNumbers[i];
    }

    final List<int>? bytes = excel.encode();

    File(filePath).writeAsBytes(bytes!);
  }
}
