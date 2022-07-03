import 'package:fish_scales/notes/fretboard.dart';
import 'package:fish_scales/notes/guitar.dart';
import 'package:fish_scales/notes/notes.dart';
import 'package:fish_scales/notes/pattern_selection.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../notes/constants.dart';

class GuitarWidget extends StatefulWidget {
  final fretBoard = GetIt.I<FretBoard>();
  int currentKey = -1;

  GuitarWidget({Key? key}) : super(key: key);

  @override
  _GuitarWidgetState createState() {
    return _GuitarWidgetState();
  }
}

class _GuitarWidgetState extends State<GuitarWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          width: 1400,
          alignment: Alignment.center,
          child: StreamBuilder<List<List<Note>>>(
              initialData: [],
              stream: widget.fretBoard.output.stream,
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  return Column(
                    children: [
                      FretboardWidget(notes: snapshot.data!),
                      Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: Music.noteNames.keys.map((k) {
                                return GestureDetector(
                                  onTap: () {
                                    widget.fretBoard.setLayout(ScaleLayout(k));
                                    widget.currentKey = k;
                                  },
                                  child: ChangeKeyButtonWidget(
                                    name: Music.noteNames[k] ?? "err",
                                    active: k == widget.currentKey,
                                  ),
                                );
                              }).toList(),
                            ),
                            GestureDetector(
                              onTap: () {
                                // widget.guitar.setLayout(ClearLayout());
                                widget.fretBoard
                                    .setLayout(ChordLayout(Music.chords[0], 1));
                                widget.currentKey = -1;
                              },
                              child: Card(
                                color: Colors.redAccent,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16, horizontal: 45),
                                  child: const Text(
                                    "CLEAR",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: Music.chords.map((ch) {
                                return GestureDetector(
                                  onTap: () {
                                    widget.fretBoard.setLayout(
                                        ChordLayout(ch, widget.currentKey));
                                  },
                                  child: Card(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      child: Text(ch.type.toString()),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                } else {
                  return Container(
                    alignment: Alignment.center,
                    child: Text("Error"),
                  );
                }
              }),
        ),
      ),
    );
  }
}



//
// class PatternConfig {
//   final int key;
//   final PatternMode mode;
//
//   PatternConfig(this.key, this.mode);
// }
//
// enum PatternMode { CHORD, SCALE, CLEAR }
