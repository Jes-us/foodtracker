import 'package:shared_preferences/shared_preferences.dart';

class TutorialService {
  // Guardar la variable que indica si se ha mostrado el tutorial
  Future<void> setTutorialShown(bool shown) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('tutorial_shown', shown);
  }

  // Recuperar el valor de la variable
  Future<bool> isTutorialShown() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('tutorial_shown') ??
        false; // Devuelve false si no existe
  }

  Future<void> setProductTutorialShown(bool shown) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('product_tutorial_shown', shown);
  }

  // Recuperar el valor de la variable
  Future<bool> isProductTutorialShown() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('product_tutorial_shown') ??
        false; // Devuelve false si no existe
  }

  //Guardar actual Theme
  Future<void> setActualTheme(bool isDark) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', isDark);
  }

  //Recuperar actual Theme
  Future<bool> getActualTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isDark') ?? false;
  }
}
