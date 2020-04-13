//
//  lib/widgets/radio_widget.dart
//
//  Created by Denis Bystruev on 12/04/2020.
//
//  Derived from https://api.flutter.dev/flutter/material/RadioListTile-class.html
//

import 'package:flutter/material.dart';

class RadioWidget extends StatelessWidget {
  const RadioWidget({
    this.groupValue,
    this.label,
    this.labelFlex = 1,
    this.onChanged,
    this.scale = 1,
    this.value,
  });

  final int groupValue;
  final Widget label;
  final int labelFlex;
  final Function(int) onChanged;
  final double scale;
  final int value;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        children: <Widget>[
          Flexible(
            child: Radio<int>(
              activeColor: Color(0xFF54615F),
              groupValue: groupValue,
              onChanged: (int newValue) => onChanged(newValue),
              value: value,
              visualDensity: VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity,
              ),
            ),
            flex: 1,
          ),
          Flexible(child: label, flex: labelFlex),
        ],
      ),
      onTap: () {
        if (value != groupValue) onChanged(value);
      },
    );
  }
}
