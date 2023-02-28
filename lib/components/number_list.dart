import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_generators/models/generator_state.dart';

class NumberList extends StatelessWidget {
  const NumberList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GeneratorState>(
      builder: (context, state, child) {
        return DataTable(
          columns: const [
            DataColumn(
                label: Text("Number"), tooltip: "Random numbers generated"),
          ],
          rows: state.numbers
              .map(
                (number) => DataRow(
                  cells: [
                    DataCell(
                      Text(number.toString()),
                    )
                  ],
                ),
              )
              .toList(),
        );
      },
    );
  }
}
