import 'package:flutter/material.dart';
import 'package:random_generators/modules/generator_widgets/generator_widget_factory.dart';

class Sidebar extends StatelessWidget {
  const Sidebar(
      {super.key, required this.generatorForm, required this.onGenerate});

  final GeneratorFormWidget generatorForm;
  final Function(List<int> randomNumbers) onGenerate;

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
                    const DropdownMenu(
                        label: Text("Generador"),
                        dropdownMenuEntries: [
                          DropdownMenuEntry(label: "XORShift", value: 1),
                        ]),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Divider(),
                    ),
                    Expanded(
                      child: generatorForm,
                    ),
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
                        var numbers = generatorForm.getNumbers();
                        onGenerate(numbers);
                      },
                      child: const Text("Generar")),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
