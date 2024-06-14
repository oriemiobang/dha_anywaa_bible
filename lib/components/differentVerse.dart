import 'dart:convert';

import 'package:dha_anywaa_bible/components/Book.dart';
import 'package:dha_anywaa_bible/classes/font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DifferentVerse extends StatefulWidget {
  final int? pageIndex;
  final int? listIndex;
  final String? title;
  final String? version;

  DifferentVerse(
      {super.key, this.pageIndex, this.listIndex, this.title, this.version});

  @override
  State<DifferentVerse> createState() => _DifferentVerseState();
}

class _DifferentVerseState extends State<DifferentVerse> {
  bool _isLoading = true;

  Future<String> _engLoadData(String bibleVersion) async {
    String englishJsonString = 'assets/holybooks/$bibleVersion';
    return await rootBundle.loadString(englishJsonString);
  }

  Future<String> _anywaaLoadData(String anywaaBibleVersion) async {
    String anywaaJsonString = 'assets/holybooks/ANY/$anywaaBibleVersion';
    return await rootBundle.loadString(anywaaJsonString);
  }

  Future<String> _amhLoadData(String amhBibleVersion) async {
    String amharicJsonString = 'assets/holybooks/AM/$amhBibleVersion';
    return await rootBundle.loadString(amharicJsonString);
  }

  SelectedFontStyle style = SelectedFontStyle()..init();
  static String bibleVersion = '';
  static String amhBibleVersion = '';
  static String anywaaBibleVersion = '';

  Future<void> engLoadData(
      String myCurrentVersion, String currentVersion) async {
    try {
      String engJsonString = await _engLoadData(currentVersion);
      final engJsonResponse = json.decode(engJsonString);
      EnglishBook englishBook = EnglishBook.fromJson(engJsonResponse);

      for (var verse in englishBook.chapters[pageIndex].verses) {
        if ("$listIndex" == verse.id && verse.text != "") {
          versionsList.add({
            'text': verse.text,
            'version': myCurrentVersion,
          });
          break;
        }
      }
    } catch (e) {
      print('english problem');
      print(e);
    }
  }

  Future<void> amhLoadData(String amhBibleVersion) async {
    try {
      String amhJsonString = await _amhLoadData(amhBibleVersion);
      final amhJsonResponse = json.decode(amhJsonString);
      AmharicChapters amharicBook = AmharicChapters.fromJson(amhJsonResponse);
      String amhVerse = amharicBook.chapters[pageIndex].verses[listIndex - 1];

      versionsList.add({
        'text': amhVerse,
        'version': 'AMH',
      });
    } catch (e) {
      print('amharic problem');
      print(e);
    }
  }

  Future<void> anywaaLoadData(String anywaaBibleVersion) async {
    try {
      String anyJsonString = await _anywaaLoadData(anywaaBibleVersion);
      final anyJsonResponse = json.decode(anyJsonString);
      AnywaaBook anywaaBook = AnywaaBook.fromJson(anyJsonResponse);
      String anyVerse =
          anywaaBook.chapters[pageIndex].verses[listIndex - 1].text;
      versionsList.add({
        'text': anyVerse,
        'version': 'ANY',
      });
    } catch (e) {
      print('dha anywaa problem');
      print(e);
    }
  }

  Future<void> _refresher() async {
    print(listIndex);
    bibleVersion = await style.getBibleVersion();
    List splitVersion = bibleVersion.split('/');

    for (String version in versions) {
      if (version == "AMH") {
        if (bibleVersion.contains('_')) {
          await amhLoadData(bibleVersion);
        } else {
          for (var book in bookList) {
            if (splitVersion[0] == 'ANY') {
              if (book['abbrev'] == splitVersion[2].split('.')[0]) {
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
          await amhLoadData(amhBibleVersion);
        }
      } else if (version == 'ANY') {
        if (bibleVersion.contains('_')) {
          int myListIndex = int.parse(bibleVersion.split('_')[0]);
          if (myListIndex <= 39) {
            anywaaBibleVersion =
                'OT/${bookList[myListIndex - 1]['abbrev']}.json';
          } else if (myListIndex > 39) {
            anywaaBibleVersion =
                'NT/${bookList[myListIndex - 1]['abbrev']}.json';
          }
          await anywaaLoadData(anywaaBibleVersion);
        } else {
          if (splitVersion[0] == 'ANY') {
            anywaaBibleVersion = '${splitVersion[1]}/${splitVersion[2]}';
          } else {
            anywaaBibleVersion = '${splitVersion[0]}/${splitVersion[1]}.json';
          }
          await anywaaLoadData(anywaaBibleVersion);
        }
      } else {
        String currentVersion = '';
        if (bibleVersion.contains('_')) {
          int myListIndex = int.parse(bibleVersion.split('_')[0]);
          currentVersion = myListIndex <= 39
              ? 'OT/${bookList[myListIndex - 1]['abbrev']}/$version.json'
              : 'NT/${bookList[myListIndex - 1]['abbrev']}/$version.json';
          await engLoadData(version, currentVersion);
        } else if (splitVersion[0] == 'ANY') {
          currentVersion =
              '${splitVersion[1]}/${splitVersion[2].split('.')[0]}/$version.json';
          await engLoadData(version, currentVersion);
        } else {
          currentVersion =
              '${splitVersion[0]}/${splitVersion[1]}/$version.json';
          await engLoadData(version, currentVersion);
        }
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  List versionsList = [];
  List versions = [
    "ANY",
    "AMH",
    "AMP",
    "CPDV",
    "ERV",
    "ESV",
    "ASV",
    "KJV",
    "NASB",
    "WEB",
  ];
  late int pageIndex;
  late int listIndex;
  late String title;
  late String myCurrentVersion;

  @override
  void initState() {
    pageIndex = widget.pageIndex!;
    listIndex = widget.listIndex!;
    title = widget.title!;
    myCurrentVersion = widget.version!;
    super.initState();
    _refresher();
  }

  List<Map<String, String>> bookList = [
    {
      'title': 'Genesis',
      'amharic': '01_ኦሪት ዘፍጥረት.json',
      'number': '50',
      'abbrev': 'GEN'
    },
    {
      'title': 'Exodus',
      'amharic': '02_ኦሪት ዘጸአት.json',
      'number': '40',
      'abbrev': 'EXO'
    },
    {
      'title': 'Leviticus',
      'amharic': '03_ኦሪት ዘሌዋውያን.json',
      'number': '27',
      'abbrev': 'LEV'
    },
    {
      'title': 'Numbers',
      'amharic': '04_ኦሪት ዘኍልቍ.json',
      'number': '36',
      'abbrev': 'NUM'
    },
    {
      'title': 'Deuteronomy',
      'amharic': '05_ኦሪት ዘዳግም.json',
      'number': '34',
      'abbrev': 'DEU'
    },
    {
      'title': 'Joshua',
      'amharic': '06_መጽሐፈ ኢያሱ ወልደ ነዌ.json',
      'number': '24',
      'abbrev': 'JOS'
    },
    {
      'title': "Judges",
      'amharic': '07_መጽሐፈ መሣፍንት.json',
      'number': '21',
      'abbrev': 'JDG'
    },
    {
      'title': "Ruth",
      'amharic': '08_መጽሐፈ ሩት.json',
      'number': '4',
      'abbrev': 'RUT'
    },
    {
      'title': "1 Samuel",
      'amharic': '09_መጽሐፈ ሳሙኤል ቀዳማዊ.json',
      'number': '31',
      'abbrev': '1SA'
    },
    {
      'title': "2 Samuel",
      'amharic': '10_መጽሐፈ ሳሙኤል ካል.json',
      'number': '24',
      'abbrev': '2SA'
    },
    {
      'title': "1 Kings",
      'amharic': '11_መጽሐፈ ነገሥት ቀዳማዊ.json',
      'number': '22',
      'abbrev': '1KI'
    },
    {
      'title': "2 Kings",
      'amharic': '12_መጽሐፈ ነገሥት ካልዕ.json',
      'number': '25',
      'abbrev': '2KI'
    },
    {
      'title': "1 Chronicles",
      'amharic': '13_መጽሐፈ ዜና መዋዕል ቀዳማዊ.json',
      'number': '29',
      'abbrev': '1CH'
    },
    {
      'title': "2 Chronicles",
      'amharic': '14_መጽሐፈ ዜና መዋዕል ካልዕ.json',
      'number': '36',
      'abbrev': '2CH'
    },
    {
      'title': "Ezra",
      'amharic': '15_መጽሐፈ ዕዝራ.json',
      'number': '10',
      'abbrev': 'EZR'
    },
    {
      'title': "Nehemiah",
      'amharic': '16_መጽሐፈ ነህምያ.json',
      'number': '13',
      'abbrev': 'NEH'
    },
    {
      'title': "Esther",
      'amharic': '17_መጽሐፈ አስቴር.json',
      'number': '10',
      'abbrev': 'EST'
    },
    {
      'title': "Job",
      'amharic': '18_መጽሐፈ ኢዮብ.json',
      'number': '42',
      'abbrev': 'JOB'
    },
    {
      'title': "Psalms",
      'amharic': '19_መዝሙረ ዳዊት.json',
      'number': '150',
      'abbrev': 'PSA'
    },
    {
      'title': "Proverbs",
      'amharic': '20_መጽሐፈ ምሳሌ.json',
      'number': '31',
      'abbrev': 'PRO'
    },
    {
      'title': "Ecclesiastes",
      'amharic': '21_መጽሐፈ መክብብ.json',
      'number': '12',
      'abbrev': 'ECC'
    },
    {
      'title': "Song of Solomon",
      'amharic': '22_መኃልየ መኃልይ ዘሰሎሞን.json',
      'number': '8',
      'abbrev': 'SNG'
    },
    {
      'title': 'Isaiah',
      'amharic': '23_ትንቢተ ኢሳይያስ.json',
      'number': '66',
      'abbrev': 'ISA'
    },
    {
      'title': 'Jeremiah',
      'amharic': '24_ትንቢተ ኤርምያስ.json',
      'number': '52',
      'abbrev': 'JER'
    },
    {
      'title': 'Lamentations',
      'amharic': '25_ሰቆቃው ኤርምያስ.json',
      'number': '5',
      'abbrev': 'LAM'
    },
    {
      'title': 'Ezekiel',
      'amharic': '26_ትንቢተ ሕዝቅኤል.json',
      'number': '48',
      'abbrev': 'EZK'
    },
    {
      'title': 'Daniel',
      'amharic': '27_ትንቢተ ዳንኤል.json',
      'number': '12',
      'abbrev': 'DAN'
    },
    {
      'title': 'Hosea',
      'amharic': '28_ትንቢተ ሆሴዕ.json',
      'number': '14',
      'abbrev': 'HOS'
    },
    {
      'title': 'Joel',
      'amharic': '29_ትንቢተ ኢዮኤል.json',
      'number': '3',
      'abbrev': 'JOL'
    },
    {
      'title': 'Amos',
      'amharic': '30_ትንቢተ አሞጽ.json',
      'number': '9',
      'abbrev': 'AMO'
    },
    {
      'title': 'Obadiah',
      'amharic': '31_ትንቢተ አብድዩ.json',
      'number': '1',
      'abbrev': 'OBA'
    },
    {
      'title': 'Jonah',
      'amharic': '32_ትንቢተ ዮናስ.json',
      'number': '4',
      'abbrev': 'JON'
    },
    {
      'title': 'Micah',
      'amharic': '33_ትንቢተ ሚክያስ.json',
      'number': '7',
      'abbrev': 'MIC'
    },
    {
      'title': 'Nahum',
      'amharic': '34_ትንቢተ ናሆም.json',
      'number': '3',
      'abbrev': 'NAH'
    },
    {
      'title': 'Habakkuk',
      'amharic': '35_ትንቢተ ዕንባቆም.json',
      'number': '3',
      'abbrev': 'HAB'
    },
    {
      'title': 'Zephaniah',
      'amharic': '36_ትንቢተ ሶፎንያስ.json',
      'number': '3',
      'abbrev': 'ZEP'
    },
    {
      'title': 'Haggai',
      'amharic': '37_ትንቢተ ሐጌ.json',
      'number': '2',
      'abbrev': 'HAG'
    },
    {
      'title': 'Zechariah',
      'amharic': '38_ትንቢተ ዘካርያስ.json',
      'number': '14',
      'abbrev': 'ZEC'
    },
    {
      'title': 'Malachi',
      'amharic': '39_ትንቢተ ሚልክያ.json',
      'number': '4',
      'abbrev': 'MAL'
    },
    {
      'title': 'Matthew',
      'amharic': '40_የማቴዎስ ወንጌል.json',
      'number': '28',
      'abbrev': 'MAT'
    },
    {
      'title': 'Mark',
      'amharic': '41_የማርቆስ ወንጌል.json',
      'number': '16',
      'abbrev': 'MRK'
    },
    {
      'title': 'Luke',
      'amharic': '42_የሉቃስ ወንጌል.json',
      'number': '24',
      'abbrev': 'LUK'
    },
    {
      'title': 'John',
      'amharic': '43_የዮሐንስ ወንጌል.json',
      'number': '21',
      'abbrev': 'JHN'
    },
    {
      'title': 'Acts',
      'amharic': '44_የሐዋርያት ሥራ.json',
      'number': '28',
      'abbrev': 'ACT'
    },
    {
      'title': 'Romans',
      'amharic': '45_ወደ ሮሜ ሰዎች.json',
      'number': '16',
      'abbrev': 'ROM'
    },
    {
      'title': '1 Corinthians',
      'amharic': '46_1ኛ ወደ ቆሮንቶስ ሰዎች.json',
      'number': '16',
      'abbrev': '1CO'
    },
    {
      'title': '2 Corinthians',
      'amharic': '47_2ኛ ወደ ቆሮንቶስ ሰዎች.json',
      'number': '13',
      'abbrev': '2CO'
    },
    {
      'title': 'Galatians',
      'amharic': '48_ወደ ገላትያ ሰዎች.json',
      'number': '6',
      'abbrev': 'GAL'
    },
    {
      'title': 'Ephesians',
      'amharic': '49_ወደ ኤፌሶን ሰዎች.json',
      'number': '6',
      'abbrev': 'EPH'
    },
    {
      'title': 'Philippians',
      'amharic': '50_ወደ ፊልጵስዩስ ሰዎች.json',
      'number': '4',
      'abbrev': 'PHP'
    },
    {
      'title': 'Colossians',
      'amharic': '51_ወደ ቆላስይስ ሰዎች.json',
      'number': '4',
      'abbrev': 'COL'
    },
    {
      'title': '1 Thessalonians',
      'amharic': '52_1ኛ ወደ ተሰሎንቄ ሰዎች.json',
      'number': '5',
      'abbrev': '1TH'
    },
    {
      'title': '2 Thessalonians',
      'amharic': '53_2ኛ ወደ ተሰሎንቄ ሰዎች.json',
      'number': '3',
      'abbrev': '2TH'
    },
    {
      'title': '1 Timothy',
      'amharic': '54_1ኛ ወደ ጢሞቴዎስ.json',
      'number': '6',
      'abbrev': '1TI'
    },
    {
      'title': '2 Timothy',
      'amharic': '55_2ኛ ወደ ጢሞቴዎስ.json',
      'number': '4',
      'abbrev': '2TI'
    },
    {
      'title': 'Titus',
      'amharic': '56_ወደ ቲቶ.json',
      'number': '3',
      'abbrev': 'TIT'
    },
    {
      'title': 'Philemon',
      'amharic': '57_ወደ ፊልሞና.json',
      'number': '1',
      'abbrev': 'PHM'
    },
    {
      'title': 'Hebrews',
      'amharic': '58_ወደ ዕብራውያን.json',
      'number': '13',
      'abbrev': 'HEB'
    },
    {
      'title': 'James',
      'amharic': '59_የያዕቆብ መልእክት.json',
      'number': '5',
      'abbrev': 'JAS'
    },
    {
      'title': '1 Peter',
      'amharic': '60_1ኛ የጴጥሮስ መልእክት.json',
      'number': '5',
      'abbrev': '1PE'
    },
    {
      'title': '2 Peter',
      'amharic': '61_2ኛ የጴጥሮስ መልእክት.json',
      'number': '3',
      'abbrev': '2PE'
    },
    {
      'title': '1 John',
      'amharic': '62_1ኛ የዮሐንስ መልእክት.json',
      'number': '5',
      'abbrev': '1JN'
    },
    {
      'title': '2 John',
      'amharic': '63_2ኛ የዮሐንስ መልእክት.json',
      'number': '1',
      'abbrev': '2JN'
    },
    {
      'title': '3 John',
      'amharic': '64_3ኛ የዮሐንስ መልእክት.json',
      'number': '1',
      'abbrev': '3JN'
    },
    {
      'title': 'Jude',
      'amharic': '65_የይሁዳ መልእክት.json',
      'number': '1',
      'abbrev': 'JUD'
    },
    {
      'title': 'Revelation',
      'amharic': '66_የዮሐንስ ራእይ.json',
      'number': '22',
      'abbrev': 'REV'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(myCurrentVersion == 'ANY'
            ? '$title : $listIndex'
            : '$title ${pageIndex + 1} : $listIndex'),
      ),
      body: _isLoading
          ? Center(
              child: SpinKitCircle(
                color: Colors.blue,
                size: 50.0,
              ),
            )
          : ListView.builder(
              itemCount: versionsList.length,
              itemBuilder: (context, index) {
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
              },
            ),
    );
  }
}
