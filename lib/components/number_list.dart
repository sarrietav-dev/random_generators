import 'package:flutter/material.dart';

class NumberList<T> extends StatelessWidget {
  const NumberList({super.key, required this.numbers});

  final List<T> numbers;

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const [
        DataColumn(label: Text("Number"), tooltip: "Random numbers generated"),
      ],
      rows: numbers
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
  }
}
