import 'package:flutter/material.dart';
import 'package:foodtracker/view/components/screen_size.dart';
import 'package:foodtracker/view/cupboard_screen/cupboard_screen.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'core/app_export.dart';

ThemeMode customizedThemeMode = ThemeMode.dark;
String? email;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  runApp(const MyApp());
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
          ChangeNotifierProvider(create: (context) => ProductViewModel()),
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
