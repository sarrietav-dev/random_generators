import 'package:flutter/material.dart';
import 'package:random_generators/components/number_list.dart';

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
        home: const MyHomePage(title: "Flutter Demo Home Page"));
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Row(children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: Colors.grey.shade300,
                  width: 1,
                ),
              ),
            ),
            child: SizedBox(
              width: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 20, left: 20, right: 20, bottom: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const DropdownMenu(
                              label: Text("Generador"),
                              dropdownMenuEntries: [
                                DropdownMenuEntry(label: "XORShift", value: 1),
                              ]),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Divider(),
                          ),
                          Expanded(
                            child: Form(
                                child: ListView(
                              children: [
                                Wrap(
                                  runSpacing: 15,
                                  children: [
                                    TextFormField(
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: "Semilla",
                                          hintText: "Ingrese la semilla"),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: const ContinuousRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(0))),
                                minimumSize: const Size.fromHeight(50)),
                            onPressed: () {},
                            child: const Text("Generar")),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: const [
                Expanded(child: NumberList(numbers: [1, 2, 3, 4, 5])),
              ],
            ),
          )
        ]));
  }
}
