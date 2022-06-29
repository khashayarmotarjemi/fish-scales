import 'package:fish_scales/notes/guitar.dart';

class Music {
  static const noteNames = {
    1: "C",
    2: "C#",
    3: "D",
    4: "D#",
    5: "E",
    6: "F",
    7: "F#",
    8: "G",
    9: "G#",
    10: "A",
    11: "A#",
    12: "B",
  };

  /// key is 1 .. 12 like notes
  static List<int> getScale(int key) {
    return majorScaleBase
        .map((n) => ((n - 1 + key - 1) % 12).toInt() + 1)
        .toList();
  }

  static int getNoteNo(int distance, int baseNote) =>
      ((distance + baseNote - 1) % 12) + 1;

  static const stdTuningBase = [5, 10, 3, 8, 12, 5];

  static const majorScaleBase = [1, 3, 5, 6, 8, 10, 12];

  static const chords = [
    Chord(ChordType.maj, [1, 5, 8]),
    Chord(ChordType.min, [1, 4, 8]),
    Chord(ChordType.maj7, [1, 5, 8, 12]),
    Chord(ChordType.min7, [1, 4, 8, 12]),
  ];
}

enum ChordType { maj, min, maj7, min7 }
