import 'package:flutter/material.dart';

class ScreenSizeProvider extends InheritedWidget {
  final double screenHeight;
  final double screenWidth;

  const ScreenSizeProvider({
    super.key,
    required super.child,
    required this.screenHeight,
    required this.screenWidth,
  });

  static ScreenSizeProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ScreenSizeProvider>();
  }

  @override
  bool updateShouldNotify(ScreenSizeProvider oldWidget) {
    return screenHeight != oldWidget.screenHeight ||
        screenWidth != oldWidget.screenWidth;
  }
}
