// ignore_for_file: constant_identifier_names

import 'dart:async';

import 'package:fish_scales/layout/models.dart';

import 'constants.dart';
import 'notes.dart';

class FretBoard {
  StreamController<FretboardState> output = StreamController();
  List<int> _tuning;
  Layout _layout = ClearLayout();

  final List<List<Note>> _notes = List.generate(
      6, (i) => List.filled(12, Note(-1, -1, -1, "err"), growable: false),
      growable: false);

  FretBoard({t = Music.stdTuningBase, k = -1}) : _tuning = t {
    _generate();
    output.sink.add(FretboardState(_notes, _layout));
  }

  /// input functions
  void setLayout(Layout layout) {
    _layout = layout;
    _reloadLayout();
  }

  void setTuning(List<int> tuning) {
    _tuning = tuning;
    _generate();
    _reloadLayout();
  }

  /// internal functions
  _reloadLayout() {
    _layout.updateNotes(_notes);
    output.sink.add(FretboardState(_notes, _layout));
  }

  _generate() {
    for (int y = 0; y < 6; y++) {
      for (int x = 0; x < 12; x++) {
        final rn = Music.getNoteNo(x, _tuning[y]);
        var first = x == 0;
        _notes[y][x] = Note(rn, x, y, Music.noteNames[rn], first: first);
      }
    }
  }
}

class FretboardState {
  final List<List<Note>> notes;
  final Layout layout;

  FretboardState(this.notes, this.layout);
}
