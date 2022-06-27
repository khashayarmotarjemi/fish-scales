import 'dart:async';

class Guitar {
  StreamController<List<List<Note>>> output = StreamController();
  final List<int> _tuning;
  static const _cMajorBase = [0, 2, 4, 5, 7, 9, 11];

  ///
  /// C : 0
  /// C# : 1
  /// if is set to -1 the guitar should be clear (no note active)
  ///
  int _key;

  Guitar({t = const [4, 9, 2, 7, 11, 4], k = -1})
      : _tuning = t,
        _key = k {
    _generate();
    output.sink.add(_notes);
  }

  void changeScale(int newScale) {
    _key = newScale;
    _generate();
    output.sink.add(_notes);
  }

  static const names = {
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

  final List<List<Note>> _notes = List.generate(
      6,
      (i) => List.filled(12, Note(-1, -1, -1, "err", false, false),
          growable: false),
      growable: false);

  _generate() {
    List<int>? scale;
    if (_key != -1) {
      scale = _cMajorBase.map((n) => (n + _key) % 12).toList();
    }

    for (int y = 0; y < 6; y++) {
      for (int x = 0; x < 12; x++) {
        _notes[y][x] = _getNote(x, y, scale: scale);
      }
    }
  }

  ///
  /// 0,0 -> Low E
  /// 0,1 -> F
  ///
  Note _getNote(int x, int y, {List<int>? scale}) {
    final rn = (x + _tuning[y]) % 12;

    bool active;

    if (scale != null) {
      active = scale.contains(rn);
    } else {
      active = false;
    }

    var first = x == 0;

    return Note(rn, x, y, names[rn], first, active);
  }
}

///
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
  final bool isFirst;
  final bool isActive;

  Note(this.rNo, this.x, this.y, this.name, this.isFirst, this.isActive);

  @override
  String toString() {
    return "$name \n"
        "x: $x | y: $y"
        "";
  }
}
