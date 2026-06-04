import 'dart:async';

import 'package:flutter/material.dart';
import 'package:bmi_calculator/utils/local_variables.dart';

class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key, required this.onValueChanged});

  final void Function(int) onValueChanged;

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int ageValue = 22;
  late Timer valueTimer;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTapDown: (TapDownDetails details) {
            valueTimer = Timer.periodic(
              Duration(milliseconds: 100),
              (Timer timer) {
                setState(() {
                  if (ageValue > 0) {
                    ageValue--;
                    widget.onValueChanged(ageValue);
                  }
                });
              },
            );
          },
          onTapUp: (TapUpDetails details) {
            valueTimer.cancel();
          },
          onTapCancel: () {
            valueTimer.cancel();
          },
          child: Icon(
            Icons.indeterminate_check_box_outlined,
            color: kMainBorderColor,
            size: 40,
          ),
        ),
        Text(
          "$ageValue",
          style: TextStyle(
            fontSize: 40,
            color: theme.primaryTextTheme.bodyLarge?.color,
          ),
        ),
        GestureDetector(
          onTapDown: (TapDownDetails details) {
            valueTimer = Timer.periodic(
              Duration(milliseconds: 100),
              (timer) {
                setState(() {
                  if (ageValue < 100) {
                    ageValue++;
                    widget.onValueChanged(ageValue);
                  }
                });
              },
            );
          },
          onTapUp: (TapUpDetails details) {
            valueTimer.cancel();
          },
          onTapCancel: () {
            valueTimer.cancel();
          },
          child: Icon(
            Icons.add_box_outlined,
            color: kMainBorderColor,
            size: 40,
          ),
        ),
      ],
    );
  }
}
