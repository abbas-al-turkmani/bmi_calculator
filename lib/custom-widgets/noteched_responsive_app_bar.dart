import 'package:flutter/material.dart';

class NotechedResponsiveAppBar extends StatefulWidget {
  const NotechedResponsiveAppBar({
    super.key,
    required this.pageBody,
    required this.body,
    this.shape = NotechedResponsiveAppBarShape.rounded,
    this.onButtonPressed,
    this.afterButtonPressed,
    this.maxHeight = 5000,
    this.child,
    this.buttonChild,
    this.color,
    this.buttonColor,
    this.shadowColor = Colors.black,
    this.allowShadow = false,
    this.hasCenterButton = true,
    this.animationDuration = const Duration(seconds: 1),
    this.animationCurve = Curves.easeIn,
  });

  final Widget pageBody;
  final Widget body;
  final Widget? child;
  final Widget? buttonChild;

  final Color? color;
  final Color? buttonColor;
  final Color shadowColor;

  final bool allowShadow;
  final bool hasCenterButton;

  final double maxHeight;

  final Duration animationDuration;
  final Curve animationCurve;

  final NotechedResponsiveAppBarShape shape;

  final void Function()? onButtonPressed;
  final void Function()? afterButtonPressed;

  @override
  State<NotechedResponsiveAppBar> createState() =>
      _NotechedResponsiveAppBarState();
}

class _NotechedResponsiveAppBarState extends State<NotechedResponsiveAppBar> {
  bool _isShown = false;

  late Map<NotechedResponsiveAppBarShape, CustomPainter> _shapes;

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final Size _screenSize = MediaQuery.of(context).size;
    // ignore: no_leading_underscores_for_local_identifiers
    final ThemeData _theme = Theme.of(context);

    // ignore: no_leading_underscores_for_local_identifiers
    final double _buttomAppBarHeight = _screenSize.height * 0.1;

    // ignore: no_leading_underscores_for_local_identifiers
    double _containerHeight = _isShown ? widget.maxHeight : _buttomAppBarHeight;

    widget.color ?? _theme.bottomAppBarTheme.color;

    // ignore: prefer_typing_uninitialized_variables, no_leading_underscores_for_local_identifiers
    late CustomPainter _shape = _shapes[widget.shape]!;

    _shapes = {
      NotechedResponsiveAppBarShape.rounded: NotechedRoundedPainter(
        widget.color!,
        widget.allowShadow,
        widget.shadowColor,
        widget.hasCenterButton,
      ),
      NotechedResponsiveAppBarShape.wave: NotechedWavePainter(
        widget.color!,
        widget.allowShadow,
        widget.shadowColor,
        widget.hasCenterButton,
      ),
    };

    return Stack(
      children: [
        widget.pageBody,
        AnimatedPositioned(
          duration: widget.animationDuration,
          curve: widget.animationCurve,
          bottom: 0,
          left: 0,
          height: _containerHeight,
          child: Container(
            width: _screenSize.width,
            height: widget.maxHeight,
            color: Colors.transparent,
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    0,
                    _buttomAppBarHeight,
                    0,
                    0,
                  ),
                  child: Container(
                    width: _screenSize.width,
                    height: widget.maxHeight,
                    color: widget.color,
                    child: widget.body,
                  ),
                ),
                CustomPaint(
                  size: Size(_screenSize.width, _buttomAppBarHeight),
                  painter: _shape,
                ),
                SizedBox(
                  width: _screenSize.width,
                  height: _buttomAppBarHeight,
                  child: widget.child,
                ),
                Center(
                  heightFactor: 0.6,
                  child: widget.hasCenterButton
                      ? FloatingActionButton(
                          onPressed: () {
                            widget.onButtonPressed!();

                            setState(() {
                              _isShown = !_isShown;
                            });

                            widget.afterButtonPressed!();
                          },
                          backgroundColor: widget.buttonColor,
                          elevation: 0.1,
                          child: widget.buttonChild,
                        )
                      : null,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class NotechedWavePainter extends CustomPainter {
  NotechedWavePainter(
    this.color,
    this.allowShadow,
    this.shadowColor,
    this.hasCenterButton,
  );

  final Color color;
  final Color shadowColor;

  final bool allowShadow;
  final bool hasCenterButton;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    double x1 = size.width * 0.2,
        x2 = size.width * 0.35,
        x3 = size.width * 0.4,
        x4 = size.width * 0.6,
        x5 = size.width * 0.65,
        x6 = size.width * 0.8,
        y1 = size.height * 0.3,
        y2 = size.height * 0.4;

    Path path = Path()..moveTo(0, y2);

    path.quadraticBezierTo(x1, 0, x2, 0);
    path.quadraticBezierTo(x3, 0, x3, hasCenterButton ? y2 : 0);

    if (hasCenterButton) {
      path.arcToPoint(Offset(x4, y1),
          radius: Radius.circular(10), clockwise: false);
    }

    path.quadraticBezierTo(x4, 0, x5, 0);
    path.quadraticBezierTo(x6, 0, size.width, y1);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    // double p = size.height * 0.4;

    // Path path = Path()..moveTo(0, p);

    // path.quadraticBezierTo(size.width * 0.2, 0, size.width * 0.35, 0);
    // path.quadraticBezierTo(
    //     size.width * 0.4, 0, size.width * 0.4, hasCenterButton ? p : 0);

    // if (hasCenterButton) {
    //   path.arcToPoint(Offset(size.width * 0.6, size.height * 0.3),
    //       radius: Radius.circular(10), clockwise: false);
    // }

    // path.quadraticBezierTo(size.width * 0.6, 0, size.width * 0.65, 0);
    // path.quadraticBezierTo(size.width * 0.8, 0, size.width, p);

    // path.lineTo(size.width, size.height);
    // path.lineTo(0, size.height);

    path.close();

    canvas.drawPath(path, paint);

    if (allowShadow) canvas.drawShadow(path, shadowColor, 5, true);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class NotechedRoundedPainter extends CustomPainter {
  NotechedRoundedPainter(
    this.color,
    this.allowShadow,
    this.shadowColor,
    this.hasCenterButton,
  );

  final Color color;
  final Color shadowColor;

  final bool allowShadow;
  final bool hasCenterButton;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    double x1 = size.width * 0.01,
        x2 = size.width * 0.1,
        x3 = size.width * 0.4,
        x4 = size.width * 0.6,
        x5 = size.width * 0.65,
        x6 = size.width * 0.9,
        x7 = size.width * 0.99,
        y1 = size.height * 0.3,
        y2 = size.height * 0.5;

    Path path = Path()..moveTo(0, y2);

    path.quadraticBezierTo(x1, 0, x2, 0);
    path.lineTo(size.width * 0.35, 0);
    path.quadraticBezierTo(x3, 0, x3, hasCenterButton ? y2 : 0);

    if (hasCenterButton) {
      path.arcToPoint(Offset(x4, y1),
          radius: Radius.circular(10), clockwise: false);
    }

    path.quadraticBezierTo(x4, 0, x5, 0);
    path.lineTo(x6, 0);
    path.quadraticBezierTo(x7, 0, size.width, y2);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    path.close();

    canvas.drawPath(path, paint);

    if (allowShadow) canvas.drawShadow(path, shadowColor, 5, true);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

// Path _drawPath(x1, x2, x3, x4, x5, x6, y1, y2, height, width, hasCenterButton) {
//   Path path = Path()..moveTo(0, y2);

//   path.quadraticBezierTo(x1, 0, x2, 0);
//   path.quadraticBezierTo(x3, 0, x3, hasCenterButton ? y2 : 0);

//   if (hasCenterButton) {
//     path.arcToPoint(Offset(x4, y1),
//         radius: Radius.circular(10), clockwise: false);
//   }

//   path.quadraticBezierTo(x4, 0, x5, 0);
//   path.quadraticBezierTo(x6, 0, width, y1);

//   path.lineTo(width, height);
//   path.lineTo(0, height);

//   path.close();
//   return path;
// }

enum NotechedResponsiveAppBarShape {
  rounded,
  wave,
}
