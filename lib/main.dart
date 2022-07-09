import 'package:fish_scales/views/home.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'notes/guitar.dart';

void main() {
  runApp(const MyApp());

  final guitar = FretBoard();
  // guitar.setTuning([4, 9, 2, 7, 11, 5]);
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
      home: HomePage(),
    );
  }
}
