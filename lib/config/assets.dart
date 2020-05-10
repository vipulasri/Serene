import 'package:flutter/cupertino.dart';

class Assets {
  static const baseImagesPath = 'assets/images/';
  static const homeBackground = baseImagesPath + 'bg_home.jpg';
  static const soundsJson = 'assets/sounds.json';
  static const baseSoundsPath = 'audios/';
  static const logoAnimation = 'assets/animation/serene-logo.flr';

  void preCacheAssets(BuildContext context) {
    precacheImage(AssetImage(homeBackground), context);
  }
}
