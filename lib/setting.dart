// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'dart:ffi';

import 'package:dha_anywaa_bible/choose_bible.dart';
// import 'package:dha_anywaa_bible/choose_font.dart';
import 'package:dha_anywaa_bible/classes/font_size.dart';
import 'package:dha_anywaa_bible/classes/font_style.dart';
import 'package:dha_anywaa_bible/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  // void changeTheme() {

  // }
  double _currentSliderValue = 15;
  FontSize fontSize = FontSize();
  SelectedFontStyle selectedFontStyle = SelectedFontStyle();
  String currentFontStyle = '';
  String fontName = '';

  void getFont() async {
    double savedFontSize = await fontSize.getFontSize();
    String savedFontStyle = await selectedFontStyle.getFontStyle();

    setState(() {
      _currentSliderValue = savedFontSize;
      currentFontStyle = savedFontStyle;
      switch (currentFontStyle) {
        //  Garamond    RobotoRegular  RobotoMono  RobotoSerif
        case 'UntitledSerif':
          fontName = 'Untitled';
          break;
        case 'RobotoRegular':
          fontName = 'Roboto';
          break;
        case 'RobotoMono':
          fontName = 'Roboto mono';
          break;
        case 'RobotoSerif':
          fontName = 'Roboto serif';
          break;
        case 'Garamond':
          fontName = 'Garamond';
          break;
      }
    });
    print('the font is saved');
  }

  // void getFont() async {
  //   setState(() async {
  //     _currentSliderValue = await fontSize.getFontSize();
  //   });
  //   print('the font is saved');
  // }

  void setFont(double font) async {
    await fontSize.setFontSize(font);
  }

  String versionAbbrev = '';
  String versionName = '';

  void getLanguageVersion() async {
    String languageVersion = await selectedFontStyle.getLanguageVersion();
    final version = languageVersion.split(' ');

    setState(() {
      versionAbbrev = version[0];
      versionName = languageVersion.substring(versionAbbrev.length + 1);
      print(versionAbbrev);
      print(versionName);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFont();
    getLanguageVersion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        forceMaterialTransparency: true,
      ),
      body: SafeArea(
        child: Consumer<UiProvider>(
            builder: (context, UiProvider notifier, child) {
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: Icon(
                      notifier.isDark ? Icons.dark_mode : Icons.light_mode),
                  title: Text('Dark Theme'),
                  trailing: Transform.scale(
                    scale: 0.8,
                    child: Switch(
                      onChanged: (value) => notifier.changeTheme(),
                      value: notifier.isDark,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Select Bible'),
                ),
                ListTile(
                  // leading: Icon(Icons.book),
                  title: Text(versionAbbrev),
                  onTap: () {
                    setState(() {
                      Navigator.pushNamed(context, '/chooseBible').then((_) {
                        getLanguageVersion();
                      });
                    });
                  },
                  subtitle: Text(
                    versionName,
                    style: TextStyle(color: Colors.grey),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios_rounded),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Select font type'),
                ),
                ListTile(
                  // leading: Icon(Icons.book),
                  title: Text(
                    fontName,
                    style: TextStyle(fontFamily: 'UntitledSerif'),
                  ),
                  onTap: () {
                    setState(() {
                      Navigator.pushNamed(context, '/chooseFont').then((_) {
                        setState(() {
                          getFont();

                          print('back');
                        });
                      });
                    });
                  },

                  trailing: Icon(Icons.arrow_forward_ios_rounded),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('font size'),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('A'),
                      Text(
                        'A',
                        style: TextStyle(fontSize: 19),
                      )
                    ],
                  ),
                ),
                Slider(
                    max: 30,
                    min: 15,
                    divisions: 15,
                    value: _currentSliderValue,
                    onChanged: (double value) {
                      setState(() {
                        setFont(value);
                        getFont();

                        print(_currentSliderValue);
                      });
                    }),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(color: Colors.transparent),
                    child: Text(
                      "Wïlöölö Dwøl nutö, ni Dwørøgøøni ena"
                      " kanya ciel ki Jwøk, ni Dwørøgøøni"
                      " beeye Jwøk.",
                      style: TextStyle(
                          fontSize: _currentSliderValue,
                          fontFamily: currentFontStyle),
                    ),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
