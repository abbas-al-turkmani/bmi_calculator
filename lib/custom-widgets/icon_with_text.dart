import 'package:flutter/material.dart';

class IconWithText extends StatelessWidget {
  const IconWithText(
      {super.key,
      this.icon,
      required this.text,
      this.iconColor,
      this.iconSize = 50,
      this.textSize = 20});

  final String text;
  final double iconSize;
  final double textSize;

  final IconData? icon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: iconSize,
          color: iconColor,
        ),
        Text(
          text,
          style: TextStyle(
            color: theme.primaryTextTheme.bodyLarge!.color,
            fontWeight: FontWeight.bold,
            fontSize: textSize,
          ),
        ),
      ],
    );
  }
}
