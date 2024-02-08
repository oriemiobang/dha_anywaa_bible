// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dha_anywaa_bible/choose_bible.dart';
import 'package:dha_anywaa_bible/choose_font.dart';
import 'package:dha_anywaa_bible/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  // void changeTheme() {

  // }
  double _currentSliderValue = 15;

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
                  title: Text('Dha anywaa'),
                  onTap: () {
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChooseBible()),
                      );
                    });
                  },
                  subtitle: Text(
                    'Weel jwok',
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
                  title: Text('Untitled'),
                  onTap: () {
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChooseFont()),
                      );
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
                    divisions: 15,
                    value: _currentSliderValue,
                    onChanged: (double value) {
                      setState(() {
                        _currentSliderValue = value;
                      });
                    }),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(color: Colors.transparent),
                    child: Text(
                      'my name is oriemi and i love coding currently i'
                      ' am working on dha anywaa bible',
                      style: TextStyle(fontSize: _currentSliderValue),
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
