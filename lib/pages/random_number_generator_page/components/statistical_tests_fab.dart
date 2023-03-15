import 'package:flutter/material.dart';
import 'package:random_generators/components/stat_test_dialogs.dart';

class StatisticalTestsFAB extends StatelessWidget {
  const StatisticalTestsFAB({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.green,
      child: const Icon(Icons.science),
      onPressed: () {
        handleOnPressed(context);
      },
    );
  }

  Future<dynamic> handleOnPressed(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return const ImportDialog();
      },
    );
  }
}