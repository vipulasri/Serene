import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serene/blocs/result_state.dart';
import 'package:serene/blocs/sound_bloc.dart';
import 'package:serene/config/dimen.dart';
import 'package:serene/config/typography.dart';
import 'package:serene/model/category.dart';
import 'package:serene/model/sound.dart';
import 'package:serene/screens/details/sound_button.dart';

class DetailsView extends StatefulWidget {
  final Category category;

  DetailsView({Key key, @required this.category}) : super(key: key);

  @override
  _DetailsViewState createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _onAfterBuild(context));
  }

  void _onAfterBuild(BuildContext context){
    BlocProvider.of<SoundBloc>(context)
        .add(FetchSounds(categoryId: widget.category.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: widget.category.color,
        automaticallyImplyLeading: false,
        centerTitle: false,
        elevation: 0,
        title: Text(
          widget.category.title,
          style: AppTypography.title(),
        ),
        actions: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              customBorder: CircleBorder(),
              child: Icon(
                Icons.close,
                color: Colors.black,
                size: 25,
              ),
              onTap: () => Navigator.of(context).pop(),
            ),
          ),
          SizedBox(width: 16)
        ],
      ),
        body: Container(
          decoration: BoxDecoration(color: widget.category.color),
          child: Stack(
            children: <Widget>[
              Positioned(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(top: 0),
                    child: Image.asset(widget.category.icon,
                        width: 200,
                        height: 200,
                        color: Color.fromRGBO(255, 255, 255, 0.5),
                        colorBlendMode: BlendMode.modulate),
                  ),
                ),
              ),
              contentArea()
            ],
          ),
        )
    );
  }

  Widget contentArea() {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0),
        child: Column(
          children: [
            SizedBox(height: Dimen.padding * 4.5),
            Expanded(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  children: [
                    blurBackground(),
                    sheetContentArea()
                  ],
                )
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget blurBackground() {
    return ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimen.cornerRadius),
            topRight: Radius.circular(Dimen.cornerRadius)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
          child: Container(
              decoration: new BoxDecoration(
                  color: Colors.grey.shade200.withOpacity(0.4))),
        ));
  }

  Widget sheetContentArea() {
    return Padding(
      padding: EdgeInsets.all(Dimen.padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                borderRadius: BorderRadius.circular(100),
              ),
              width: 50,
              height: 4,
            ),
          ),
          SizedBox(height: Dimen.padding),
          showSounds()
        ],
      ),
    );
  }

  Widget showSounds() {
    return BlocBuilder<SoundBloc, Result>(builder: (context, state) {
      if (state is Empty) {
        return Center(child: Text('No Sounds Found'));
      }
      if (state is Loading) {
        return Center(child: CircularProgressIndicator());
      }
      if (state is Success) {
        return sheetContent(state.value);
      }
      if (state is Error) {
        return Center(child: Text('Error fetching sounds'));
      }
      return Center(child: Text('No sounds Found'));
    });
  }

  Widget sheetContent(List<Sound> sounds) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Sounds",
            style: AppTypography.body2(),
          ),
          SizedBox(height: Dimen.padding * 2),
          Expanded(
            child: soundViews(sounds),
          )
        ],
      ),
    );
  }

  Widget soundViews(List<Sound> sounds) {
    return GridView.count(
      crossAxisCount: 4,
      crossAxisSpacing: Dimen.padding,
      mainAxisSpacing: Dimen.padding,
      childAspectRatio: 0.8,
      children: sounds
          .map(
            (sound) => SoundButton(sound: sound),
          )
          .toList(),
    );
  }
}
