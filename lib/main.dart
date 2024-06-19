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
import 'package:dha_anywaa_bible/components/privacy_policy.dart';
import 'package:dha_anywaa_bible/components/setting.dart';
import 'package:dha_anywaa_bible/firebase_options.dart';
import 'package:dha_anywaa_bible/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:once/once.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';
import 'package:firebase_core/firebase_core.dart';

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

@pragma('vm:entry-point')
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

  // await JustAudioBackground.init(
  //     androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
  //     androidNotificationChannelName: 'Audio playback',
  //     androidNotificationOngoing: true);

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } on Exception catch (_, exe) {
    print(exe);
  }
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
    Duration initialDelay = _calculateInitialDelay();
    super.initState();
    Workmanager().registerPeriodicTask('uniqueName', 'taskName',
        frequency: const Duration(days: 1),
        initialDelay: initialDelay,
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

  Duration _calculateInitialDelay() {
    final now = DateTime.now();
    final nextMorning =
        DateTime(now.year, now.month, now.day, 1, 0, 0); // Next 1:00 AM
    if (now.isAfter(nextMorning)) {
      // If it's already past 1:00 AM today, set for 1:00 AM tomorrow
      return nextMorning.add(const Duration(days: 1)).difference(now);
    } else {
      // Otherwise, set for 1:00 AM today
      return nextMorning.difference(now);
    }
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
            '/privacy_policy': (context) => PrivacyPolicy(),
          },
          title: 'Weel jwok',
          debugShowCheckedModeBanner: false,
        );
      }),
    );
  }
}
