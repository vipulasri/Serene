import 'dart:math';

class Helper {
  static final _random = new Random();

  static int getRandomNumber(int min, int max) =>
      min + _random.nextInt(max - min);
}
