import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_generators/pages/random_variables_page/random_variables_page.dart';

import 'models/generator_state.dart';

void main(List<String> args) {
  runApp(ChangeNotifierProvider(
      create: (context) {
        return GeneratorState();
      },
      child: const MyApp()));
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
        home: const RandomVariablesPage());
    //const RandomNumberGeneratorPage(title: "Random number generators"));
  }
}
