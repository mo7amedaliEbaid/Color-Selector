import 'package:flutter/material.dart';

import '../../lang/lang.dart';
import '../../widgets/opacity_slider.dart';

import '../color_info/color_info.dart';

class RGBValuePicker extends StatefulWidget {
  const RGBValuePicker({Key? key}) : super(key: key);

  @override
  _RGBValuePickerState createState() => _RGBValuePickerState();
}

class _RGBValuePickerState extends State<RGBValuePicker>
    with AutomaticKeepAliveClientMixin {
  double opacity = 1;
  late int red, green, blue;

  @override
  void initState() {
    super.initState();
    red = green = blue = 0;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Language lang = Language.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // Spacer(),
        Expanded(
          child: Column(
            children: <Widget>[
              Field(
                value: red.toDouble(),
                onChanged: (value) => setState(() => red = value.toInt()),
                color: Colors.redAccent,
                label: lang.red,
              ),
              Field(
                value: green.toDouble(),
                onChanged: (value) => setState(() => green = value.toInt()),
                color: Colors.green,
                label: lang.green,
              ),
              Field(
                value: blue.toDouble(),
                onChanged: (value) => setState(() => blue = value.toInt()),
                color: Colors.blue,
                label: lang.blue,
              ),
            ],
          ),
        ),
        const Divider(),
        ColorInfo(
          color: Color.fromARGB(
            255,
            red,
            green,
            blue,
          ).withOpacity(opacity),
          slider: OpacitySlider(
            onChanged: (value) => setState(() => opacity = value),
            value: opacity,
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class Field extends StatelessWidget {
  const Field({
    Key? key,
    required this.color,
    required this.label,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final Color color;
  final String label;
  final double value;
  final Function(double) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
        child: Slider(
          value: value,
          onChanged: onChanged,
          max: 255,
          min: 0,
          label: label,
          activeColor: color,
          inactiveColor: color.withOpacity(0.2),
        ),
      ),
      Text(
        value.toInt().toString(),
        style: DefaultTextStyle.of(context).style,
      ),
      const SizedBox(width: 10),
    ]);
  }
}
