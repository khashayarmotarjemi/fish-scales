// ignore_for_file: constant_identifier_names

import 'dart:async';

import 'constants.dart';
import 'notes.dart';

class FretBoard {
  StreamController<List<List<Note>>> output = StreamController();
  List<int> _tuning;
  Layout _layout = ClearLayout();

  final List<List<Note>> _notes = List.generate(
      6, (i) => List.filled(12, Note(-1, -1, -1, "err"), growable: false),
      growable: false);

  FretBoard({t = Music.stdTuningBase, k = -1}) : _tuning = t {
    _generate();
    output.sink.add(_notes);
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
    output.sink.add(_notes);
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

abstract class Layout {
  void updateNotes(List<List<Note>> notes) {
    for (var row in notes) {
      for (var note in row) {
        _updateNote(note);
      }
    }
  }

  void _updateNote(Note note);
}

class ScaleLayout extends Layout {
  final int _key;

  ScaleLayout(this._key);

  @override
  void _updateNote(Note note) {
    final scale =
        Music.getScale(_key);

    note.active = scale.contains(note.rNo);
  }
}

class ChordLayout extends Layout {
  final int _root;
  final Chord _chord;
  List<int> _notes = [];

  ChordLayout(this._chord, this._root) {
    _notes = _chord.notes.map((n) => Music.getNoteNo(n -1, _root)).toList();
  }

  @override
  void _updateNote(Note note) => note.active = _notes.contains(note.rNo);
}

class ClearLayout extends Layout {
  @override
  void _updateNote(Note note) {
    note.active = false;
  }
}

class Chord {
  final ChordType type;
  final List<int> notes;

  const Chord(this.type, this.notes);
}
