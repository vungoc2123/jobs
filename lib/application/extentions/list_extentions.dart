extension ListExtentions<T> on List<T> {
  List<List<T>> get twoDimensionalArrayWithThreeElements  {
    int length = (this.length / 3).ceil();
    int y = this.length;
    int x = 0;

    List<List<T>> arr = [];
    for (int i = 0; i < length; i++) {
      int z = x + 3;
      if (y >= 3) {
        arr.add(sublist(x, z));
      } else if (y >= 0) {
        arr.add(skip(x).toList());
      }
      y -= 3;
      x = z;
    }
    return arr;
  }

  List<List<T>> get twoDimensionalArrayWithTwoElements  {
    int length = (this.length / 2).ceil();
    int y = this.length;
    int x = 0;

    List<List<T>> arr = [];
    for (int i = 0; i < length; i++) {
      int z = x + 2;
      if (y >= 2) {
        arr.add(sublist(x, z));
      } else if (y >= 0) {
        arr.add(skip(x).toList());
      }
      y -= 2;
      x = z;
    }
    return arr;
  }
}
