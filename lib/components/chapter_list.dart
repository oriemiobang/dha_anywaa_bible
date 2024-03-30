// ignore_for_file: prefer_const_constructors, prefer_final_fields

// import 'package:dha_anywaa_bible/components/numbers.dart';
import 'package:dha_anywaa_bible/classes/font_style.dart';
import 'package:flutter/material.dart';

class Chapter {
  final String title;
  bool isExpanded;
  final int number;

  //  ø     ö     ï    ë  ä

  Chapter(
      {required this.title, required this.number, required this.isExpanded});
}

class ChapterList extends StatefulWidget {
  @override
  _ChapterListState createState() => _ChapterListState();
}

class _ChapterListState extends State<ChapterList> {
  List<Map<String, String>> oldTestList = [
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
  ];

  List<Map<String, String>> newTestList = [
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

  int currentOpenedPanelIndex = -1;

  SelectedFontStyle style = SelectedFontStyle();
  String bibleVersion = '';
  int chapter = 0;
  Brightness currentTheme = Brightness.dark;
  SelectedFontStyle selectedFontStyle = SelectedFontStyle()..init();

  List<Map<String, String>> _foundBook = [];
  List<Map<String, String>> _foundOldBook = [];

  @override
  void initState() {
    // TODO: implement initState
    _foundBook = newTestList;
    _foundOldBook = oldTestList;
    getLanguageVersion();
    super.initState();
  }

  String version = '';
  void getLanguageVersion() async {
    final languageVersion = await style.getLanguageVersion();
    String currentVersion = languageVersion.split(' ')[0];

    setState(() {
      version = currentVersion;
    });
  }

  void _runFilter(String enteredKeyword) {
    List<Map<String, String>> result = [];
    List<Map<String, String>> oldTestResult = [];
    if (enteredKeyword.isEmpty) {
      result = newTestList;
      oldTestResult = oldTestList;
      print('no change');
    } else {
      print('change');
      oldTestResult = oldTestList
          .where((book) => book['title']!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      result = newTestList
          .where((book) => book['title']!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundBook = result;
      _foundOldBook = oldTestResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    currentTheme = Theme.of(context).brightness;
    return DefaultTabController(
      animationDuration: Duration.zero,
      initialIndex: 0,
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            // leading: IconButton(

            //     onPressed: () {
            //       setState(() {
            //         Navigator.pop(context);
            //       });
            //     },
            //     icon: Icon(
            //       Icons.arrow_back_rounded,
            //       color: Colors.white,
            //     )),
            toolbarHeight: 100,
            forceMaterialTransparency: true,
            title: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            Navigator.pop(context);
                          });
                        },
                        icon: Icon(
                          Icons.arrow_back_rounded,
                        )),
                    Text('weeli',
                        style: TextStyle(
                          fontSize: 19,
                        )),
                  ],
                ),
                Row(
                  children: [
                    Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(155, 75, 75, 75),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                topLeft: Radius.circular(20))),
                        child: Center(
                          child: Icon(
                            Icons.search,
                            size: 30,
                          ),
                        )),
                    Expanded(
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        child: TextField(
                          onChanged: (value) => _runFilter(value),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20))),
                            // labelText: 'Search',
                            filled: true,
                            // enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            fillColor: Color.fromARGB(155, 75, 75, 75),
                            label: Text(
                              '',
                              style: TextStyle(
                                  // color: Color.fromARGB(217, 193, 190, 190)
                                  ),
                            ),
                            // icon: Container(
                            //     height: 50,
                            //     width: 30,
                            //     decoration: BoxDecoration(
                            //         color: Color.fromARGB(155, 75, 75, 75),
                            //         borderRadius: BorderRadius.only(
                            //             bottomLeft: Radius.circular(20),
                            //             topLeft: Radius.circular(20))),
                            //     child: Icon(Icons.search))
                            // icon: Icon(Icons.search),
                            // label: Icon(Icons.search)
                            // icon: Icon(Icons.search)
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            bottom: TabBar(
                labelColor: Colors.amber,
                indicatorColor: Colors.amber,
                tabs: <Widget>[
                  Tab(
                    height: 80,
                    child: ListTile(
                      title: Text(
                        'Old Testement',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      subtitle: version == 'AMH'
                          ? Text('ብሉይ ኪዳን', style: TextStyle(fontSize: 15))
                          : Text(''),
                    ),
                  ),
                  Tab(
                    height: 80,
                    child: ListTile(
                      title: Text(
                        'New Testement',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17.7),
                      ),
                      subtitle: version == 'AMH'
                          ? Text('አዲስ ኪዳን', style: TextStyle(fontSize: 15))
                          : Text(''),
                    ),
                  ),
                ]),
          ),
          body: TabBarView(children: <Widget>[
            oldTestement(),
            newTestement(),
          ])),
    );
  }

  Widget oldTestement() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: _foundOldBook.length,
        itemBuilder: (context, listviewindex) {
          return ListTile(
            key: ValueKey(_foundOldBook[listviewindex]['title']),
            trailing: version == 'AMH'
                ? Text(
                    '${_foundOldBook[listviewindex]['amharic']!.split('_')[1].split('.')[0]}',
                    style: TextStyle(fontSize: 16),
                  )
                : Text(''),
            title: Text(
              '${_foundOldBook[listviewindex]['title']}',
              style: TextStyle(fontSize: 19.5),
            ),
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Scaffold(
                      appBar: AppBar(
                        title: Text(
                          version == 'AMH'
                              ? '${_foundOldBook[listviewindex]['title']} | ${_foundOldBook[listviewindex]['amharic']?.split('_')[1].split('.')[0]}'
                              : '${_foundOldBook[listviewindex]['title']} ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      body: Padding(
                        padding: const EdgeInsets.only(
                            top: 20, left: 10, right: 10, bottom: 40),
                        child: GridView.count(
                          physics: ScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          shrinkWrap: true,
                          crossAxisCount: 6,
                          children: List.generate(
                              int.parse(
                                  '${_foundOldBook[listviewindex]['number']}'),
                              (index) {
                            return Card(
                              child: Center(
                                child: TextButton(
                                  child: Text('${index + 1}',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: currentTheme == Brightness.dark
                                              ? Color.fromARGB(
                                                  255, 250, 219, 124)
                                              : Color.fromARGB(255, 0, 4, 17))),
                                  onPressed: () async {
                                    getLanguageVersion();
                                    bibleVersion = version != 'AMH'
                                        ? 'OT/${_foundOldBook[listviewindex]['abbrev']}/$version.json'
                                        : '${_foundOldBook[listviewindex]['amharic']}';

                                    style.setBibleVersion(bibleVersion);
                                    setState(() {
                                      chapter = index;
                                    });
                                    selectedFontStyle.setPage(chapter);
                                    Navigator.pop(context);
                                    Navigator.pop(context, chapter);
                                  },
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    );
                  });
            },
          );
        });
  }

  Widget newTestement() {
    return ListView.builder(
        shrinkWrap: true,
        // key: ValueKey(_foundBook[index]['title']),
        itemCount: _foundBook.length,
        itemBuilder: (context, listviewindex) {
          return ListTile(
            key: ValueKey(_foundBook[listviewindex]['title']),
            title: version == 'AMH'
                ? Text(
                    '${_foundBook[listviewindex]['title']}',
                    style: TextStyle(fontSize: 19.5),
                  )
                : Text(
                    '${_foundBook[listviewindex]['title']}',
                    style: TextStyle(fontSize: 19.5),
                  ),
            trailing: version == 'AMH'
                ? Text(
                    '${_foundBook[listviewindex]['amharic']!.split('_')[1].split('.')[0]}',
                    style: TextStyle(fontSize: 16),
                  )
                : Text(''),
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Scaffold(
                      appBar: AppBar(
                        // centerTitle: true,
                        title: Text(
                          '${_foundBook[listviewindex]['title']} | ${_foundBook[listviewindex]['amharic']?.split('_')[1].split('.')[0]}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      body: Padding(
                        padding: const EdgeInsets.only(
                            top: 20, left: 10, right: 10, bottom: 40),
                        child: GridView.count(
                          physics: ScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          shrinkWrap: true,
                          crossAxisCount: 6,
                          children: List.generate(
                              int.parse(
                                  '${_foundBook[listviewindex]['number']}'),
                              (index) {
                            return Card(
                              // color: Color.fromARGB(136, 67, 65, 58),
                              child: Center(
                                child: TextButton(
                                  child: Text('${index + 1}',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: currentTheme ==
                                                  Brightness.light
                                              ? Color.fromARGB(255, 0, 4, 17)
                                              : Color.fromARGB(
                                                  255, 250, 219, 124))),
                                  onPressed: () async {
                                    getLanguageVersion();
                                    bibleVersion =
                                        // = listviewindex > 38
                                        // ?
                                        version != 'AMH'
                                            ? 'NT/${_foundBook[listviewindex]['abbrev']}/$version.json'
                                            : '${_foundBook[listviewindex]['amharic']}';
                                    // : version != 'AMH'
                                    // ? 'OT/${_foundBook[listviewindex]['abbrev']}/$version.json'
                                    // : '${_foundBook[listviewindex]['amharic']}';
                                    style.setBibleVersion(bibleVersion);
                                    setState(() {
                                      chapter = index;
                                    });
                                    selectedFontStyle.setPage(chapter);
                                    Navigator.pop(context);
                                    Navigator.pop(context, chapter);
                                  },
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    );
                  });
            },
          );
        });
  }
}
