import 'package:shared_preferences/shared_preferences.dart';

class FontSize {
  Future<double> getFontSize() async {
    final prefs = await SharedPreferences.getInstance();
    final fontSize = prefs.getDouble('fontSize');
    return fontSize ?? 15;
  }

  Future<void> setFontSize(double value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble('fontSize', value);
  }
}
