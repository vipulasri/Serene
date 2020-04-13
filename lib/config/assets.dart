import 'package:flutter/cupertino.dart';

class Assets{
  static const homeBackground = 'assets/images/background_home.jpg';

  void preCacheAssets(BuildContext context) {
    precacheImage(AssetImage(homeBackground), context);
  }

}