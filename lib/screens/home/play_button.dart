import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:serene/config/constants.dart';
import 'package:serene/config/dimen.dart';
import 'package:serene/config/plurals.dart';
import 'package:serene/config/typography.dart';

class PlayButton extends StatefulWidget {

  final bool isPlaying;
  final int playingCount;
  final VoidCallback onPlayAction;
  final VoidCallback onPlaylistAction;

  PlayButton({Key key,
    @required this.isPlaying,
    @required this.playingCount,
    @required this.onPlayAction,
    @required this.onPlaylistAction,
  }) : super(key: key);

  @override
  _PlayButtonState createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> with TickerProviderStateMixin {

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
      width: widget.isPlaying? 300 : 100,
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
              child: Center(
                child: Text(widget.isPlaying ? Plurals.playingSounds(widget.playingCount) : "Play",
                    style: AppTypography.body()),
              ),
            ),
            SizedBox(width: Dimen.padding/2),
            widget.isPlaying? InkWell(
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

}
