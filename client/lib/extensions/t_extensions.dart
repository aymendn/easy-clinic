extension TExt<T> on T {
  List<T> makeList([int lenght = 12]) {
    return List<T>.generate(lenght, (index) => this);
  }
}
