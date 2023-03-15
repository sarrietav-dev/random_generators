import 'package:flutter/material.dart';
import 'package:random_generators/components/sidebar/components/dropdown.dart';

class SidebarHeader extends StatelessWidget {
  const SidebarHeader({super.key, required this.child});

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
            child: SidebarDropdown()),
        _divider(),
        if (child != null)
          Expanded(child: child!)
        else
          const Text("Seleccione un generador"),
      ],
    );
  }
}
