import 'dart:io';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:serene/model/sound.dart';

class AudioManager {
  Map<String, AudioPlayer> playing;
  List<String> playingIds;

  factory AudioManager() => _getInstance();

  static AudioManager get instance => _getInstance();
  static AudioManager _instance;

  static AudioManager _getInstance() {
    if (_instance == null) {
      _instance = new AudioManager._internal();
    }
    return _instance;
  }

  AudioManager._internal() {
    playing = Map();
    playingIds = [];
    //AudioPlayer.logEnabled = true;
  }

  Future<List<String>> playAll() async {
    playingIds.forEach((id) async {
      if (playing.containsKey(id)) {
        await playing[id].resume();
      }
    });
    return playingIds;
  }

  stopAll() async {
    playingIds.clear();
    playing.forEach((key, player) async {
      if (player.state == AudioPlayerState.PLAYING) {
        playingIds.add(key);
        await player.stop();
      }
    });
  }

  play(Sound sound) async {
    if (!playing.containsKey(sound.id)) {
      AudioCache player = AudioCache();
      if (Platform.isIOS) {
        if (player.fixedPlayer != null) {
          player.fixedPlayer.startHeadlessService();
        }
      }
      playing[sound.id] = await player.loop(sound.audio, volume: sound.volume);
    }
    playing[sound.id].setVolume(sound.volume);
    playing[sound.id].resume();
  }

  stop(Sound sound) async {
    if (playing.containsKey(sound.id)) {
      await playing[sound.id].stop();
    }
  }
}
