import 'package:flutter/material.dart';
import 'package:serene/config/assets.dart';
import 'package:serene/config/dimen.dart';
import 'package:serene/config/typography.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: new ExactAssetImage(Assets.homeBackground),
              fit: BoxFit.cover,
            ),
            /*gradient: LinearGradient(
                colors: [Color(0xFFB5DDD1), Color(0xFFD9EFFC)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )*/
          ),
          child: Stack(
            children: <Widget>[contentArea()],
          )),
    );
  }

  Widget contentArea() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(Dimen.padding),
        child: Text(
          "Good Morning",
          style: AppTypography.title(),
        ),
      ),
    );
  }
}
