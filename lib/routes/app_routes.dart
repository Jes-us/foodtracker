import 'package:flutter/material.dart';
import 'package:foodtracker/view/cupboard_screen/cupboard_screen.dart';
//import 'package:foodtracker/presentation/forgot_password_screen/forgot_password_screen.dart';
//import 'package:foodtracker/presentation/offline_work_screen/offline_work_screen.dart';
//import 'package:foodtracker/presentation/user_account_screen/user_account_screen.dart';

class AppRoutes {
  static const String accountCreationScreen = '/account_creation_screen';

  static const String emailLoginScreen = '/email_login_screen';

  static const String cupBoardScreen = '/cupboard_screen';
  //static const String forgotPasswordScreen = '/forgot_password_screen';

  // static const String offlineWorkScreen = '/offline_work_screen';

  // static const String userAccountScreen = '/user_account_screen';

  static const String signupLoginModuleScreen = '/signup_login_module_screen';

  static const String splashScreen = '/splash_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static Map<String, WidgetBuilder> routes = {
    cupBoardScreen: (context) => HomePage(),
  };
}
