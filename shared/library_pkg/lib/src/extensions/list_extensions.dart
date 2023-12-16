extension MoveToIndexExtension<T> on List<T> {
  List<T> moveToIndex(int currentIndex, int targetIndex) {
    final removed = removeAt(currentIndex);
    insert(targetIndex, removed);
    return this;
  }
}
