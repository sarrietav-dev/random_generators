import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:random_generators/components/number_list.dart';
import 'package:random_generators/modules/excel/excel_reader.dart';
import 'package:random_generators/modules/stat_tester_widget/stat_tester_widget.dart';

import 'components/sidebar.dart';
import 'models/generator_state.dart';

void main(List<String> args) {
  runApp(ChangeNotifierProvider(
      create: (context) {
        return GeneratorState();
      },
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: "Random number generators"));
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          child: const Icon(Icons.science),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return renderAlertDialog(context);
              },
            );
          },
        ),
        body: Row(children: [
          const Sidebar(),
          Consumer<GeneratorState>(
            child: Expanded(
              child: Center(
                child: FaIcon(FontAwesomeIcons.dice,
                    size: 150, color: Colors.grey.shade300),
              ),
            ),
            builder: (context, value, child) {
              if (value.numbers.isNotEmpty) {
                return Expanded(
                  child: ListView(
                    children: [
                      NumberList(numbers: value.numbers),
                    ],
                  ),
                );
              } else {
                return child!;
              }
            },
          )
        ]));
  }

  Future<String?> readFile() async {
    FilePickerResult? filePath = await FilePicker.platform.pickFiles();

    if (filePath != null) {
      return filePath.files.single.path!;
    } else {
      return null;
    }
  }

  AlertDialog renderAlertDialog(BuildContext context) {
    return AlertDialog(
      title: const Text("Importar números"),
      content: const Text("Deseas importar los números o usar generados?"),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StatTesterWidget(
                      numbers: List.filled(100, 0),
                    ),
                  ));
            },
            child: const Text("Generados")),
        TextButton(
            onPressed: () {
              readFile().then((path) {
                Navigator.pop(context);
                if (path != null) {
                  var numbers = ExcelReader.fromPath(path: path).getNumbers();
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return StatTesterWidget(
                        numbers: numbers,
                      );
                    },
                  ));
                }
              });
            },
            child: const Text("Importar de Excel")),
      ],
    );
  }
}
