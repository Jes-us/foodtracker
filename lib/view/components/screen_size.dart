import 'package:flutter/material.dart';

class ScreenSizeProvider extends InheritedWidget {
  final double screenHeight;
  final double screenWidth;

  ScreenSizeProvider({
    Key? key,
    required Widget child,
    required this.screenHeight,
    required this.screenWidth,
  }) : super(key: key, child: child);

  static ScreenSizeProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ScreenSizeProvider>();
  }

  @override
  bool updateShouldNotify(ScreenSizeProvider oldWidget) {
    return screenHeight != oldWidget.screenHeight ||
        screenWidth != oldWidget.screenWidth;
  }
}
