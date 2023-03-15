import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:random_generators/models/generator_state.dart';
import 'package:random_generators/modules/excel/excel_file_builder.dart';

class ExcelButton extends StatelessWidget {
  const ExcelButton({super.key});

  handlePressed(BuildContext context) async {
    var numbers = Provider.of<GeneratorState>(context, listen: false).numbers;

    if (numbers.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No hay números para exportar"),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    var result = await FilePicker.platform.saveFile(
        fileName: "random-numbers.xlsx",
        type: FileType.custom,
        allowedExtensions: ["xlsx"]);

    if (result == null) return;

    ExcelFileBuilder(randomNumbers: numbers, filePath: result).build();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape: const ContinuousRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(0))),
            minimumSize: const Size.fromHeight(50)),
        onPressed: () => handlePressed(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            FaIcon(FontAwesomeIcons.fileExcel, size: 20),
            SizedBox(
              width: 10,
            ),
            Text("Exportar a Excel")
          ],
        ));
  }
}
