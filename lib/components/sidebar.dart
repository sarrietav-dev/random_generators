import 'package:flutter/material.dart';
import 'package:random_generators/models/generator_list.dart';
import 'package:random_generators/modules/generator_widgets/generator_widget_factory.dart';

class Sidebar extends StatelessWidget {
  Sidebar(
      {super.key,
      required this.generatorForm,
      required this.onGenerate,
      required this.onChangeGenerator});

  final GeneratorFormWidget? generatorForm;
  final Function(GeneratorList generator) onChangeGenerator;
  final Function(List<int> randomNumbers) onGenerate;

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
    }
  }

  final Map<int, String> generators = {
    0: "XorShift",
    1: "Mixto",
    2: "Multiplicativo",
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
                          backgroundColor: Colors.blue,
                          shape: const ContinuousRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(0))),
                          minimumSize: const Size.fromHeight(50)),
                      onPressed: () {
                        if (generatorForm == null) return;
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
