import 'package:meta/meta.dart';
import 'package:serene/model/sound.dart';

class PlayingData {
  bool isPlaying;
  bool isRandom;
  List<Sound> playing;

  PlayingData({
    @required this.isPlaying,
    @required this.isRandom,
    @required this.playing,
  });
}