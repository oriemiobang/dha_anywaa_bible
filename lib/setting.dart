// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

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
          return Column(
            children: [
              ListTile(
                leading:
                    Icon(notifier.isDark ? Icons.dark_mode : Icons.light_mode),
                title: Text('Dark Theme'),
                trailing: Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    onChanged: (value) => notifier.changeTheme(),
                    value: notifier.isDark,
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
