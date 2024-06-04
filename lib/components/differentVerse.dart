import 'dart:convert';

import 'package:dha_anywaa_bible/components/Book.dart';
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
  String anywaaJsonString = 'assets/holybooks/ANY/$anywaaBibleVersion';

  Future<String> _engLoadData() async {
    return await rootBundle.loadString(englishJsonString);
  }

  Future<String> _anywaaLoadData() async {
    return await rootBundle.loadString(anywaaJsonString);
  }

  Future<String> _amhLoadData() async {
    return await rootBundle.loadString(amharicJsonString);
  }

  EnglishBook? englishBook;
  AnywaaBook? anywaaBook;
  AmharicChapters? amharicBook;
  SelectedFontStyle style = SelectedFontStyle()..init();
  static String bibleVersion = '';
  static String amhBibleVersion = '';
  String verseTitle = '';
  int currentChapter = 0;
  String currentVerse = '';
  static String anywaaBibleVersion = '';

// load english bible
  Future engLoadData(args, myCurrentVersion) async {
    try {
      String engJsonString = await _engLoadData();
      final engJsonResponse = json.decode(engJsonString);
      setState(() {
        englishBook = EnglishBook.fromJson(engJsonResponse);
        print(args[0]['pageIndex']);
        int pageIndex = args[0]['pageIndex'];
        int listIndex = args[0]['listIndex'];
        String title = args[0]['title'];

        // ignore: unnecessary_null_comparison
        if (englishBook!.chapters[pageIndex].verses != null) {
          for (var verse in englishBook!.chapters[pageIndex].verses) {
            if ("${listIndex + 1}" == verse.id && verse.text != "") {
              versionsList.add({
                'text': verse.text,
                'version': myCurrentVersion,
                'chapter': pageIndex + 1,
                'verse': listIndex + 1,
                'title': title
              });

              setState(() {
                currentVerse = verse.id;
                verseTitle = args[0]['title'];
                currentChapter = args[0]['pageIndex'] + 1;
              });

              break;
            }
          }
        }
      });
    } catch (e) {
      print('english problem');
      print(e);
    }
  }

  Future amhLoadData(args) async {
    try {
      print('page index: ${args[0]['pageIndex']}');
      String amhJsonString = await _amhLoadData();
      final amhJsonResponse = json.decode(amhJsonString);
      setState(() {
        amharicBook = AmharicChapters.fromJson(amhJsonResponse);
        int pageIndex = args[0]['pageIndex'];
        int listIndex = args[0]['listIndex'];
        String currentVersion = 'AMH';
        String title = args[0]['title'];
        String amhVerse = amharicBook?.chapters[pageIndex].verses[listIndex];

        versionsList.add({
          'text': amhVerse,
          'version': currentVersion,
          'chapter': pageIndex + 1,
          'verse': listIndex + 1,
          'title': title
        });
      });
    } catch (e) {
      print('amharic problem');
      print(e);
    }
  }

  Future anywaaLoadData(args) async {
    try {
      String anyJsonString = await _anywaaLoadData();
      final anyJsonResponse = json.decode(anyJsonString);
      setState(() {
        anywaaBook = AnywaaBook.fromJson(anyJsonResponse);

        print(args[0]['pageIndex']);
        int pageIndex = args[0]['pageIndex'];
        int listIndex = args[0]['listIndex'];
        String title = args[0]['title'];

        // ignore: unnecessary_null_comparison
        if (anywaaBook!.chapters[pageIndex].verses != null) {
          for (var verse in anywaaBook!.chapters[pageIndex].verses) {
            if ("${listIndex + 1}" == verse.id) {
              versionsList.add({
                'text': verse.text,
                'version': 'ANY',
                'chapter': pageIndex + 1,
                'verse': listIndex + 1,
                'title': title
              });

              setState(() {
                currentVerse = verse.id;
                verseTitle = args[0]['title'];
                currentChapter = args[0]['pageIndex'] + 1;
              });

              break;
            }
          }
        }
      });
    } catch (e) {
      print('dha anywaa problem');
      print(e);
    }
  }

  void _refresher(args) async {
    bibleVersion = await style.getBibleVersion();
    String currentBibleVersion = bibleVersion;
    List splitVersion = bibleVersion.split('/');
    print(splitVersion);
    print('this is bible version $bibleVersion');

    for (String version in versions) {
      if (version == "AMH") {
        if (bibleVersion.contains('_')) {
          amharicJsonString = 'assets/holybooks/AM/$bibleVersion';
          amhLoadData(arguments);
        } else {
          for (var book in bookList) {
            if (splitVersion[0] == 'ANY') {
              if (book['abbrev'] == splitVersion[2].split('.')[0]) {
                print('here in amaharic');
                amhBibleVersion = book['amharic']!;
                break;
              }
            } else {
              if (book['abbrev'] == splitVersion[1]) {
                amhBibleVersion = book['amharic']!;
                break;
              }
            }
          }

          amharicJsonString = 'assets/holybooks/AM/$amhBibleVersion';

          // print('amh: $amhBibleVersion');
          amhLoadData(arguments);
        }
      } else if (version == 'ANY') {
        if (bibleVersion.contains('_')) {
          int myListIndex = int.parse(bibleVersion.split('_')[0]);
          for (var chapIndex = 0; chapIndex < bookList.length; chapIndex++) {
            if (bookList[chapIndex]['amharic'] == bibleVersion &&
                chapIndex < 39) {
              print('1 problem');
              setState(() {
                anywaaBibleVersion =
                    'OT/${bookList[myListIndex - 1]['abbrev']}.json';
              });

              anywaaLoadData(arguments);
            } else if (bookList[chapIndex]['amharic'] == bibleVersion &&
                chapIndex >= 39) {
              setState(() {
                anywaaBibleVersion =
                    'NT/${bookList[myListIndex - 1]['abbrev']}.json';
              });
              anywaaLoadData(arguments);
            }
          }
        } else {
          if (splitVersion[0] == 'ANY') {
            setState(() {
              anywaaBibleVersion = '${splitVersion[1]}/${splitVersion[2]}';
            });
            anywaaLoadData(arguments);
          } else {
            for (var chapIndex = 0; chapIndex < bookList.length; chapIndex++) {
              if (bookList[chapIndex]['abbrev'] == splitVersion[1] &&
                  chapIndex < 39) {
                setState(() {
                  anywaaBibleVersion =
                      '${splitVersion[0]}/${splitVersion[1]}.json';
                });
                anywaaLoadData(arguments);
              } else if (bookList[chapIndex]['abbrev'] == splitVersion[1] &&
                  chapIndex >= 39) {
                setState(() {
                  anywaaBibleVersion =
                      '${splitVersion[0]}/${splitVersion[1]}.json';
                });
                anywaaLoadData(arguments);
              }
            }
          }
        }
      } else {
        String currentVersion = '';
        if (bibleVersion.contains('_')) {
          int myListIndex = int.parse(bibleVersion.split('_')[0]);
          currentVersion = myListIndex <= 39
              ? 'OT/${bookList[myListIndex - 1]['abbrev']}/$version.json'
              : 'NT/${bookList[myListIndex - 1]['abbrev']}/$version.json';
          englishJsonString = 'assets/holybooks/$currentVersion';
          engLoadData(arguments, version);
        } else if (splitVersion[0] == 'ANY') {
          currentVersion =
              '${splitVersion[1]}/${splitVersion[2].split('.')[0]}/$version.json';
          setState(() {
            bibleVersion = currentVersion;
            englishJsonString = 'assets/holybooks/$currentVersion';
          });
          engLoadData(arguments, version);
        } else {
          currentVersion =
              '${splitVersion[0]}/${splitVersion[1]}/$version.json';
          setState(() {
            bibleVersion = currentVersion;
            englishJsonString = 'assets/holybooks/$currentVersion';
          });

          engLoadData(arguments, version);
        }
      }
    }
    setState(() {});
  }

  List versionsList = [];
  List versions = [
    "AMP",
    "CPDV",
    "ERV",
    "ESV",
    "ASV",
    "KJV",
    "NASB",
    "WEB",
    "AMH",
    "ANY"
  ];
  Object? arguments;
  @override
  void initState() {
    // TODO: implement initState
    _refresher(arguments);
    super.initState();
  }

  List<Map<String, String>> bookList = [
    {
      'title': 'Genesis',
      'amharic': '01_ኦሪት ዘፍጥረት.json',
      'anywaa': '',
      'number': '50',
      'abbrev': 'GEN'
    },
    {
      'title': 'Exodus',
      'amharic': '02_ኦሪት ዘጸአት.json',
      'anywaa': '',
      'number': '40',
      'abbrev': 'EXO'
    },
    {
      'title': 'Leviticus',
      'amharic': '03_ኦሪት ዘሌዋውያን.json',
      'anywaa': '',
      'number': '27',
      'abbrev': 'LEV'
    },
    {
      'title': 'Numbers',
      'amharic': '04_ኦሪት ዘኍልቍ.json',
      'anywaa': '',
      'number': '36',
      'abbrev': 'NUM'
    },
    {
      'title': 'Deuteronomy',
      'amharic': '05_ኦሪት ዘዳግም.json',
      'anywaa': '',
      'number': '34',
      'abbrev': 'DEU'
    },
    {
      'title': 'Joshua',
      'amharic': '06_መጽሐፈ ኢያሱ ወልደ ነዌ.json',
      'anywaa': '',
      'number': '24',
      'abbrev': 'JOS'
    },
    {
      'title': "Judges",
      'amharic': '07_መጽሐፈ መሣፍንት.json',
      'anywaa': '',
      'number': '21',
      'abbrev': 'JDG'
    },
    {
      'title': "Ruth",
      'amharic': '08_መጽሐፈ ሩት.json',
      'anywaa': '',
      'number': '4',
      'abbrev': 'RUT'
    },
    {
      'title': "1 Samuel",
      'amharic': '09_መጽሐፈ ሳሙኤል ቀዳማዊ.json',
      'anywaa': '',
      'number': '31',
      'abbrev': '1SA'
    },
    {
      'title': "2 Samuel",
      'amharic': '10_መጽሐፈ ሳሙኤል ካል.json',
      'anywaa': '',
      'number': '24',
      'abbrev': '2SA'
    },
    {
      'title': "1 Kings",
      'amharic': '11_መጽሐፈ ነገሥት ቀዳማዊ.json',
      'anywaa': '',
      'number': '22',
      'abbrev': '1KI'
    },
    {
      'title': "2 Kings",
      'amharic': '12_መጽሐፈ ነገሥት ካልዕ.json',
      'anywaa': '',
      'number': '25',
      'abbrev': '2KI'
    },
    {
      'title': "1 Chronicles",
      'amharic': '13_መጽሐፈ ዜና መዋዕል ቀዳማዊ.json',
      'anywaa': '',
      'number': '29',
      'abbrev': '1CH'
    },
    {
      'title': "2 Chronicles",
      'amharic': '14_መጽሐፈ ዜና መዋዕል ካልዕ.json',
      'anywaa': '',
      'number': '36',
      'abbrev': '2CH'
    },
    {
      'title': "Ezra",
      'amharic': '15_መጽሐፈ ዕዝራ.json',
      'anywaa': '',
      'number': '10',
      'abbrev': 'EZR'
    },
    {
      'title': "Nehemiah",
      'amharic': '16_መጽሐፈ ነህምያ.json',
      'anywaa': '',
      'number': '13',
      'abbrev': 'NAM'
    },
    {
      'title': "Esther",
      'amharic': '17_መጽሐፈ አስቴር.json',
      'anywaa': '',
      'number': '10',
      'abbrev': 'EST'
    },
    {
      'title': "Job",
      'amharic': '18_መጽሐፈ ኢዮብ.json',
      'anywaa': '',
      'number': '42',
      'abbrev': 'JOB'
    },
    {
      'title': "Psalms",
      'amharic': '19_መዝሙረ ዳዊት.json',
      'anywaa': '',
      'number': '150',
      'abbrev': 'PSA'
    },
    {
      'title': "Proverbs",
      'amharic': '20_መጽሐፈ ምሳሌ.json',
      'anywaa': '',
      'number': '31',
      'abbrev': 'PRO'
    },
    {
      'title': "Ecclesiastes",
      'amharic': '21_መጽሐፈ መክብብ.json',
      'anywaa': '',
      'number': '12',
      'abbrev': 'ECC'
    },
    {
      'title': "Song of Solomon",
      'amharic': '22_መኃልየ መኃልይ ዘሰሎሞን.json',
      'anywaa': '',
      'number': '8',
      'abbrev': 'SNG'
    },
    {
      'title': 'Isaiah',
      'amharic': '23_ትንቢተ ኢሳይያስ.json',
      'anywaa': '',
      'number': '66',
      'abbrev': 'ISA'
    },
    {
      'title': 'Jeremiah',
      'amharic': '24_ትንቢተ ኤርምያስ.json',
      'anywaa': '',
      'number': '52',
      'abbrev': 'JER'
    },
    {
      'title': 'Lamentations',
      'amharic': '25_ሰቆቃው ኤርምያስ.json',
      'anywaa': '',
      'number': '5',
      'abbrev': 'LAM'
    },
    {
      'title': 'Ezekiel',
      'amharic': '26_ትንቢተ ሕዝቅኤል.json',
      'anywaa': '',
      'number': '48',
      'abbrev': 'EZK'
    },
    {
      'title': 'Daniel',
      'amharic': '27_ትንቢተ ዳንኤል.json',
      'anywaa': '',
      'number': '12',
      'abbrev': 'DAN'
    },
    {
      'title': 'Hosea',
      'amharic': '28_ትንቢተ ሆሴዕ.json',
      'anywaa': '',
      'number': '14',
      'abbrev': 'HOS'
    },
    {
      'title': 'Joel',
      'amharic': '29_ትንቢተ ኢዮኤል.json',
      'anywaa': '',
      'number': '3',
      'abbrev': 'JOL'
    },
    {
      'title': 'Amos',
      'amharic': '30_ትንቢተ አሞጽ.json',
      'anywaa': '',
      'number': '9',
      'abbrev': 'AMO'
    },
    {
      'title': 'Obadiah',
      'amharic': '31_ትንቢተ አብድዩ.json',
      'anywaa': '',
      'number': '1',
      'abbrev': 'OBA'
    },
    {
      'title': 'Jonah',
      'amharic': '32_ትንቢተ ዮናስ.json',
      'anywaa': '',
      'number': '4',
      'abbrev': 'JON'
    },
    {
      'title': 'Micah',
      'amharic': '33_ትንቢተ ሚክያስ.json',
      'anywaa': '',
      'number': '7',
      'abbrev': 'MIC'
    },
    {
      'title': 'Nahum',
      'amharic': '34_ትንቢተ ናሆም.json',
      'anywaa': '',
      'number': '3',
      'abbrev': 'NAH'
    },
    {
      'title': 'Habakkuk',
      'amharic': '35_ትንቢተ ዕንባቆም.json',
      'anywaa': '',
      'number': '3',
      'abbrev': 'HAB'
    },
    {
      'title': 'Zephaniah',
      'amharic': '36_ትንቢተ ሶፎንያስ.json',
      'anywaa': '',
      'number': '3',
      'abbrev': 'ZEP'
    },
    {
      'title': 'Haggai',
      'amharic': '37_ትንቢተ ሐጌ.json',
      'anywaa': '',
      'number': '2',
      'abbrev': 'HAG'
    },
    {
      'title': 'Zechariah',
      'amharic': '38_ትንቢተ ዘካርያስ.json',
      'anywaa': '',
      'number': '14',
      'abbrev': 'ZEC'
    },
    {
      'title': 'Malachi',
      'amharic': '39_ትንቢተ ሚልክያ.json',
      'anywaa': '',
      'number': '4',
      'abbrev': 'MAL'
    },
    {
      'title': 'Matthew',
      'amharic': '40_የማቴዎስ ወንጌል.json',
      'anywaa': '',
      'number': '28',
      'abbrev': 'MAT'
    },
    {
      'title': 'Mark',
      'amharic': '41_የማርቆስ ወንጌል.json',
      'anywaa': '',
      'number': '16',
      'abbrev': 'MRK'
    },
    {
      'title': 'Luke',
      'amharic': '42_የሉቃስ ወንጌል.json',
      'anywaa': '',
      'number': '24',
      'abbrev': 'LUK'
    },
    {
      'title': 'John',
      'amharic': '43_የዮሐንስ ወንጌል.json',
      'anywaa': '',
      'number': '21',
      'abbrev': 'JHN'
    },
    {
      'title': 'Acts',
      'amharic': '44_የሐዋርያት ሥራ.json',
      'anywaa': '',
      'number': '28',
      'abbrev': 'ACT'
    },
    {
      'title': 'Romans',
      'amharic': '45_ወደ ሮሜ ሰዎች.json',
      'anywaa': '',
      'number': '16',
      'abbrev': 'ROM'
    },
    {
      'title': '1 Corinthians',
      'amharic': '46_1ኛ ወደ ቆሮንቶስ ሰዎች.json',
      'anywaa': '',
      'number': '16',
      'abbrev': '1CO'
    },
    {
      'title': '2 Corinthians',
      'amharic': '47_2ኛ ወደ ቆሮንቶስ ሰዎች.json',
      'anywaa': '',
      'number': '13',
      'abbrev': '2CO'
    },
    {
      'title': 'Galatians',
      'amharic': '48_ወደ ገላትያ ሰዎች.json',
      'anywaa': '',
      'number': '6',
      'abbrev': 'GAL'
    },
    {
      'title': 'Ephesians',
      'amharic': '49_ወደ ኤፌሶን ሰዎች.json',
      'anywaa': '',
      'number': '6',
      'abbrev': 'EPH'
    },
    {
      'title': 'Philippians',
      'amharic': '50_ወደ ፊልጵስዩስ ሰዎች.json',
      'anywaa': '',
      'number': '4',
      'abbrev': 'PHP'
    },
    {
      'title': 'Colossians',
      'amharic': '51_ወደ ቆላስይስ ሰዎች.json',
      'anywaa': '',
      'number': '4',
      'abbrev': 'COL'
    },
    {
      'title': '1 Thessalonians',
      'amharic': '52_1ኛ ወደ ተሰሎንቄ ሰዎች.json',
      'anywaa': '',
      'number': '5',
      'abbrev': '1TH'
    },
    {
      'title': '2 Thessalonians',
      'amharic': '53_2ኛ ወደ ተሰሎንቄ ሰዎች.json',
      'anywaa': '',
      'number': '3',
      'abbrev': '2TH'
    },
    {
      'title': '1 Timothy',
      'amharic': '54_1ኛ ወደ ጢሞቴዎስ.json',
      'anywaa': '',
      'number': '6',
      'abbrev': '1TI'
    },
    {
      'title': '2 Timothy',
      'amharic': '55_2ኛ ወደ ጢሞቴዎስ.json',
      'anywaa': '',
      'number': '4',
      'abbrev': '2TI'
    },
    {
      'title': 'Titus',
      'amharic': '56_ወደ ቲቶ.json',
      'anywaa': '',
      'number': '3',
      'abbrev': 'TIT'
    },
    {
      'title': 'Philemon',
      'amharic': '57_ወደ ፊልሞና.json',
      'anywaa': '',
      'number': '1',
      'abbrev': 'PHM'
    },
    {
      'title': 'Hebrews',
      'amharic': '58_ወደ ዕብራውያን.json',
      'anywaa': '',
      'number': '13',
      'abbrev': 'HEB'
    },
    {
      'title': 'James',
      'amharic': '59_የያዕቆብ መልእክት.json',
      'anywaa': '',
      'number': '5',
      'abbrev': 'JAS'
    },
    {
      'title': '1 Peter',
      'amharic': '60_1ኛ የጴጥሮስ መልእክት.json',
      'anywaa': '',
      'number': '5',
      'abbrev': '1PE'
    },
    {
      'title': '2 Peter',
      'amharic': '61_2ኛ የጴጥሮስ መልእክት.json',
      'anywaa': '',
      'number': '3',
      'abbrev': '2PE'
    },
    {
      'title': '1 John',
      'amharic': '62_1ኛ የዮሐንስ መልእክት.json',
      'anywaa': '',
      'number': '5',
      'abbrev': '1JN'
    },
    {
      'title': '2 John',
      'amharic': '63_2ኛ የዮሐንስ መልእክት.json',
      'anywaa': '',
      'number': '1',
      'abbrev': '2JN'
    },
    {
      'title': '3 John',
      'amharic': '64_3ኛ የዮሐንስ መልእክት.json',
      'anywaa': '',
      'number': '1',
      'abbrev': '3JN'
    },
    {
      'title': 'Jude',
      'amharic': '65_የይሁዳ መልእክት.json',
      'anywaa': '',
      'number': '1',
      'abbrev': 'JUD'
    },
    {
      'title': 'Revelation',
      'amharic': '66_የዮሐንስ ራእይ.json',
      'anywaa': '',
      'number': '22',
      'abbrev': 'REV'
    }
  ];

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    arguments = args;
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
                  '${versionsList[index]['version']}',
                  // ignore: prefer_const_constructors
                  style: TextStyle(
                      fontSize: 19,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '${versionsList[index]['text']}',
                  style: const TextStyle(fontSize: 17),
                ),
              );
            }),
      ),
    );
  }
}
