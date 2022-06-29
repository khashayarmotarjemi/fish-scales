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
  bool first;
  bool active;

  Note(this.rNo, this.x, this.y, this.name, {this.active = false, this.first = false});

  @override
  String toString() {
    return "$name \n"
        "x: $x | y: $y"
        "";
  }
}
