import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

  String icon = '';
  bool active = false;
  double volume = 5;

  @override
  void initState() {
    super.initState();
    setState(() {
      icon = widget.sound.icon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: InkWell(
            splashColor: Colors.black,
            child: Column(
              children: [
                MaterialButton(
                  onPressed: null,
                  child: icon != ''
                      ? Image.asset(
                    icon,
                    color: active ? activeColor : inactiveColor,
                  )
                      : Container(),
                ),
                volumeSlider()
              ],
            ),
          onTap: () {
            setState(() {
              active = !active;
              icon =
              active ? widget.sound.iconActive : widget.sound.icon;
            });
          },
        )
    );
  }

  Widget volumeSlider() {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: activeColor,
        inactiveTrackColor: activeColor.withOpacity(0.5),
        disabledActiveTrackColor: activeColor.withOpacity(0.2),
        disabledThumbColor: inactiveColor,
        trackShape: RectangularSliderTrackShape(),
        thumbColor: activeColor,
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0),
      ),
      child: Slider(
        value: volume,
        min: 1,
        max: 10,
        onChanged: active
            ? (double newValue) {
                setState(() {
                  volume = newValue.round().toDouble();
                });
              }
            : null,
      ),
    );
  }
}
