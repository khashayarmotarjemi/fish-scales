import 'dart:async';

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
