import 'package:flutter/material.dart';

import '../modules/generators/generator.dart';

abstract class GeneratorFactory {
  Widget getForm();
  Generator getGenerator();
}
