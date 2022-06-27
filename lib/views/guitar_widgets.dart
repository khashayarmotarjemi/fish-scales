import 'package:fish_scales/notes/guitar.dart';
import 'package:fish_scales/notes/notes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class GuitarWidget extends StatefulWidget {
  final guitar = GetIt.I<Guitar>();
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
      body: Container(
        alignment: Alignment.center,
        child: StreamBuilder<List<List<Note>>>(
            initialData: [],
            stream: widget.guitar.output.stream,
            builder: (context, notes) {
              if (notes.data != null) {
                return Column(
                  children: [
                    Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 100, horizontal: 50),
                        child: Column(
                          children: notes.data!
                              .map((row) => Row(
                                    children: row
                                        .map((note) => NoteWidget(note: note))
                                        .toList(),
                                  ))
                              .toList(),
                        )),
                    Container(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: Guitar.names.keys.map((k) {
                              return GestureDetector(
                                onTap: () {
                                  widget.guitar.changeScale(k);
                                  widget.currentKey = k;
                                },
                                child: ChangeKeyButtonWidget(
                                  name: Guitar.names[k] ?? "err",
                                  active: k == widget.currentKey,
                                ),
                              );
                            }).toList(),
                          ),
                          GestureDetector(
                            onTap: () {
                              widget.guitar.changeScale(-1);
                              widget.currentKey = -1;
                            },
                            child: Card(
                              color: Colors.redAccent,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 45),
                                child: Text(
                                  "CLEAR",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          )
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
    );
  }
}

class ChangeKeyButtonWidget extends StatelessWidget {
  final String name;
  final bool active;

  const ChangeKeyButtonWidget(
      {Key? key, required this.name, this.active = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: active ? Colors.greenAccent : Colors.grey[50],
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 35),
        child: Text(name),
      ),
    );
  }
}

class NoteWidget extends StatelessWidget {
  final Note note;

  const NoteWidget({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            // color: note.isActive ? Colors.yellowAccent : Colors.grey[100],
            border: Border(
                right: BorderSide(
                    color: note.isFirst ? Colors.red : Colors.black,
                    width: note.isFirst ? 10 : 2),
                bottom: BorderSide())),
        alignment: Alignment.center,
        height: 50,
        child: Row(
          children: [
            !note.isFirst
                ? Expanded(
                    child: Column(
                    children: [
                      Expanded(child: Container()),
                      Container(
                        color: Colors.orange,
                        height: 1,
                      ),
                      Expanded(child: Container())
                    ],
                  ))
                : Container(),
            Expanded(
                child: Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
              decoration: BoxDecoration(
                  borderRadius: note.isFirst ? null : BorderRadius.circular(40),
                  color: note.isActive ? Colors.redAccent : Colors.orange[100]),
              alignment: Alignment.center,
              child: Text(
                note.name ?? "err",
                style: TextStyle(
                    color: note.isActive ? Colors.white : Colors.black),
              ),
            )),
            !note.isFirst
                ? Expanded(
                    child: Column(
                    children: [
                      Expanded(child: Container()),
                      Container(
                        color: Colors.orange,
                        height: 1,
                      ),
                      Expanded(child: Container())
                    ],
                  ))
                : Container(),
          ],
        ),
      ),
    );
  }
}
