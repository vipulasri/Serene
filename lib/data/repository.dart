import 'package:flutter/services.dart';
import 'package:serene/config/assets.dart';
import 'package:serene/config/helper.dart';
import 'package:serene/manager/audio_manager.dart';
import 'package:serene/model/category.dart';
import 'package:serene/model/sound.dart';

class DataRepository {
  // in-memory categories
  List<Category> categories = <Category>[];
  List<Sound> sounds = <Sound>[];

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

  Future<List<Sound>> getPlayingSounds() async {
    return sounds.where((sound) => sound.active).toList();
  }

  Future<List<Sound>> playAllPreviouslyPlayingSounds() async {
    List<String> playingIds = await AudioManager.instance.playAll();

    if(playingIds.isEmpty) {
      return _playRandom(); // play a random sound
    }

    sounds = sounds.map((element) {
      element.active = playingIds.contains(element.id);
      return element;
    }).toList();

    return getPlayingSounds();
  }

  Future<List<Sound>> stopAllPlayingSounds() async {
    sounds = sounds.map((element) {
      element.active = false;
      return element;
    }).toList();

    await AudioManager.instance.stopAll();
    return []; // return empty list, as none sound is playing
  }

  Future<List<Sound>> _playRandom() async {
    Sound randomSound = sounds[Helper.getRandomNumber(0, sounds.length)];
    updateSound(randomSound.id, true, 5);
    return getPlayingSounds();
  }

  Future<bool> updateSound(String soundId, bool active, double volume) async {
    if (sounds.isEmpty) return false;

    int soundIndex = sounds.indexWhere((sound) => sound.id == soundId);
    if (soundIndex > -1) {
      Sound sound = sounds[soundIndex].copyWith(active: active, volume: volume);
      sounds[soundIndex] = sound;

      if (active) {
        AudioManager.instance.play(sound);
      } else {
        AudioManager.instance.stop(sound);
      }

      return true;
    }

    return false;
  }
}
