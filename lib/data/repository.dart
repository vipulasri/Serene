import 'package:flutter/services.dart';
import 'package:serene/config/assets.dart';
import 'package:serene/config/constants.dart';
import 'package:serene/config/helper.dart';
import 'package:serene/manager/audio_manager.dart';
import 'package:serene/model/category.dart';
import 'package:serene/model/sound.dart';

class DataRepository {
  // in-memory categories
  List<Category> categories = <Category>[];
  List<Sound> sounds = <Sound>[];
  String randomPlayingId = "";
  bool isPlaying = false;

  Future<String> _loadCategoriesAsset() async {
    return await rootBundle.loadString(Assets.soundsJson);
  }

  Future<List<Category>> loadCategories() async {
    if (categories.isNotEmpty) {
      return categories;
    }

    String jsonString = await _loadCategoriesAsset();
    categories.clear();
    categories.addAll(categoryFromJson(jsonString));
    _mapSounds();
    return categories;
  }

  // Map all the sounds from categories to a flatten list
  Future<List<Sound>> _mapSounds() async {
    sounds.clear();
    for (var category in categories) {
      sounds.addAll(category.sounds);
    }
    return sounds;
  }

  Future<List<Sound>> loadSounds(String categoryId) async {
    return sounds
        .where((sound) => sound.id.substring(0, 1) == categoryId)
        .toList(); //sound id = 201, 2 is category id
  }

  Future<List<Sound>> getSelectedSounds() async {
    return sounds.where((sound) => sound.active).toList();
  }

  Future<List<Sound>> playAllSelectedSounds() async {
    List<Sound> selected = await getSelectedSounds();

    selected.forEach((element) {
      AudioManager.instance.play(element);
    });

    // check if there were any selected sounds then player state is changed
    if(selected.isNotEmpty) {
      isPlaying = true;
    }
    
    return selected;
  }

  Future<List<Sound>> stopAllPlayingSounds() async {
    List<Sound> playing = await getSelectedSounds();

    playing.forEach((element) {
      AudioManager.instance.stop(element);
    });

    // check if there were any selected sounds then player state is changed
    if(playing.isNotEmpty) {
      isPlaying = false;
    }
    
    return playing;
  }

  Future<bool> updateSound(String soundId, bool active, double volume) async {
    if (sounds.isEmpty) return false;

    int soundIndex = sounds.indexWhere((sound) => sound.id == soundId);
    if (soundIndex > -1) {
      Sound sound = sounds[soundIndex].copyWith(active: active, volume: volume);
      sounds[soundIndex] = sound;

      if (active) {
        playAllSelectedSounds();
      } else {
        AudioManager.instance.stop(sound);
        if((await getSelectedSounds()).isEmpty) {
          isPlaying = false;
        }
      }

      return true;
    }

    return false;
  }

  Future<List<Sound>> playRandom() async {
    Sound randomSound = sounds[Helper.getRandomNumber(0, sounds.length)];
    updateSound(randomSound.id, true, Constants.defaultSoundVolume);
    randomPlayingId = randomSound.id;
    return getSelectedSounds();
  }

  Future<bool> stopRandom() async {
    updateSound(randomPlayingId, false, Constants.defaultSoundVolume);
    randomPlayingId = "";
    return true;
  }

  bool isPlayingRandom() {
    return randomPlayingId.isNotEmpty;
  }

}
