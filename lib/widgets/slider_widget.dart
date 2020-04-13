//
//  lib/widgets/slider_widget.dart
//
//  Created by Denis Bystruev on 13/04/2020.
//

import 'package:flutter/material.dart';
import 'package:get_outfit/widgets/futura_widgets.dart';

class SliderWidget extends StatelessWidget {
  final String label;
  final int max;
  final int min;
  final void Function(int value, String label) onChanged;
  final double scale;
  final int value;

  SliderWidget({
    this.label,
    this.max = 100,
    this.min = 0,
    @required this.onChanged,
    @required this.scale,
    this.value = 50,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Flexible(child: Container(), flex: value - min),
            FuturaBookText.normal(label ?? '$value', fontSize: 10 * scale),
            Flexible(child: Container(), flex: max - value),
          ],
        ),
        SizedBox(height: 4 * scale),
        SliderTheme(
          data: SliderThemeData(
            overlayShape: RoundSliderOverlayShape(overlayRadius: 8 * scale),
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8 * scale),
            tickMarkShape: SliderTickMarkShape.noTickMark,
          ),
          child: Slider(
            activeColor: Colors.black,
            inactiveColor: Color(0xFFC4C4C4),
            divisions: max - min,
            max: max.toDouble(),
            min: min.toDouble(),
            label: '$value',
            onChanged: (value) => onChanged(value.round(), ''),
            onChangeEnd: (value) =>
                onChanged(value.round(), '${value.round()}'),
            onChangeStart: (value) => onChanged(value.round(), ''),
            value: value.toDouble(),
          ),
        ),
        SizedBox(height: 10 * scale),
        Padding(
          child: Row(
            children: <Widget>[
              FuturaBookText.normal('$min', fontSize: 12 * scale),
              FuturaBookText.normal('$max', fontSize: 12 * scale),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
          padding: EdgeInsets.symmetric(horizontal: 8 * scale),
        ),
      ],
    );
  }
}
