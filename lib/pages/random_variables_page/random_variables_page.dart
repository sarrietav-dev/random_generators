import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_generators/layout/page_with_sidebar.dart';
import 'package:random_generators/models/random_variable_state.dart';
import 'package:random_generators/pages/random_variables_page/components/distribution_dropdown.dart';

class RandomVariablesPage extends StatelessWidget {
  const RandomVariablesPage({super.key});

  onDropdownSelected(int? value) {
    print(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Random Variables'),
        ),
        body: Consumer<RandomVariableState>(
          builder: (context, value, child) {
            var entries = value.distributionNames;

            return PageWithSidebar(
                sidebarChild: Column(
                  children: [
                    DistributionDropdown(
                        entries: entries, onSelected: onDropdownSelected)
                  ],
                ),
                child: const Placeholder());
          },
        ));
  }
}
