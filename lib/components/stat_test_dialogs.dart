import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_generators/helpers/values_in_zero_and_one_checker.dart';
import 'package:random_generators/models/generator_state.dart';
import 'package:random_generators/modules/excel/excel_reader.dart';
import 'package:random_generators/pages/stat_tester_page/stat_tester_page.dart';

class ImportDialog extends StatelessWidget {
  const ImportDialog({
    super.key,
  });

  Future<String?> readFile() async {
    FilePickerResult? filePath = await FilePicker.platform.pickFiles();

    if (filePath != null) {
      return filePath.files.single.path!;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Importar números"),
      content: const Text("Deseas importar los números o usar generados?"),
      actions: [
        TextButton(
            onPressed: () {
              var numbers = Provider.of<GeneratorState>(context, listen: false)
                  .numbers
                  .map((e) => e.toDouble())
                  .toList();

              validateNumberFormatAndPushRoute(numbers, context);
            },
            child: const Text("Generados")),
        TextButton(
            onPressed: () {
              readFile().then((path) {
                if (path != null) {
                  var numbers = ExcelReader.fromPath(path: path).getNumbers();

                  validateNumberFormatAndPushRoute(numbers, context);
                }
              });
            },
            child: const Text("Importar de Excel")),
      ],
    );
  }

  void validateNumberFormatAndPushRoute(
      List<double> numbers, BuildContext context) {
    if (!areNumbersBetweenZeroAndOne(numbers)) {
      showInvalidPopup(context, numbers);
    } else {
      showTestsPage(context, numbers);
    }
  }

  void showTestsPage(BuildContext context, List<double> numbers) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return StatTesterPage(numbers: numbers);
      },
    ));
  }

  void showInvalidPopup(BuildContext context, List<double> numbers) {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) {
        return InvalidNumberFormatDialog(
          numbers: numbers,
        );
      },
    );
  }
}

class InvalidNumberFormatDialog extends StatelessWidget {
  const InvalidNumberFormatDialog({super.key, required this.numbers});

  final List<double> numbers;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Advertencia"),
      content: const Text("Los números no están entre 0 y 1.\n"
          "Esto puede causar errores en los test. \n"
          "Se puede continuar realizando una conversión dividiendo todos los números entre el mayor de ellos.\n"
          "Si no se desea realizar la conversión, se puede cancelar el test o continuar"),
      actions: [
        TextButton(
            onPressed: () {
              convertAndPushRoute(context);
            },
            child: const Text("Convertir")),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StatTesterPage(numbers: numbers),
                  ));
            },
            child: const Text("Continuar")),
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"))
      ],
    );
  }

  void convertAndPushRoute(BuildContext context) {
    var max =
        numbers.reduce((value, element) => value > element ? value : element);

    var numbersDivided = numbers.map((e) => e / (max + 1)).toList();

    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StatTesterPage(numbers: numbersDivided),
        ));
  }
}
