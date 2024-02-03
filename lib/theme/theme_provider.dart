// import 'package:dha_anywaa_bible/theme/theme.dart';
// import 'package:flutter/material.dart';

// class ThemeProvider with ChangeNotifier {
//   ThemeData _themeData = lightMode;
//   ThemeData get themeData => _themeData;
//   set themeData(ThemeData themeData) {
//     _themeData = themeData;
//     notifyListeners();
//   }

//   void toggleTheme() {
//     if (_themeData == lightMode) {
//       _themeData = darkMode;
//     } else {
//       _themeData = lightMode;
//     }
//     notifyListeners();
//   }
// }

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UiProvider extends ChangeNotifier {
  bool _isDark = false;
  bool get isDark => _isDark;

  late SharedPreferences storage;

  changeTheme() {
    _isDark = !isDark;
    storage.setBool('isDark', _isDark);
    notifyListeners();
  }

  final darkTheme = ThemeData(
      // fontFamily: 'UntitledSerif',
      primaryColor: Color.fromARGB(255, 1, 11, 36),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Color.fromARGB(255, 1, 11, 36)),
      scaffoldBackgroundColor: Color.fromARGB(255, 1, 11, 36),
      brightness: Brightness.dark,
      primaryColorDark: Color.fromARGB(255, 1, 11, 36));
  final lightTheme = ThemeData(
      // fontFamily: 'UntitledSerif',
      primaryColor: Colors.white,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
      ),
      brightness: Brightness.light,
      primaryColorDark: Colors.white);
  init() async {
    storage = await SharedPreferences.getInstance();
    _isDark = storage.getBool('isDark') ?? false;
    notifyListeners();
  }
}
