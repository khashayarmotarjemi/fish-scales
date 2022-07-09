import 'package:fish_scales/notes/constants.dart';
import 'package:fish_scales/notes/notes.dart';

abstract class Layout {
  int get key;

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

  @override
  int get key => _key;
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

  @override
  int get key => _root;
}

class ClearLayout extends Layout {
  @override
  void _updateNote(Note note) {
    note.active = false;
  }

  @override
  int get key => -1;
}

class Chord {
  final ChordType type;
  final String name;
  final List<int> notes;

  const Chord(this.type, this.notes, this.name);
}

