import 'package:intl/intl.dart';

class Plurals {

  static currentlyPlayingSounds(int howMany) => Intl.plural(
    howMany,
    one: 'Playing $howMany sound',
    other: 'Playing $howMany sounds',
    name: "playingSound",
    args: [howMany],
    examples: const {'howMany': 1},
    desc: "Playing 1 sound.",
  );

}