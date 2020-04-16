import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:serene/config/assets.dart';
import 'package:serene/model/sound.dart';

List<Category> categoryFromJson(String str) => List<Category>.from(json.decode(str).map((x) => Category.fromJson(x).copyWith(
  color: getCategoryColor(x["id"])
)));

String categoryToJson(List<Category> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
  String id;
  String title;
  String icon;
  List<Sound> sounds;
  Color color;

  Category({
    @required this.id,
    @required this.title,
    @required this.icon,
    @required this.sounds,
    this.color
  });

  Category copyWith({
    String id,
    String title,
    Color color,
    String icon,
    List<Sound> sounds,
  }) =>
      Category(
        id: id ?? this.id,
        title: title ?? this.title,
        color: color ?? this.color,
        icon: icon ?? this.icon,
        sounds: sounds ?? this.sounds,
      );

  String getIconPath() {
    return Assets.basePath + icon;
  }

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    title: json["title"],
    icon: json["icon"],
    sounds: List<Sound>.from(json["sounds"].map((x) => Sound.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "icon": icon,
    "sounds": List<dynamic>.from(sounds.map((x) => x.toJson())),
  };
}

Color getCategoryColor(String categoryId) {
  Color color = null;
  switch(categoryId) {
    case "1": {
      color = Color(0xFFF5B97E);
    }
    break;
    case "2": {
      color = Color(0xFF91E7F6);
    }
    break;
    case "3": {
      color = Color(0xFFC592F3);
    }
    break;
    case "4": {
      color = Color(0xFFA8E087);
    }
    break;
    default: Color(0xFFF5B97E);
  }
  return color;
}
