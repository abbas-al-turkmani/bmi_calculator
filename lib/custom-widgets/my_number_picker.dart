import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class MyNumberPicker extends StatefulWidget {
  MyNumberPicker({Key? key, required this.onValueChanged}) : super(key: key);

  final void Function(int value) onValueChanged;

  @override
  State<MyNumberPicker> createState() => _MyNumberPickerState();
}

class _MyNumberPickerState extends State<MyNumberPicker> {
  late int weightValue = 70;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Center(
      child: NumberPicker(
        axis: Axis.horizontal,
        value: weightValue,
        minValue: 0,
        maxValue: 250,
        itemWidth: MediaQuery.of(context).size.width * 0.1,
        textStyle: TextStyle(
          fontSize: 10,
          color: theme.primaryTextTheme.bodyLarge?.color,
        ),
        selectedTextStyle: TextStyle(
          fontSize: 15,
          color: theme.primaryTextTheme.bodyMedium?.color,
          fontWeight: FontWeight.bold,
        ),
        decoration: BoxDecoration(
          color: Color.fromARGB(100, 227, 227, 227),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black26),
        ),
        onChanged: (value) {
          setState(() {
            weightValue = value;
          });
          widget.onValueChanged(value);
        },
      ),
    );
  }
}
