import 'package:flutter/material.dart';
import 'package:foodtracker/view/components/screen_size.dart';
import 'package:foodtracker/view/cupboard_screen/cupboard_screen.dart';
import 'package:foodtracker/view_model/internet_connection_view_model.dart';
import 'package:foodtracker/view_model/shared_preferences_services.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'core/app_export.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

ThemeMode customizedThemeMode = ThemeMode.light;
String? email;
ProductViewModel productViewModel = ProductViewModel();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  sqfliteFfiInit();
  await productViewModel.getDataBaseProducts();
  await getThemeMode();
  runApp(const MyApp());
}

getThemeMode() async {
  TutorialService prefs = TutorialService();
  bool themeMode = await prefs.getActualTheme();
  if (themeMode == true) {
    customizedThemeMode = ThemeMode.dark;
  } else {
    customizedThemeMode = ThemeMode.light;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => Manage(customizedThemeMode),
          ),
          ChangeNotifierProvider(create: (context) => productViewModel),
          ChangeNotifierProvider(create: (context) => ConnectivityModel()),
        ],
        child: Consumer<Manage>(
          builder: (context, Manage themenotifier, child) {
            return ScreenSizeProvider(
              screenHeight: MediaQuery.of(context).size.height,
              screenWidth: MediaQuery.of(context).size.width,
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                themeMode: themenotifier.getActualTheme(),
                theme: ThemeData(
                    colorScheme: kColorScheme,
                    useMaterial3: true,
                    iconTheme: IconThemeData(color: kColorScheme.onPrimary),
                    filledButtonTheme: FilledButtonThemeData(
                        style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.resolveWith((states) {
                        return kColorScheme.primary;
                      }),
                      textStyle: WidgetStateProperty.resolveWith((states) {
                        return TextStyle(color: kColorScheme.onPrimary);
                      }),
                    )),
                    floatingActionButtonTheme: FloatingActionButtonThemeData(
                        backgroundColor: kColorScheme.primary),
                    dialogBackgroundColor:
                        Theme.of(context).colorScheme.surface),
                darkTheme: ThemeData(
                  colorScheme: kDarkColorScheme,
                  useMaterial3: true,
                  iconTheme: IconThemeData(color: kDarkColorScheme.onPrimary),
                  floatingActionButtonTheme: FloatingActionButtonThemeData(
                      backgroundColor: kDarkColorScheme.primary),
                  filledButtonTheme: FilledButtonThemeData(
                      style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith((states) {
                      return kColorScheme.primary;
                    }),
                    textStyle: WidgetStateProperty.resolveWith((states) {
                      return TextStyle(color: kColorScheme.onPrimary);
                    }),
                  )),
                ),
                home: HomePage(),
              ),
            );
          },
        ));
  }
}
