import 'package:flutter/cupertino.dart';

class Assets {
  static const basePath = 'assets/images/';
  static const homeBackground = basePath + 'bg_home.jpg';
  static const city = basePath + 'city.png';
  static const meditation = basePath + 'meditation.png';
  static const rain = basePath + 'water.png';
  static const forest = basePath + 'forest.png';

  void preCacheAssets(BuildContext context) {
    precacheImage(AssetImage(homeBackground), context);
  }
}
