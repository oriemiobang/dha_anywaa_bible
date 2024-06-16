import 'package:dha_anywaa_bible/components/about.dart';
import 'package:dha_anywaa_bible/components/chapter_list.dart';
import 'package:dha_anywaa_bible/components/choose_bible.dart';
import 'package:dha_anywaa_bible/components/choose_font.dart';
import 'package:dha_anywaa_bible/classes/SQLHelper.dart';
import 'package:dha_anywaa_bible/classes/dailyText.dart';
import 'package:dha_anywaa_bible/classes/font_size.dart';
import 'package:dha_anywaa_bible/classes/font_style.dart';
import 'package:dha_anywaa_bible/components/differentVerse.dart';
import 'package:dha_anywaa_bible/components/loading.dart';
import 'package:dha_anywaa_bible/components/pray.dart';
import 'package:dha_anywaa_bible/components/setting.dart';
import 'package:dha_anywaa_bible/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:once/once.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';

DailyVerse dailyVerse = DailyVerse();
int currentIndex = 0;

Future<void> _updateItem(int counter) async {
  final items = await SQLHelper.getItems();
  if (items.isNotEmpty) {
    await SQLHelper.updateItem(1, counter);
  }
}

Future<void> getItem() async {
  final items = await SQLHelper.getItems();
  if (items.isNotEmpty) {
    final item = await SQLHelper.getItem(1);
    currentIndex = item[0]['counter'];
  }
}

void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    await getItem();
    currentIndex = (currentIndex + 1) % dailyVerse.dailyVerseList.length;
    await _updateItem(currentIndex);
    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher);
  await Hive.initFlutter();
  await Hive.openBox('highlightText');
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
    super.initState();
    Workmanager().registerPeriodicTask('uniqueName', 'taskName',
        frequency: const Duration(minutes: 15),
        constraints: Constraints(networkType: NetworkType.not_required));
    Once.runOnce('key', callback: () {
      style.setBibleVersion('ANY/OT/GEN.json');
      style.setFontStyle('UntitledSerif');
      style.setPage(0);
      fontSize.setFontSize(18);
      style.setLanguageVersion('ANY');
      style.setBookIndex(0);
      style.setTestementNum(0);
    });
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
            '/': (context) => const Loading(),
            '/setting': (context) => const Setting(),
            '/chooseFont': (context) => const ChooseFont(),
            '/pray': (context) => const Pray(),
            '/chapterList': (context) => ChapterList(),
            '/chooseBible': (context) => const ChooseBible(),
            '/differentVerse': (context) => DifferentVerse(),
            '/about': (context) => const About(),
          },
          title: 'Weel jwok',
          debugShowCheckedModeBanner: false,
        );
      }),
    );
  }
}
