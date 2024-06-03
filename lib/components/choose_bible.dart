// ignore_for_file: prefer_const_constructors

import 'package:dha_anywaa_bible/classes/font_style.dart';
import 'package:flutter/material.dart';

class ChooseBible extends StatefulWidget {
  const ChooseBible({super.key});

  @override
  State<ChooseBible> createState() => _ChooseBibleState();
}

class _ChooseBibleState extends State<ChooseBible> {
  List<Map<String, dynamic>> bibleVersons = [
    {
      'name': 'Dha anywaa',
      'abbrev': 'ANY',
      'description': 'The Bible was translated into the Anyua language so that the word of God could reach the Anyua people.'
          '\nThe translation took place in Akobo, Sudan, in 1948. It began with the New Testament.'
          '\n\nIn 1962, the translation was completed in Sudan and published by the Bible Society in America, written in Latin.'
          ' Later, in 1965, it was brought to Ethiopia and written in the Amharic script, making it accessible to the Anyua people in Ethiopia.'
          '\n\nAfter several years, the entire Bible was translated into the Anyua language.',
      'isExpanded': false,
    },
    {
      'name': 'Amharic',
      'abbrev': 'AMH',
      'description': '',
      'isExpanded': false,
    },
    {
      'name': 'Amplified Bible',
      'abbrev': 'AMP',
      'description': '',
      'isExpanded': false,
    },
    {
      'name': 'American Standard Version',
      'abbrev': 'ASV',
      'description': '',
      'isExpanded': false,
    },
    {
      'name': 'Catholic Public Domain Version',
      'abbrev': 'CPDV',
      'description': '',
      'isExpanded': false,
    },
    {
      'name': 'Easy-to-Read Version',
      'abbrev': 'ERV',
      'description': '',
      'isExpanded': false,
    },
    {
      'name': 'English Standard Version',
      'abbrev': 'ESV',
      'description': '',
      'isExpanded': false,
    },
    {
      'name': 'King James Version',
      'abbrev': 'KJV',
      'description': '',
      'isExpanded': false,
    },
    {
      'name': 'New American Standard Bible',
      'abbrev': 'NASB',
      'description': '',
      'isExpanded': false,
    },
    {
      'name': 'World English Bible',
      'abbrev': 'WEB',
      'description': '',
      'isExpanded': false,
    },
  ];

  void getLanguageVersion() async {
    String currentLanguageVersion =
        await selectedFontStyle.getLanguageVersion();
    currentLanguageVersion = currentLanguageVersion.split(' ')[0];

    setState(() {
      _currentLanguageVersion = currentLanguageVersion;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLanguageVersion();
  }

  SelectedFontStyle selectedFontStyle = SelectedFontStyle();
  String _currentLanguageVersion = '';
  String currentAbbrev = '';

  _updateVersion(value) async {
    try {
      final currentVersion = await selectedFontStyle.getBibleVersion();

      // String v = currentVersion
      var splitVersion = currentVersion.split('/');
      print(splitVersion);
      print(value);
      if (value == 'AMH') {
        print('_ is present');
        print(currentVersion);
        print(splitVersion[1]);

        for (var chapIndex = 0; chapIndex < chapAbbrev.length; chapIndex++) {
          if (splitVersion[0] == 'ANY') {
            if (chapAbbrev[chapIndex]['abbrev'] ==
                splitVersion[2].split('.')[0].toString()) {
              print('${chapAbbrev[chapIndex]['amharic']}  fff');
              selectedFontStyle
                  .setBibleVersion('${chapAbbrev[chapIndex]['amharic']}');
              print('${chapAbbrev[chapIndex]['amharic']}  fff');
            }
          } else {
            if (chapAbbrev[chapIndex]['abbrev'] == splitVersion[1].toString()) {
              print('${chapAbbrev[chapIndex]['amharic']}  fff');
              selectedFontStyle
                  .setBibleVersion('${chapAbbrev[chapIndex]['amharic']}');
              print('${chapAbbrev[chapIndex]['amharic']}  fff');
            }
          }
        }
      } else if (value == 'ANY') {
        if (currentVersion.contains('_')) {
          for (var chapIndex = 0; chapIndex < chapAbbrev.length; chapIndex++) {
            if (chapAbbrev[chapIndex]['amharic'] == currentVersion &&
                chapIndex < 39) {
              print('1 problem');
              selectedFontStyle.setBibleVersion(
                  'OT/${chapAbbrev[chapIndex]['abbrev']}/$value.json');
              print('OT/${chapAbbrev[chapIndex]['abbrev']}/$value.json jkj');
            } else if (chapAbbrev[chapIndex]['amharic'] == currentVersion &&
                chapIndex >= 39) {
              // assets\holybooks\ANY\NT\1CO.json
              print('3 probelm');
              selectedFontStyle.setBibleVersion(
                  'ANY/NT/${chapAbbrev[chapIndex]['abbrev']}.json');
              print('ANY/NT/${chapAbbrev[chapIndex]['abbrev']}.json here');
            }
          }
        } else {
          for (var chapIndex = 0; chapIndex < chapAbbrev.length; chapIndex++) {
            if (chapAbbrev[chapIndex]['abbrev'] == currentAbbrev &&
                chapIndex < 39) {
            } else if (chapAbbrev[chapIndex]['abbrev'] == splitVersion[1] &&
                chapIndex >= 39) {
              selectedFontStyle.setBibleVersion(
                  'ANY/${splitVersion[0]}/${splitVersion[1]}.json');
              print('ANY/${splitVersion[0]}/${splitVersion[1]}.json blah balh');
            }
          }

          // selectedFontStyle.setBibleVersion(
          //     '${splitVersion[0]}/${splitVersion[1]}/$value.json');
          print('${splitVersion[0]}/${splitVersion[1]}.json');
          print(currentAbbrev);
        }

        print('ghghggh');
        // print('${splitVersion[0]}/${splitVersion[1]}/$value.json');
      } else {
        print('english $splitVersion');
        print(value);

        if (currentVersion.contains('_')) {
          for (var chapIndex = 0; chapIndex < chapAbbrev.length; chapIndex++) {
            if (chapAbbrev[chapIndex]['amharic'] == currentVersion &&
                chapIndex < 39) {
              print('1 problem');
              selectedFontStyle.setBibleVersion(
                  'OT/${chapAbbrev[chapIndex]['abbrev']}/$value.json');
              print('OT/${chapAbbrev[chapIndex]['abbrev']}/$value.json jkj');
            } else if (chapAbbrev[chapIndex]['amharic'] == currentVersion &&
                chapIndex >= 39) {
              print('3 probelm');
              selectedFontStyle.setBibleVersion(
                  'NT/${chapAbbrev[chapIndex]['abbrev']}/$value.json');
              print('NT/${chapAbbrev[chapIndex]['abbrev']}/$value.json here');
            }
          }
        } else if (splitVersion[0] == 'ANY') {
          print('$splitVersion here already');
          selectedFontStyle.setBibleVersion(
              '${splitVersion[1]}/${splitVersion[2].split('.')[0]}/$value.json');
        } else {
          selectedFontStyle.setBibleVersion(
              '${splitVersion[0]}/${splitVersion[1]}/$value.json');
          print('${splitVersion[0]}/${splitVersion[1]}/$value.json');
        }

        print(' $currentVersion jdklfjdkfjdkfdj');
        print(
            '${splitVersion[1]}/${splitVersion[2].split('.')[0]}/$value.json');
        // print('${splitVersion[0]}/${splitVersion[1]}/$value.json');
      }
    } catch (e) {
      print('Error $e');
    }
  }

  List<Map<String, String>> chapAbbrev = [
    {
      'title': 'Genesis',
      'amharic': "01_ኦሪት ዘፍጥረት.json",
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
      'amharic': "03_ኦሪት ዘሌዋውያን.json",
      'anywaa': '',
      'number': '27',
      'abbrev': 'LEV'
    },
    {
      'title': 'Numbers',
      'amharic': "04_ኦሪት ዘኍልቍ.json",
      'anywaa': '',
      'number': '36',
      'abbrev': 'NUM'
    },
    {
      'title': 'Deuteronomy',
      'amharic': "05_ኦሪት ዘዳግም.json",
      'anywaa': '',
      'number': '34',
      'abbrev': 'DEU'
    },
    {
      'title': 'Joshua',
      'amharic': "06_መጽሐፈ ኢያሱ ወልደ ነዌ.json",
      'anywaa': '',
      'number': '24',
      'abbrev': 'JOS'
    },
    {
      'title': "Judges",
      'amharic': "07_መጽሐፈ መሣፍንት.json",
      'anywaa': '',
      'number': '21',
      'abbrev': 'JDG'
    },
    {
      'title': "Ruth",
      'amharic': "08_መጽሐፈ ሩት.json",
      'anywaa': '',
      'number': '4',
      'abbrev': 'RUT'
    },
    {
      'title': "1 Samuel",
      'amharic': "09_መጽሐፈ ሳሙኤል ቀዳማዊ.json",
      'anywaa': '',
      'number': '31',
      'abbrev': '1SA'
    },
    {
      'title': "2 Samuel",
      'amharic': "10_መጽሐፈ ሳሙኤል ካል.json",
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
    Brightness currentTheme = Theme.of(context).brightness;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Languages And Versions'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('    Choose your bible version'),
            ExpansionPanelList(
              // expandIconColor: _currentLanguageVersion == currentAbbrev
              //     ? Colors.amber
              //     : null,
              dividerColor: Colors.transparent,
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  setState(() {
                    bibleVersons[index]['isExpanded'] =
                        !bibleVersons[index]['isExpanded'];
                  });
                });
              },
              children: bibleVersons.map<ExpansionPanel>((item) {
                return ExpansionPanel(
                  backgroundColor: currentTheme == Brightness.dark
                      ? Color.fromARGB(255, 0, 4, 17)
                      : Colors.white,
                  headerBuilder: (BuildContext context, bool isExpanded) =>
                      ListTile(
                    leading: _currentLanguageVersion == item['abbrev']
                        ? Icon(
                            Icons.check,
                            color: Colors.amber,
                          )
                        : Icon(null),
                    title: Text(
                      '${item['abbrev']}',
                      style: TextStyle(
                          color: _currentLanguageVersion == item['abbrev']
                              ? Colors.amber
                              : null),
                    ),
                    subtitle: Text(
                      '${item['name']}',
                      style: TextStyle(
                          color: _currentLanguageVersion == item['abbrev']
                              ? Colors.amber
                              : Colors.grey),
                    ),
                    onTap: () {
                      selectedFontStyle.setLanguageVersion(
                          '${item['abbrev']} ${item['name']}');
                      setState(() {
                        currentAbbrev = item['abbrev'];
                        _updateVersion(currentAbbrev);
                        _currentLanguageVersion = item['abbrev'];
                      });

                      Navigator.pop(context);
                    },
                  ),
                  body: ListTile(
                    title: Text('${item['description']}'),
                  ),
                  isExpanded: item['isExpanded'],
                );
              }).toList(),
            ),
          ]),
        ),
      ),
    );
  }
}
