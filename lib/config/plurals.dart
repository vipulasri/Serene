import 'package:intl/intl.dart';

class Plurals {

  static selectedSounds(int howMany) => Intl.plural(
    howMany,
    zero: 'No sounds selected',
    one: '$howMany sound selected',
    other: '$howMany sounds selected',
    name: "selectedSound",
    args: [howMany],
    examples: const {'howMany': 1},
    desc: "1 sound selected",
  );

  static String currentlyPlayingSelectedSounds(bool isPlaying, int howMany) {
    return '${isPlaying? 'Currently Playing': 'Currently Paused'} (${selectedSounds(howMany)})';
  }

}