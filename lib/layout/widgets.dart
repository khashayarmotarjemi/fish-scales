import 'package:fish_scales/layout/models.dart';
import 'package:fish_scales/notes/constants.dart';
import 'package:flutter/material.dart';

class KeySelectorWidget extends StatelessWidget {
  const KeySelectorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
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

class ClearButton extends StatefulWidget {
  final Function() onTap;

  const ClearButton({Key? key, required this.onTap}) : super(key: key);

  @override
  _ClearButtonState createState() => _ClearButtonState();
}

class _ClearButtonState extends State<ClearButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        color: Colors.redAccent,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 45),
          child: const Text(
            "CLEAR",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class KeySelector extends StatelessWidget {
  final void Function(int) onTap;
  final int currentKey;

  const KeySelector({super.key, required this.onTap, required this.currentKey});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: Music.noteNames.keys.map((k) {
        return GestureDetector(
          onTap: () {
            onTap(k);
          },
          child: ChangeKeyButtonWidget(
            name: Music.noteNames[k] ?? "err",
            active: k == currentKey,
          ),
        );
      }).toList(),
    );
  }
}

class ChordSelector extends StatefulWidget {
  final Function(Chord) onTap;

  const ChordSelector({Key? key, required this.onTap}) : super(key: key);

  @override
  _ChordSelectorState createState() => _ChordSelectorState();
}

class _ChordSelectorState extends State<ChordSelector> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: Music.chords.map((ch) {
              return GestureDetector(
                onTap: () {
                  widget.onTap(ch);
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Text(ch.name),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
