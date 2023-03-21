import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/random_variable_state.dart';

abstract class DistributionForm extends StatefulWidget {
  const DistributionForm({super.key});

  List<Widget> get formFields;
  List<double> onSubmit(BuildContext context);

  @override
  State<DistributionForm> createState() => _DistributionFormState();
}

class _DistributionFormState extends State<DistributionForm> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
                key: _formState,
                child: ListView(
                  children: [
                    Wrap(
                      runSpacing: 25,
                      children: [
                        for (var field in widget.formFields) field,
                      ],
                    )
                  ],
                )),
          ),
        ),
        ElevatedButton(
            onPressed: () {
              if (_formState.currentState!.validate()) {
                var randomVariables = widget.onSubmit(context);

                Provider.of<RandomVariableState>(context, listen: false)
                    .randomVariables = randomVariables;
              }
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: const ContinuousRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0))),
                minimumSize: const Size.fromHeight(50)),
            child: Row(
              children: const [
                Icon(Icons.search, size: 20),
                SizedBox(
                  width: 10,
                ),
                Text("Obtener variables aleatorias")
              ],
            )),
      ],
    );
  }
}
