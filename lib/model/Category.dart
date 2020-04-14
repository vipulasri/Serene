import 'dart:ui';

class Category {
  final int id;
  final String title;
  final Color color;
  final String iconPath;

  Category(this.id, this.title, this.color, this.iconPath);

  String heroTitleTag() {
    return "categoryTitle" + id.toString();
  }

  String heroIconTag() {
    return "categoryIcon" + id.toString();
  }
}
