import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serene/blocs/playing_bloc.dart';
import 'package:serene/config/constants.dart';
import 'package:serene/model/sound.dart';

class PlayingSoundView extends StatefulWidget {

  final Sound sound;

  PlayingSoundView({Key key, @required this.sound}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PlayingSoundViewState();
  }
  
}

class PlayingSoundViewState extends State<PlayingSoundView> {

  Color activeColor = Color(0xFF1D2632).withOpacity(0.8);
  Color volumeColor = Color(0xFF1D2632).withOpacity(0.8);

  double volume = 1;

  @override
  void initState() {
    super.initState();
    volumeColor = widget.sound.color.withOpacity(0.8);
    volume = widget.sound.volume.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(widget.sound.icon,
          width: 24,
          height: 24,
          color: activeColor,
        ),
        Expanded(
          child: volumeSlider(),
        ),
        InkWell(
          child: Icon(Icons.close, color: Color(0xFF1D2632).withOpacity(0.8)),
          onTap: () {
            BlocProvider.of<PlayingSoundsBloc>(context).add(StopSound(soundId: widget.sound.id));
          },
        )
      ],
    );
  }

  Widget volumeSlider() {
    _onVolumeChanged(double volume) {
      setState(() {
        this.volume = volume;
      });
      BlocProvider.of<PlayingSoundsBloc>(context)
          .add(UpdateSoundVolume(soundId: widget.sound.id, volume: volume));
    }
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: volumeColor,
        inactiveTrackColor: volumeColor.withOpacity(0.5),
        disabledActiveTrackColor: volumeColor.withOpacity(0.2),
        trackShape: RoundedRectSliderTrackShape(),
        thumbColor: volumeColor,
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6.0),
        overlayColor: volumeColor.withOpacity(0.2),
        overlayShape: RoundSliderOverlayShape(overlayRadius: 18.0),
      ),
      child: Slider(
        value: volume,
        min: Constants.minSliderValue,
        max: Constants.maxSliderValue,
        onChanged: (double newValue) {
          _onVolumeChanged(newValue.round().toDouble());
        }
      ),
    );
  }

}