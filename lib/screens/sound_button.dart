import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serene/blocs/sound_bloc.dart';
import 'package:serene/config/constants.dart';
import 'package:serene/model/sound.dart';

class SoundButton extends StatefulWidget {
  final Sound sound;

  SoundButton({@required this.sound});

  @override
  State<StatefulWidget> createState() {
    return SoundButtonState();
  }
}

class SoundButtonState extends State<SoundButton> {
  final Color activeColor = Color(0xFF1D2632).withOpacity(0.8);
  final Color inactiveColor = Color(0xFF1D2632).withOpacity(0.2);

  bool active = false;
  double volume = 1;

  @override
  void initState() {
    super.initState();
    active = widget.sound.active;
    volume = widget.sound.volume.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    _onButtonClick() {
      setState(() {
        this.active = !active;
      });
      BlocProvider.of<SoundBloc>(context)
          .add(UpdateSound(soundId: widget.sound.id, active: active, volume: volume));
    }
    return Container(
        child: InkWell(
            splashColor: Colors.black,
            child: Column(
              children: [
                MaterialButton(
                  onPressed: null,
                  child: Image.asset(
                    widget.sound.icon,
                    color: active ? activeColor : inactiveColor,
                  ),
                ),
                volumeSlider()
              ],
            ),
          onTap: _onButtonClick,
        )
    );
  }

  Widget volumeSlider() {
    _onVolumeChanged(double volume) {
      setState(() {
        this.volume = volume;
      });
      BlocProvider.of<SoundBloc>(context)
          .add(UpdateSound(soundId: widget.sound.id, active: active, volume: volume));
    }
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: activeColor,
        inactiveTrackColor: activeColor.withOpacity(0.5),
        disabledActiveTrackColor: activeColor.withOpacity(0.2),
        disabledThumbColor: inactiveColor,
        trackShape: RectangularSliderTrackShape(),
        thumbColor: activeColor,
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6.0),
      ),
      child: Slider(
        value: volume,
        min: Constants.minSliderValue,
        max: Constants.maxSliderValue,
        onChanged: active
            ? (double newValue) {
                _onVolumeChanged(newValue.round().toDouble());
              }
            : null,
      ),
    );
  }
}
