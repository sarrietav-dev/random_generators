import 'dart:io';

import 'package:excel/excel.dart';

class ExcelFileBuilder {
  final List<double> randomNumbers;
  String filePath;

  ExcelFileBuilder(
      {required this.randomNumbers, this.filePath = 'random_numbers.xlsx'});

  Excel buildExcel() {
    final excel = Excel.createExcel();

    final Sheet sheetObject = excel['Sheet1'];

    for (int i = 0; i < randomNumbers.length; i++) {
      sheetObject.cell(CellIndex.indexByString('A${i + 1}')).value =
          randomNumbers[i];
    }

    return excel;
  }

  build() {
    final excel = buildExcel();

    final bytes = excel.encode();

    File(filePath).writeAsBytes(bytes!);
  }
}
