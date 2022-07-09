import 'package:fish_scales/layout/models.dart';
import 'package:fish_scales/layout/widgets.dart';
import 'package:fish_scales/notes/fretboard.dart';
import 'package:fish_scales/notes/guitar.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../notes/constants.dart';

class HomePage extends StatefulWidget {
  final fretBoard = GetIt.I<FretBoard>();

  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          width: 1400,
          alignment: Alignment.center,
          child: StreamBuilder<FretboardState>(
              stream: widget.fretBoard.output.stream,
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  return Column(
                    children: [
                      FretboardWidget(notes: snapshot.data!.notes),
                      Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            KeySelector(
                              onTap: (k) {
                                {
                                  widget.fretBoard.setLayout(ScaleLayout(k));
                                }
                              },
                              currentKey: snapshot.data!.layout.key,
                            ),
                            ClearButton(
                              onTap: () {
                                widget.fretBoard
                                    .setLayout(ChordLayout(Music.chords[0], 1));
                                // widget.currentKey = -1;
                              },
                            )
                          ],
                        ),
                      ),
                      ChordSelector(onTap: (ch) {
                        widget.fretBoard.setLayout(
                            ChordLayout(ch, snapshot.data!.layout.key));
                      })
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
