import 'package:flutter/cupertino.dart';

class Assets {
  static const basePath = 'assets/images/';
  static const homeBackground = basePath + 'bg_home.jpg';
  static const soundsJson = 'assets/sounds.json';

  void preCacheAssets(BuildContext context) {
    precacheImage(AssetImage(homeBackground), context);
  }
}
