import 'package:meta/meta.dart';
import 'package:serene/config/assets.dart';

class Sound {
  String id;
  String title;
  String icon;
  String iconActive;

  Sound({
    @required this.id,
    @required this.title,
    @required this.icon,
    @required this.iconActive,
  });

  Sound copyWith({
    String id,
    String title,
    String icon,
    String iconActive,
  }) =>
      Sound(
        id: id ?? this.id,
        title: title ?? this.title,
        icon: icon ?? this.icon,
        iconActive: iconActive ?? this.iconActive,
      );

  factory Sound.fromJson(Map<String, dynamic> json) => Sound(
    id: json["id"],
    title: json["title"],
    icon: json["icon"],
    iconActive: json["iconActive"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "icon": icon,
    "iconActive": iconActive,
  };
}