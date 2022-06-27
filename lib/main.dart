import 'package:fish_scales/views/guitar_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'notes/guitar.dart';

void main() {
  runApp(const MyApp());

  final guitar = Guitar();
  GetIt.I.registerSingleton(guitar);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fish Scales',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GuitarWidget(),
    );
  }
}
