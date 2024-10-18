import 'package:flutter/material.dart';
import 'package:foodtracker/view_model/shared_preferences_services.dart';

const Color _colorSeed = Color.fromARGB(215, 252, 137, 7);

const kColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFFF05833), //color agregado
  onPrimary: Color(0xFFFFFFFF), //color agregadp
  primaryContainer: Color(0xFFFFFFFF), //Color(0xFFe9ddc7),color agregado
  onPrimaryContainer: Color(0xFFF05833), // agregado
  secondary: Color(0xFFF8FDFF), //color
  onSecondary: Color(0xFF0e4d6c), //color
  secondaryContainer: Color(0xFF000000),
  onSecondaryContainer: Color(0xFF001D34),
  tertiary: Color(0xFFC00012),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFFFDAD6),
  onTertiaryContainer: Color(0xFFFFFFFF),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  surface: Color(0xFFE9DDC7), //agregado
  onSurface: Color(0xFF2c4653), //agregado
  surfaceContainerHighest: Color(0xFFFFFFFF),
  onSurfaceVariant: Color(0xFF3F484A),
  outline: Color(0xFF6F797A),
  onInverseSurface: Color(0xFFD6F6FF),
  inverseSurface: Color(0xFF00363F),
  inversePrimary: Color(0xFF4FD8EB),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF006874),
  outlineVariant: Color(0xFFBFC8CA),
  scrim: Color(0xFF000000),
);

const kDarkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFF05833), //color agregado
  onPrimary: Color(0xFFFFFFFF), //color agregadp
  primaryContainer: Color(0xFF0E4D6C), //color agregado
  onPrimaryContainer: Color(0xFFE9DDC7),
  secondary: Color(0xFF0e4d6c),
  onSecondary: Color(0xFFF8FDFF),
  secondaryContainer: Color(0xFF004A78),
  onSecondaryContainer: Color(0xFFCFE5FF),
  tertiary: Color(0xFFFFB4AB),
  onTertiary: Color(0xFF690005),
  tertiaryContainer: Color(0xFF93000B),
  onTertiaryContainer: Color(0xFFFFDAD6),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  surface: Color(0xFF2c4653), //agregado
  onSurface: Color(0xFFE9DDC7), //agregadp
  surfaceContainerHighest: Color(0xFF3F484A),
  onSurfaceVariant: Color(0xFFBFC8CA),
  outline: Color(0xFF899294),
  onInverseSurface: Color(0xFF001F25),
  inverseSurface: Color(0xFFA6EEFF),
  inversePrimary: Color(0xFF006874),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF4FD8EB),
  outlineVariant: Color(0xFF3F484A),
  scrim: Color(0xFF000000),
);

fromSeed({
  required Color seedColor,
  required brightness,
  Color? primary,
  Color? onPrimary,
  Color? primaryContainer,
  Color? onPrimaryContainer,
  Color? secondary,
  Color? onSecondary,
  Color? secondaryContainer,
  Color? onSecondaryContainer,
  Color? tertiary,
  Color? onTertiary,
  Color? tertiaryContainer,
  Color? onTertiaryContainer,
  Color? error,
  Color? onError,
  Color? errorContainer,
  Color? onErrorContainer,
  Color? outline,
  Color? outlineVariant,
  Color? background,
  Color? onBackground,
  Color? surface,
  Color? onSurface,
  Color? surfaceVariant,
  Color? onSurfaceVariant,
  Color? inverseSurface,
  Color? onInverseSurface,
  Color? inversePrimary,
  Color? shadow,
  Color? scrim,
  Color? surfaceTint,
}) {
  final ColorScheme scheme;
  switch (brightness) {
    case Brightness.light:
      scheme = ColorScheme.fromSeed(
        brightness: Brightness.light,
        seedColor: seedColor,
      );
      return scheme;
    case Brightness.dark:
      scheme = ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: seedColor,
      );
      return scheme;
  }
}

class Manage extends ChangeNotifier {
  Manage(this.actualTheme);
  TutorialService prefs = TutorialService();
  ThemeMode actualTheme;

  void changeTheme(ThemeMode theme) {
    var chageFlag = 0;

    if (actualTheme == ThemeMode.dark && chageFlag == 0) {
      actualTheme = ThemeMode.light;
      chageFlag = 1;
      prefs.setActualTheme(false);
    }
    if (actualTheme == ThemeMode.light && chageFlag == 0) {
      actualTheme = ThemeMode.dark;
      chageFlag = 1;
      prefs.setActualTheme(true);
    }

    notifyListeners();
  }

  ThemeMode getActualTheme() {
    return actualTheme;
  }
}
