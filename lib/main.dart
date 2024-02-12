// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:dha_anywaa_bible/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'HomePage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => UiProvider()..init(),
      child:
          Consumer<UiProvider>(builder: (context, UiProvider notifier, child) {
        return MaterialApp(
          themeMode: notifier.isDark ? ThemeMode.dark : ThemeMode.light,
          darkTheme: notifier.isDark ? notifier.darkTheme : notifier.lightTheme,

          title: 'Weel jwok',
          // color: const Color.fromARGB(255, 2, 27, 48),
          debugShowCheckedModeBanner: false,
          // theme: Provider.of<ThemeProvider>(context).themeData,
          home: HomePage(),
        );
      }),
    );
  }
}
