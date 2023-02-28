import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:random_generators/models/generator_list.dart';
import 'package:random_generators/modules/excel/excel_file_builder.dart';
import 'package:random_generators/modules/generator_widgets/generator_widget_factory.dart';
import 'package:file_picker/file_picker.dart';

class Sidebar extends StatelessWidget {
  Sidebar(
      {super.key,
      required this.generatorForm,
      required this.onGenerate,
      required this.onChangeGenerator,
      required this.onExport});

  final GeneratorFormWidget? generatorForm;
  final Function(GeneratorList generator) onChangeGenerator;
  final Function(List<int> randomNumbers) onGenerate;
  final List<int> Function() onExport;

  handleOnChange(int? dropdownEntryValue) {
    switch (dropdownEntryValue) {
      case 0:
        onChangeGenerator(GeneratorList.xorShift);
        break;
      case 1:
        onChangeGenerator(GeneratorList.mixto);
        break;
      case 2:
        onChangeGenerator(GeneratorList.multiplicativo);
        break;
      case 3:
        onChangeGenerator(GeneratorList.blumBlumShub);
        break;
    }
  }

  final Map<int, String> generators = {
    0: "XorShift",
    1: "Mixto",
    2: "Multiplicativo",
    3: "Blum Blum Shub",
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: Colors.grey.shade300,
            width: 1,
          ),
        ),
      ),
      child: SizedBox(
        width: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 20, left: 20, right: 20, bottom: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownMenu(
                        onSelected: (value) => handleOnChange(value),
                        label: const Text("Generador"),
                        dropdownMenuEntries: [
                          for (var key in generators.keys)
                            DropdownMenuEntry(
                                label: generators[key] ?? '', value: key),
                        ]),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Divider(),
                    ),
                    if (generatorForm != null)
                      Expanded(child: generatorForm!)
                    else
                      const Text("Seleccione un generador"),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: const ContinuousRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(0))),
                          minimumSize: const Size.fromHeight(50)),
                      onPressed: () async {
                        var numbers = onExport();

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

                        ExcelFileBuilder(
                                randomNumbers: numbers, filePath: result)
                            .build();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          FaIcon(FontAwesomeIcons.fileExcel, size: 20),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Exportar a Excel")
                        ],
                      )),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: const ContinuousRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(0))),
                          minimumSize: const Size.fromHeight(50)),
                      onPressed: () {
                        if (generatorForm == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Seleccione un generador"),
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                          return;
                        }
                        var formKey = generatorForm?.formState;

                        if (formKey == null) return;
                        if (!formKey.currentState!.validate()) return;
                        var numbers = generatorForm!.getNumbers();
                        onGenerate(numbers);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.casino, size: 20),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Generar")
                        ],
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _Dropdown extends StatelessWidget {
  const _Dropdown({required this.generatorNames, required this.child});

  final List<String> generatorNames;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownMenu(
                onSelected: (value) {
                  Provider.of<GeneratorState>(context, listen: false);
                },
                label: const Text("Generador"),
                dropdownMenuEntries: [
                  for (int i = 0; i < generatorNames.length; i++)
                    DropdownMenuEntry(label: generatorNames[i], value: i),
                ]),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Divider(),
            ),
            if (child != null)
              Expanded(child: child!)
            else
              const Text("Seleccione un generador"),
          ],
        ),
      ),
    );
  }
}
