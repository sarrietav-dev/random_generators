import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:random_generators/components/number_list.dart';
import 'package:random_generators/models/generator_state.dart';

class RandomNumbersPanel extends StatelessWidget {
  const RandomNumbersPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<GeneratorState>(
      child: getDiceBackground(),
      builder: (context, value, child) {
        if (value.numbers.isNotEmpty) {
          return Expanded(
            child: ListView(
              children: [
                NumberList(numbers: value.numbers),
              ],
            ),
          );
        } else {
          return child!;
        }
      },
    );
  }

  Expanded getDiceBackground() {
    return Expanded(
      child: Center(
        child: FaIcon(FontAwesomeIcons.dice,
            size: 150, color: Colors.grey.shade300),
      ),
    );
  }
}