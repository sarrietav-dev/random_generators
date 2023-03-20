import 'package:flutter/material.dart';

class DistributionDropdown extends StatelessWidget {
  const DistributionDropdown(
      {super.key, required this.entries, required this.onSelected});

  final List<String> entries;
  final Function(int?) onSelected;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(dropdownMenuEntries: [
      for (int i = 0; i < entries.length; i++)
        DropdownMenuEntry(label: entries[i], value: i),
    ], onSelected: onSelected);
  }
}
