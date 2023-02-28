import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:random_generators/components/generator_form_template.dart';
import 'package:random_generators/models/generator_list.dart';
import 'package:random_generators/models/generator_state.dart';
import 'package:random_generators/modules/excel/excel_file_builder.dart';
import 'package:random_generators/modules/generator_widgets/generator_widget_factory.dart';
import 'package:file_picker/file_picker.dart';
import 'package:random_generators/modules/generator_widgets/implementations/xor_shift_widget.dart';

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
            Expanded(child: _SidebarHeader(child: XorShiftWidget())),
            Row(
              children: const [
                Expanded(
                  child: ExcelButton(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SidebarHeader extends StatelessWidget {
  const _SidebarHeader({this.generatorNames = const [], required this.child});

  final List<String> generatorNames;
  final Widget? child;

  Widget _divider() {
    return Divider();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: _Dropdown(),
        ),
        _divider(),
        if (child != null)
          Expanded(child: child!)
        else
          const Text("Seleccione un generador"),
      ],
    );
  }
}

class _Dropdown extends StatelessWidget {
  _Dropdown();

  // TODO: Get generator names from the global state
  List<String> generatorNames = [
    "XorShift",
    "Mixto",
    "Multiplicativo",
    "Blum Blum Shub"
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
        onSelected: (value) {
          Provider.of<GeneratorState>(context, listen: false);
        },
        label: const Text("Generador"),
        dropdownMenuEntries: [
          for (int i = 0; i < generatorNames.length; i++)
            DropdownMenuEntry(label: generatorNames[i], value: i),
        ]);
  }
}

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

class GenerateButton extends StatelessWidget {
  const GenerateButton({super.key, required this.onPressed});

  final Function onPressed;

  handleOnPressed(BuildContext context) {
    var generatorForm;
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
    // onGenerate(numbers);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: const ContinuousRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(0))),
            minimumSize: const Size.fromHeight(50)),
        onPressed: () => onPressed(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.casino, size: 20),
            SizedBox(
              width: 10,
            ),
            Text("Generar")
          ],
        ));
  }
}
