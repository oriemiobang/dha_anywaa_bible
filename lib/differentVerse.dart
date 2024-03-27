import 'dart:convert';

import 'package:dha_anywaa_bible/Book.dart';
import 'package:dha_anywaa_bible/classes/font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DifferentVerse extends StatefulWidget {
  const DifferentVerse({super.key});

  @override
  State<DifferentVerse> createState() => _DifferentVerseState();
}

class _DifferentVerseState extends State<DifferentVerse> {
  String englishJsonString = 'assets/holybooks/$bibleVersion';
  String amharicJsonString = 'assets/holybooks/AM/$amhBibleVersion';

  Future<String> _engLoadData() async {
    return await rootBundle.loadString(englishJsonString);
  }

  Future<String> _amhLoadData() async {
    return await rootBundle.loadString(amharicJsonString);
  }

  EnglishBook? englishBook;
  AmharicChapters? amharicBook;
  SelectedFontStyle style = SelectedFontStyle()..init();
  static String bibleVersion = '';
  static String amhBibleVersion = '';
  String verseTitle = '';
  int currentChapter = 0;
  String currentVerse = '';
//  String NASB = '';
//     "KJV",
//     "ERV",
//     "AMP",
//     "ASV",
//     "CPDV",
//     "ESV",
//     "WEB",

  Future engLoadData(args) async {
    try {
      String engJsonString = await _engLoadData();
      final engJsonResponse = json.decode(engJsonString);
      setState(() {
        englishBook = EnglishBook.fromJson(engJsonResponse);
        print(args[0]['pageIndex']);
        int pageIndex = args[0]['pageIndex'];
        int listIndex = args[0]['listIndex'];
        String currentVersion = args[0]['version'];
        String title = args[0]['title'];
        // print(pageIndex);
        print(listIndex);
        if (englishBook!.chapters[pageIndex].verses != null) {
          for (var verse in englishBook!.chapters[pageIndex].verses) {
            if ("${listIndex + 1}" == verse.id && verse.text != "") {
              versionsList.add({
                'text': verse.text,
                'version': currentVersion,
                'chapter': pageIndex + 1,
                'verse': listIndex + 1,
                'title': title
              });

              setState(() {
                currentVerse = verse.id;
                verseTitle = args[0]['title'];
                currentChapter = args[0]['pageIndex'] + 1;
                // print(args[0]['title']);
                // print(args[0]['pageIndex'] + 1);
                // chapter = args[0]['pageIndex'] + 1;
              });

              break;
            }
          }
        }

        // title = englishBook!.name;
      });
    } catch (e) {
      print('english problem');
      print(e);
    }
  }

  Future amhLoadData() async {
    try {
      String amhJsonString = await _amhLoadData();
      final amhJsonResponse = json.decode(amhJsonString);
      setState(() {
        amharicBook = AmharicChapters.fromJson(amhJsonResponse);
        // title = amharicBook!.title;
        // print('${amharicBook.chapters[0].verses[1]}');
      });
    } catch (e) {
      print('amharic problem');
      print(e);
    }
  }

  void _refresher(args) async {
    bibleVersion = await style.getBibleVersion();
    List splitVersion = bibleVersion.split('/');

    for (String version in versions) {
      if (version == "AMH") {
      } else {
        String currentVersion =
            '${splitVersion[0]}/${splitVersion[1]}/$version.json';
        setState(() {
          bibleVersion = currentVersion;
          englishJsonString = 'assets/holybooks/$currentVersion';

          // print(currentVersion);
          engLoadData(arguments);
          // var currentText = englishBook?.chapters[0].verses[0].text;
          // print(currentText);
        });
      }
    }
    setState(() {});
  }

  List versionsList = [];
  List versions = [
    // "AMH",
    "AMP",
    "CPDV",
    "ERV",
    "ESV",
    "ASV",
    "KJV",
    "NASB",
    "WEB",
  ];

  Object? arguments;

  @override
  void initState() {
    // TODO: implement initState
    _refresher(arguments);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    arguments = args;
    // _refresher(args);

    print(args);

    return Scaffold(
      appBar: AppBar(
        title: Text('$verseTitle $currentChapter :$currentVerse'),
      ),
      body: Center(
        child: ListView.builder(
            itemCount: versionsList.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(
                  '${versions[index]}',
                  style: TextStyle(
                      fontSize: 19,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '${versionsList[index]['text']}',
                  style: TextStyle(fontSize: 17),
                ),
              );
            }),
      ),
    );
  }
}
