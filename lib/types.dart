class MyCustomValidators {
  static bool isPositive(int value) => value > 0;
}
enum TmRole { admin, viewer, guest, editor }
enum TmStatus { pending, paid, shipped, delivered, cancelled }