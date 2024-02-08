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
      textTheme: const TextTheme(
          bodyLarge: TextStyle(fontFamily: 'UntitledSerif'),
          bodyMedium: TextStyle(fontFamily: 'UntitledSerif')),
      fontFamily: 'UntitledSerif',
      appBarTheme: AppBarTheme(color: Colors.transparent),
      textButtonTheme: const TextButtonThemeData(
          style: ButtonStyle(
              foregroundColor: MaterialStatePropertyAll(Colors.white))),
      buttonTheme: const ButtonThemeData(buttonColor: Colors.white),
      // fontFamily: 'UntitledSerif',
      primaryColor: const Color.fromARGB(255, 1, 11, 36),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color.fromARGB(255, 1, 11, 36)),
      scaffoldBackgroundColor: const Color.fromARGB(255, 1, 11, 36),
      brightness: Brightness.dark,
      primaryColorDark: const Color.fromARGB(255, 1, 11, 36));
  final lightTheme = ThemeData(
      fontFamily: 'UntitledSerif',

      // fontFamily: 'UntitledSerif',
      primaryColor: Colors.white,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
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
