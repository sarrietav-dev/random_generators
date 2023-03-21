import 'package:flutter/material.dart';

abstract class DistributionForm extends StatefulWidget {
  const DistributionForm({super.key});

  List<Widget> get formFields;
  onSubmit(BuildContext context);

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
          child: Form(
              key: _formState,
              child: ListView(
                children: [
                  Wrap(
                    children: [
                      for (var field in widget.formFields) field,
                    ],
                  )
                ],
              )),
        ),
        ElevatedButton(
            onPressed: widget.onSubmit(context),
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
