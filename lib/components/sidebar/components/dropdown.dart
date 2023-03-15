import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_generators/models/generator_state.dart';

class SidebarDropdown extends StatelessWidget {
  const SidebarDropdown({super.key});

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
