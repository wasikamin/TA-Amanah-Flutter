import 'package:amanah/constants/app_theme.dart';
import 'package:flutter/material.dart';

class DurasiSlider extends StatefulWidget {
  DurasiSlider({
    super.key,
    required this.startValue,
    required this.endValue,
    required this.onChanged,
  });

  final double startValue;
  final double endValue;
  final ValueChanged<RangeValues> onChanged;

  @override
  _DurasiSliderState createState() => _DurasiSliderState();
}

class _DurasiSliderState extends State<DurasiSlider> {
  RangeValues _values = RangeValues(0, 12);

  @override
  void initState() {
    super.initState();
    _values = RangeValues(widget.startValue, widget.endValue);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RangeSlider(
          min: 0.0,
          max: 12.0,
          divisions: 12,
          activeColor: primaryColor,
          inactiveColor: Colors.grey[300],
          labels: RangeLabels(
            _values.start.round().toString() + " Bulan",
            _values.end.round().toString() + " Bulan",
          ),
          values: _values,
          onChanged: (values) {
            setState(() {
              _values = values;
              widget.onChanged(values);
            });
          },
        ),
        Text(
          _values.start.round().toString() +
              " - " +
              _values.end.round().toString() +
              " Bulan",
          style: bodyTextStyle.copyWith(
            fontSize: 12,
            color: Colors.grey.shade400,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
