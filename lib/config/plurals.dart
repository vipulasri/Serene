import 'package:intl/intl.dart';

class Plurals {

  static playingSounds(int howMany) => Intl.plural(
    howMany,
    one: 'Playing $howMany sound',
    other: 'Playing $howMany sounds',
    name: "playingSound",
    args: [howMany],
    examples: const {'howMany': 1},
    desc: "Playing 1 sound",
  );

  static currentlyPlayingSounds(int howMany) => Intl.plural(
    howMany,
    zero: 'No sounds are playing',
    one: 'Currently Playing ($howMany sound)',
    other: 'Currently Playing ($howMany sounds)',
    name: "currentlyPlayingSound",
    args: [howMany],
    examples: const {'howMany': 1},
    desc: "Currently Playing (1 sound)",
  );

}