import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_generators/models/generator_state.dart';

import 'components/excel_button.dart';
import 'components/header.dart';

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
                child: SidebarHeader(
                    child: Consumer<GeneratorState>(
              builder: (context, value, child) =>
                  value.currentGenerator ??
                  const Text("Seleccione un generador"),
            ))),
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
