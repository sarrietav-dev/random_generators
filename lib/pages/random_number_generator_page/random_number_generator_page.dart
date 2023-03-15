import 'package:flutter/material.dart';
import 'package:random_generators/components/sidebar.dart';
import 'package:random_generators/pages/random_number_generator_page/components/random_numbers_panel.dart';

import 'components/statistical_tests_fab.dart';

class RandomNumberGeneratorPage extends StatelessWidget {
  const RandomNumberGeneratorPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        floatingActionButton: const StatisticalTestsFAB(),
        body: Row(children: const [Sidebar(), RandomNumbersPanel()]));
  }
}
