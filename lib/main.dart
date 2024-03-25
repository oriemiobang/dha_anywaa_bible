// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

// import 'package:dha_anywaa_bible/pray.dart';
import 'package:dha_anywaa_bible/chapter_list.dart';

import 'package:dha_anywaa_bible/choose_bible.dart';
import 'package:dha_anywaa_bible/choose_font.dart';
import 'package:dha_anywaa_bible/classes/SQLHelper.dart';
import 'package:dha_anywaa_bible/classes/dailyText.dart';
import 'package:dha_anywaa_bible/classes/font_size.dart';
import 'package:dha_anywaa_bible/classes/font_style.dart';
import 'package:dha_anywaa_bible/differentVerse.dart';
// import 'package:dha_anywaa_bible/daily_text.dart';
import 'package:dha_anywaa_bible/pray.dart';
import 'package:dha_anywaa_bible/setting.dart';
import 'package:dha_anywaa_bible/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:once/once.dart';
// import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';
import 'HomePage.dart';

DailyVerse dailyVerse = DailyVerse();
int currentIndex = 0;

Future<void> _updateItem(int counter) async {
  final items = await SQLHelper.getItems();
  if (items.isNotEmpty) {
    await SQLHelper.updateItem(1, counter);
    print('list aint\'t  empty');
  }

  print('is items empty?: ${items.isEmpty}');
}

Future<void> getItem() async {
  final items = await SQLHelper.getItems();
  if (items.isNotEmpty) {
    final item = await SQLHelper.getItem(1);
    currentIndex = item[0]['counter'];
  }

  print('is items empty??: ${items.isEmpty}');
}

void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    await getItem();
    print('before incrementing: $currentIndex');
    currentIndex = (currentIndex + 1) % dailyVerse.dailyVerseList.length;
    print('after incrementig: $currentIndex');
    await _updateItem(currentIndex);
    print('index: $currentIndex');
    print('task executed: $taskName');
    return Future.value(true);
  });
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher);
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FontSize fontSize = FontSize();
  SelectedFontStyle style = SelectedFontStyle()..init();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Workmanager().registerPeriodicTask('uniqueName', 'taskName',
        frequency: Duration(minutes: 15),
        constraints: Constraints(networkType: NetworkType.not_required));
    Once.runOnce('key', callback: () {
      style.setBibleVersion('OT/GEN/ERV.json');
      style.setFontStyle('UntitledSerif');
      style.setPage(0);
      fontSize.setFontSize(16);
      style.setLanguageVersion('ERV');
    });
    // myManager();
  }

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
          initialRoute: '/',
          routes: {
            '/': (context) => HomePage(),
            '/setting': (context) => Setting(),
            '/chooseFont': (context) => ChooseFont(),
            '/pray': (context) => Pray(),
            '/chapterList': (context) => ChapterList(),
            '/chooseBible': (context) => ChooseBible(),
            '/differentVerse': (context) => DifferentVerse(),
          },

          title: 'Weel jwok',
          // color: const Color.fromARGB(255, 2, 27, 48),
          debugShowCheckedModeBanner: false,
          // theme: Provider.of<ThemeProvider>(context).themeData,
          // home: HomePage(),
        );
      }),
    );
  }
}
