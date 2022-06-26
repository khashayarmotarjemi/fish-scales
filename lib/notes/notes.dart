class NoteGen {
  List<List<Note>> notes = List.generate(
      6, (i) => List.filled(12, Note(-1,-1,-1,"err"), growable: false),
      growable: false);

  static const _names = {
    0: "C",
    1: "C#",
    2: "D",
    3: "D#",
    4: "E",
    5: "F",
    6: "F#",
    7: "G",
    8: "G#",
    9: "A",
    10: "A#",
    11: "B",
  };

  generate() {
    for (int y = 0; y < 6; y++) {
      for (int x = 0; x < 12; x++) {
        notes[y][x] = _getNote(x, y);
      }
    }
  }

  ///
  /// 0,0 -> Low E
  /// 0,1 -> F
  ///
  Note _getNote(int x, int y) {
    int key = 0; // key of C
    final strings = [4,9,2,7,11,4];

    final rn = (x + strings[y]) % 12;
    return Note(rn, x, y, _names[rn]);

    // switch (y) {
    //   // Low E
    //   case 0:
    //     final rn = (x + 4) % 12;
    //     return Note(rn, x, y, _names[rn]);
    //   case 1:
    //     break;
    //   case 2:
    //     break;
    //   case 3:
    //     break;
    //   case 4:
    //     break;
    //   case 5:
    //     break;
    // }
    // return Note(1, 3, 2, _names[1]);
  }
}

///     y
///   x 0----5---------
///     |
///     |
///     3
///     |
///
class Note {
  final int rNo;
  final int x;
  final int y;
  final String? name;

  Note(this.rNo, this.x, this.y, this.name);

  @override
  String toString() {
    return "$name \n"
        "x: $x | y: $y"
        "";
  }
}
