import 'package:fish_scales/notes/notes.dart';
import 'package:flutter/material.dart';

class FretboardWidget extends StatelessWidget {
  final List<List<Note>> notes;

  const FretboardWidget({Key? key, required this.notes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 50),
        child: Column(
          children: notes
              .map((row) => Row(
            children:
            row.map((note) => NoteWidget(note: note)).toList(),
          ))
              .toList(),
        ));
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
                    color: note.first ? Colors.red : Colors.black,
                    width: note.first ? 10 : 2),
                bottom: BorderSide())),
        alignment: Alignment.center,
        height: 50,
        child: Row(
          children: [
            !note.first
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
                      borderRadius: note.first ? null : BorderRadius.circular(40),
                      color: note.active ? Colors.redAccent : Colors.orange[100]),
                  alignment: Alignment.center,
                  child: Text(
                    note.name ?? "err",
                    style:
                    TextStyle(color: note.active ? Colors.white : Colors.black),
                  ),
                )),
            !note.first
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