import 'package:flutter/material.dart';

class NumberList<T> extends StatelessWidget {
  const NumberList(
      {super.key, required this.numbers, this.extraColumns, this.extraRows});

  final List<T> numbers;
  final List<DataColumn>? extraColumns;
  final List<DataRow>? extraRows;

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: [
        const DataColumn(
            label: Text("Numers aleatorios"),
            tooltip: "Numeros aleatorios generados"),
        ...extraColumns ?? []
      ],
      rows: [
        ...numbers
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
        ...extraRows ?? []
      ],
    );
  }
}
