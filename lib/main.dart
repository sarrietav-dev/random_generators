import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_generators/pages/random_number_generator_page/random_number_generator_page.dart';

import 'models/generator_state.dart';
import 'models/random_variable_state.dart';

void main(List<String> args) {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => GeneratorState(),
    ),
    ChangeNotifierProvider(
      create: (context) => RandomVariableState(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:
            const RandomNumberGeneratorPage(title: "Random number generators"));
  }
}
