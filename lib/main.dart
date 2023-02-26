import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:random_generators/components/number_list.dart';
import 'package:random_generators/modules/generator_widgets/generator_widget_factory.dart';
import 'package:random_generators/modules/generator_widgets/implementations/mixto_widget.dart';
import 'package:random_generators/modules/generator_widgets/implementations/multiplicativo_widget.dart';
import 'package:random_generators/modules/generator_widgets/implementations/xor_shift_widget.dart';

import 'components/sidebar.dart';
import 'models/generator_list.dart';
import 'modules/generator_widgets/implementations/blum_blum_shub_widget.dart';

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
        home: const MyHomePage(title: "Random number generators"));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<int> _numbers = [];
  GeneratorFormWidget? generatorForm;

  onChangeGenerator(GeneratorList generator) {
    setState(() {
      switch (generator) {
        case GeneratorList.xorShift:
          generatorForm = XorShiftWidget();
          break;
        case GeneratorList.mixto:
          generatorForm = MixtoWidget();
          break;
        case GeneratorList.multiplicativo:
          generatorForm = MultiplicativoWidget();
          break;
        case GeneratorList.blumBlumShub:
          generatorForm = BlumBlumShubWidget();
          break;
      }
      _numbers = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Row(children: [
          Sidebar(
            onChangeGenerator: onChangeGenerator,
            onExport: () => _numbers,
            generatorForm: generatorForm,
            onGenerate: (List<int> randomNumbers) {
              setState(() {
                _numbers = randomNumbers;
              });
            },
          ),
          if (_numbers.isNotEmpty)
            Expanded(
              child: ListView(
                children: [
                  NumberList(numbers: _numbers),
                ],
              ),
            )
          else
            const Expanded(
              child: Center(
                child: FaIcon(FontAwesomeIcons.dice,
                    size: 150, color: Colors.grey),
              ),
            )
        ]));
  }
}
