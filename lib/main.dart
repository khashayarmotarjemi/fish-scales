import 'package:fish_scales/notes/notes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scales(),
    );
  }
}

class Scales extends StatefulWidget {
  final gen = NoteGen();

  Scales({Key? key}) : super(key: key) {
    gen.generate();
  }

  @override
  _ScalesState createState() => _ScalesState();
}

class _ScalesState extends State<Scales> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 100, horizontal: 50),
            child: Column(
              children: widget.gen.notes
                  .map((row) => Row(
                        children:
                            row.map((note) => NoteWidget(note: note)).toList(),
                      ))
                  .toList(),
            )),
      ),
    );
  }
}

class NoteWidget extends StatelessWidget {
  final Note note;

  const NoteWidget({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cMajor = [0,2,4,5,7,9,11];

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: cMajor.contains(note.rNo)? Colors.yellowAccent : Colors.grey[100],
            border: Border(
                right:
                    BorderSide(color: note.x == 0 ? Colors.red : Colors.black, width: note.x == 0 ? 4 : 2),
                bottom: BorderSide())),
        alignment: Alignment.center,
        height: 50,
        child: Text(note.name ?? "err"),
      ),
    );
  }
}
