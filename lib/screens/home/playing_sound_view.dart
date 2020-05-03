import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serene/blocs/sound_bloc.dart';
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

  final Color activeColor = Color(0xFF1D2632).withOpacity(0.8);

  double volume = 1;

  @override
  void initState() {
    super.initState();
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
          child: Icon(Icons.close, color: activeColor),
          onTap: () {
            BlocProvider.of<SoundBloc>(context).add(StopSound(soundId: widget.sound.id));
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
      BlocProvider.of<SoundBloc>(context)
          .add(UpdateSound(soundId: widget.sound.id, active: true, volume: volume));
    }
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: activeColor,
        inactiveTrackColor: activeColor.withOpacity(0.5),
        disabledActiveTrackColor: activeColor.withOpacity(0.2),
        trackShape: RoundedRectSliderTrackShape(),
        thumbColor: activeColor,
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6.0),
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