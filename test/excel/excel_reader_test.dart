import 'package:excel/excel.dart';
import 'package:random_generators/modules/excel/excel_file_builder.dart';
import 'package:random_generators/modules/excel/excel_reader.dart';
import 'package:test/test.dart';

main() {
  group("ExcelReader", () {
    test("Reads a sheet correctly", () {
      List<double> randomNumbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

      Excel excel = ExcelFileBuilder(randomNumbers: randomNumbers).buildExcel();
      var excelReader = ExcelReader(book: excel);

      expect(excelReader.getNumbers(), randomNumbers);
    });
  });
}
