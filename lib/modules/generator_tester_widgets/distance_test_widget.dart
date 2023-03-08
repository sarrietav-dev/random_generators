import 'package:flutter/material.dart';
import 'package:random_generators/modules/generator_tester_widgets/abstraction/generator_tester_widget.dart';
import 'package:random_generators/modules/generator_testers/distance_test.dart';

class DistanceTestWidget extends GeneratorTesterWidget {
  const DistanceTestWidget({super.key, required super.numbers});

  @override
  State<DistanceTestWidget> createState() => _DistanceTestWidgetState();
}

class _DistanceTestWidgetState extends State<DistanceTestWidget> {
  @override
  Widget build(BuildContext context) {
    var test = DistanceTest(numbers: widget.numbers);
    bool testResult = test.test();

    return Tooltip(
      message: !testResult ? GeneratorTesterWidget.canDeny : GeneratorTesterWidget.cantDeny,
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
              child: Text("Prueba de la distancia",
                  style: TextStyle(color: Colors.white, fontSize: 25)),
            )
          ])),
    );
  }
}
