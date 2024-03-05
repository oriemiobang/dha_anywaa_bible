import 'package:shared_preferences/shared_preferences.dart';

class SelectedFontStyle {
  String _selectedFont = 'UntitledSerif';
  String get selectedFont => _selectedFont;

  String _bibleVersion = 'NT/MAT/KJV.json';
  String get bibleVersion => _bibleVersion;
  int _page = 0;
  int get page => _page;
  String _languageVersion = '';

  late SharedPreferences preference;

  // SelectedFontStyle() {
  //   preference.setString('fontStyle', _selectedFont);
  //   preference.setInt('page', _page);
  //   preference.setString('bibleVersion', _bibleVersion);
  // }

  // ============== font style ===============

  Future<String> getFontStyle() async {
    final prefs = await SharedPreferences.getInstance();
    _selectedFont = prefs.getString('fontStyle')!;

    return _selectedFont;
  }

  Future<void> setFontStyle(String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('fontStyle', value);
  }
  // ============== bible version ===============

  Future<String> getLanguageVersion() async {
    final prefs = await SharedPreferences.getInstance();
    _bibleVersion = prefs.getString('languageVersion')!;
    return _bibleVersion;
  }

  Future<void> setLanguageVersion(String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('languageVersion', value);
  }

// ===========page number ============
  Future<int> getPage() async {
    final prefs = await SharedPreferences.getInstance();
    _page = prefs.getInt('page')!;
    return _page;
  }

  Future<void> setPage(int value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('page', value);
    print('current page: $_page and selected page: $value');
  }

// ============ bible version ======================
  Future<String> getBibleVersion() async {
    final prefs = await SharedPreferences.getInstance();
    _bibleVersion = prefs.getString('bibleVersion')!;
    return _bibleVersion;
  }

  Future<void> setBibleVersion(String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('bibleVersion', value);
  }

  init() async {
    final prefs = await SharedPreferences.getInstance();
    _selectedFont = prefs.getString('fontStyle') ?? 'UntitledSerif';
    _bibleVersion = prefs.getString('bibleVersion') ?? 'NT/MAT/KJV.json';
    _page = prefs.getInt('page') ?? 0;
  }
}
