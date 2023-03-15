import 'package:flutter/material.dart';
import 'package:random_generators/modules/generator_tester_widgets/abstraction/generator_tester_widget.dart';
import 'package:random_generators/modules/generator_testers/corridas_test.dart';

class CorridasTestWidget extends GeneratorTesterWidget {
  const CorridasTestWidget({super.key, required super.numbers});

  @override
  State<CorridasTestWidget> createState() => _DistanceTestWidgetState();
}

class _DistanceTestWidgetState extends State<CorridasTestWidget> {
  @override
  Widget build(BuildContext context) {
    var test = CorridasTest(numbers: widget.numbers);
    bool testResult = test.test();

    return Tooltip(
      message: !testResult
          ? GeneratorTesterWidget.canDeny
          : GeneratorTesterWidget.cantDeny,
      child: Card(
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
              child: Text(
                  "Prueba de las corridas por encima y por debajo de la media",
                  style: TextStyle(color: Colors.white, fontSize: 25)),
            )
          ])),
    );
  }
}
