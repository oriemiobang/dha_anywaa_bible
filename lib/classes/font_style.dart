import 'package:shared_preferences/shared_preferences.dart';

class SelectedFontStyle {
  String _selectedFont = 'UntitledSerif';
  String get selectedFont => _selectedFont;

  Future<String> getFontStyle() async {
    final prefs = await SharedPreferences.getInstance();
    _selectedFont = prefs.getString('fontStyle')!;
    return _selectedFont;
  }

  Future<void> setFontStyle(String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('fontStyle', value);
  }
}
