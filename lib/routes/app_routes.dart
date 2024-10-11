import 'package:flutter/material.dart';
import 'package:foodtracker/view/cupboard_screen/cupboard_screen.dart';

class AppRoutes {
  static const String cupBoardScreen = '/cupboard_screen';

  static Map<String, WidgetBuilder> routes = {
    cupBoardScreen: (context) => HomePage(),
  };
}
