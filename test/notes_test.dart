import 'package:fish_scales/notes/notes.dart';

main() {
  final gen = NoteGen();

  gen.generate();

  print(gen.notes[0][2]);

}