import 'package:flutter/material.dart';

class PageWithSidebar extends StatelessWidget {
  const PageWithSidebar(
      {super.key, required this.sidebarChild, required this.child});

  final Widget sidebarChild;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(
                color: Colors.grey.shade300,
                width: 1,
              ),
            ),
          ),
          child: SizedBox(width: 300, child: sidebarChild),
        ),
        Expanded(child: child)
      ],
    );
  }
}
