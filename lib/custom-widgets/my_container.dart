import 'package:flutter/material.dart';
import 'package:bmi_calculator/utils/local_variables.dart';

class MyContainer extends StatelessWidget {
  const MyContainer(
      {super.key,
      this.child,
      this.borderColor = kMainBorderColor,
      this.borderWidth = 10,
      this.onTap,
      this.height = 200});

  final Color borderColor;
  final double borderWidth;
  final double height;
  final Widget? child;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.01),
        height: height,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: borderColor,
            width: borderWidth,
          ),
        ),
        child: child,
      ),
    );
  }
}
