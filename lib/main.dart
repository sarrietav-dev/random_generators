import 'package:flutter/material.dart';
import 'package:random_generators/components/number_list.dart';
import 'package:random_generators/modules/generator_widgets/generator_widget_factory.dart';
import 'package:random_generators/modules/generator_widgets/implementations/xor_shift_widget.dart';

import 'components/sidebar.dart';

void main(List<String> args) {
  runApp(const MyApp());
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
        home: MyHomePage(title: "Flutter Demo Home Page"));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final String title;
  final GeneratorFormWidget generatorForm = XorShiftWidget();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<int> _numbers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Row(children: [
          Sidebar(
            generatorForm: widget.generatorForm,
            onGenerate: (List<int> randomNumbers) {
              setState(() {
                _numbers = randomNumbers;
              });
            },
          ),
          Expanded(
            child: ListView(
              children: [
                NumberList(numbers: _numbers),
              ],
            ),
          )
        ]));
  }
}
