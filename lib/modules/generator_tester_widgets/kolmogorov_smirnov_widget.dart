import 'package:flutter/material.dart';
import 'package:random_generators/modules/generator_tester_widgets/abstraction/generator_tester_widget.dart';
import 'package:random_generators/modules/generator_testers/kolmogorov_smirnov.dart';

class KolmogorovSmirnovWidget extends GeneratorTesterWidget {
  const KolmogorovSmirnovWidget({super.key, required super.numbers});

  @override
  State<KolmogorovSmirnovWidget> createState() =>
      _KolmogorovSmirnovWidgetState();
}

class _KolmogorovSmirnovWidgetState extends State<KolmogorovSmirnovWidget> {
  @override
  Widget build(BuildContext context) {
    var test = KolmogorovSmirnovTest(numbers: widget.numbers);
    bool testResult = test.test();

    return Card(
        color: widget.getColor(testResult),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Center(
                    child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100)),
                )),
                Center(
                  child: Icon(
                    testResult ? Icons.check : Icons.close,
                  ),
                )
              ],
            ),
          ),
          const Expanded(
            flex: 3,
            child: Text("Prueba de Kolmogorov-Smirnov",
                style: TextStyle(color: Colors.white, fontSize: 25)),
          )
        ]));
  }
}
