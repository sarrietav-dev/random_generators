import 'package:flutter/material.dart';
import 'package:random_generators/layout/page_with_sidebar.dart';

class RandomVariablesPage extends StatelessWidget {
  const RandomVariablesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Random Variables'),
        ),
        body: const PageWithSidebar(
            sidebarChild: Placeholder(), child: Placeholder()));
  }
}
