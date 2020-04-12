import 'package:flutter/material.dart';
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
              gradient: LinearGradient(
                colors: [Color(0xFFB2EBE0), Color(0xFFD9EFFC)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
          ),
          child: SafeArea(
            child: Text(
              "Good Morning",
              style: AppTypography.title(),
            ),
          )
      ),
    );
  }
}
