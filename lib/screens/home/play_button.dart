import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:serene/config/constants.dart';
import 'package:serene/config/dimen.dart';
import 'package:serene/config/plurals.dart';
import 'package:serene/config/typography.dart';

class PlayButton extends StatefulWidget {

  final bool isPlaying;
  final bool isPlayingRandom;
  final int playingCount;
  final VoidCallback onPlayAction;
  final VoidCallback onPlaylistAction;

  PlayButton({Key key,
    @required this.isPlaying,
    @required this.isPlayingRandom,
    @required this.playingCount,
    @required this.onPlayAction,
    @required this.onPlaylistAction,
  }) : super(key: key);

  @override
  _PlayButtonState createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> with TickerProviderStateMixin {

  final TextStyle messageStyle = AppTypography.body2();
  AnimationController _controller;


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: Constants.animationDurationInMillis),
        vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    widget.isPlaying ? _controller.forward() : _controller.reverse();

    return AnimatedContainer(
      width: hasPlayingList() ? 300 : 165,
      duration: Duration(seconds: 1),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100)
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: Row(
          children: [
            InkWell(
              onTap: () => widget.onPlayAction(),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.circular(100)
                ),
                child: Center(
                  child: AnimatedIcon(
                    icon: AnimatedIcons.play_pause,
                    color: Colors.white,
                    progress: _controller,
                  ),
                ),
              ),
            ),
            SizedBox(width: Dimen.padding/2),
            Expanded(
              child: _displayMessage(),
            ),
            SizedBox(width: Dimen.padding/2),
            hasPlayingList()? InkWell(
              onTap: () => widget.onPlaylistAction(),
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(100)
                ),
                child: Center(
                  child: Icon(
                    Icons.playlist_play
                  ),
                ),
              ),
            ) : Container()
          ],
        ),
      ),
    );
  }

  Widget _displayMessage() {
    if(widget.isPlaying && widget.isPlayingRandom) {
      return Text("Playing random sound", style: messageStyle);
    } else if(hasPlayingList()) {
      String title = widget.isPlaying? "Now Playing" : "Now Paused";
      return Column(
        children: [
          Text(title, style: messageStyle),
          Text(Plurals.selectedSounds(widget.playingCount),
              style: AppTypography.body().copyWith(fontSize:14, color: Colors.grey)),
        ],
      );
    } else {
      return Text("Play random", style: messageStyle);
    }
  }

  bool hasPlayingList() {
    return widget.playingCount>0;
  }

}
