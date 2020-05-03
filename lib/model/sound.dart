import 'dart:ui';

import 'package:meta/meta.dart';

class Sound {
  String id;
  String title;
  String icon;
  String audio;
  bool active;
  double volume;
  Color color;

  Sound({
    @required this.id,
    @required this.title,
    @required this.icon,
    @required this.audio,
    this.active = false,
    this.volume = 5,
    this.color
  });

  Sound copyWith({
    String id,
    String title,
    String icon,
    String audio,
    bool active,
    double volume,
    Color color
  }) =>
      Sound(
        id: id ?? this.id,
        title: title ?? this.title,
        icon: icon ?? this.icon,
        audio: audio?? this.audio,
        active: active?? this.active,
        volume: volume?? this.volume,
        color: color?? this.color
      );

  factory Sound.fromJson(Map<String, dynamic> json) => Sound(
    id: json["id"],
    title: json["title"],
    icon: json["icon"],
    audio: json["audio"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "icon": icon,
    "audio": audio
  };
}