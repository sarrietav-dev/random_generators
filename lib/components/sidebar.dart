import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:random_generators/models/generator_state.dart';
import 'package:random_generators/modules/excel/excel_file_builder.dart';
import 'package:file_picker/file_picker.dart';
import 'package:random_generators/modules/generator_widgets/implementations/xor_shift_widget.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

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
                child: _SidebarHeader(
                    child: Consumer<GeneratorState>(
                        builder: (context, value, child) =>
                            value.currentGenerator ??
                            const Text("Seleccione un generador"),
                        child: XorShiftWidget()))),
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
  const _SidebarHeader({required this.child});

  final Widget? child;

  Widget _divider() {
    return const Divider();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
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
  const _Dropdown();

  @override
  Widget build(BuildContext context) {
    var generatorNames =
        Provider.of<GeneratorState>(context, listen: false).generatorNames;
    return DropdownMenu(
        onSelected: (value) {
          if (value != null) {
            Provider.of<GeneratorState>(context, listen: false)
                .changeGenerator(value);
          }
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
