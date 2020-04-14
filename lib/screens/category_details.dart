import 'package:flutter/material.dart';
import 'package:serene/config/dimen.dart';
import 'package:serene/config/typography.dart';
import 'package:serene/model/Category.dart';

class CategoryDetailsPage extends StatefulWidget {
  final Category category;

  CategoryDetailsPage({Key key, @required this.category}) : super(key: key);

  @override
  _CategoryDetailsState createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(color: widget.category.color),
      child: Stack(
        children: <Widget>[
          contentArea(),
          Positioned(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                widget.category.iconPath,
                width: 300,
                height: 300,
                  color: Color.fromRGBO(255, 255, 255, 0.5),
                  colorBlendMode: BlendMode.modulate
              ),
            ),
          )
        ],
      ),
    ));
  }

  Widget contentArea() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(Dimen.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.category.title,
              style: AppTypography.title(),
            ),
          ],
        ),
      ),
    );
  }
}
