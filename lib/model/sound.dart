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

  String getIconPath() {
    return Assets.basePath + title.toLowerCase() + "/" + icon;
  }

  String getActiveIconPath(String name) {
    return Assets.basePath + title.toLowerCase() + "/" + iconActive;
  }

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