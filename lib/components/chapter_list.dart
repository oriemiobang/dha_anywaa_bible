import 'package:dha_anywaa_bible/classes/font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Chapter {
  final String title;
  bool isExpanded;
  final int number;

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
      'anywaa': 'Wïlöölö',
      'number': '50',
      'abbrev': 'GEN'
    },
    {
      'title': 'Exodus',
      'amharic': '02_ኦሪት ዘጸአት.json',
      'anywaa': 'Bwøth Wøk',
      'number': '40',
      'abbrev': 'EXO'
    },
    {
      'title': 'Leviticus',
      'amharic': '03_ኦሪት ዘሌዋውያን.json',
      'anywaa': 'Ciik Kiper Dïlämme',
      'number': '27',
      'abbrev': 'LEV'
    },
    {
      'title': 'Numbers',
      'amharic': '04_ኦሪት ዘኍልቍ.json',
      'anywaa': 'Kwään Jiy',
      'number': '36',
      'abbrev': 'NUM'
    },
    {
      'title': 'Deuteronomy',
      'amharic': '05_ኦሪት ዘዳግም.json',
      'anywaa': 'Tiet Ciik',
      'number': '34',
      'abbrev': 'DEU'
    },
    {
      'title': 'Joshua',
      'amharic': '06_መጽሐፈ ኢያሱ ወልደ ነዌ.json',
      'anywaa': 'Jøcua',
      'number': '24',
      'abbrev': 'JOS'
    },
    {
      'title': "Judges",
      'amharic': '07_መጽሐፈ መሣፍንት.json',
      'anywaa': 'Pïëmme',
      'number': '21',
      'abbrev': 'JDG'
    },
    {
      'title': "Ruth",
      'amharic': '08_መጽሐፈ ሩት.json',
      'anywaa': 'Ruuth',
      'number': '4',
      'abbrev': 'RUT'
    },
    {
      'title': "1 Samuel",
      'amharic': '09_መጽሐፈ ሳሙኤል ቀዳማዊ.json',
      'anywaa': '1 Camiel',
      'number': '31',
      'abbrev': '1SA'
    },
    {
      'title': "2 Samuel",
      'amharic': '10_መጽሐፈ ሳሙኤል ካል.json',
      'anywaa': '2 Camiel',
      'number': '24',
      'abbrev': '2SA'
    },
    {
      'title': "1 Kings",
      'amharic': '11_መጽሐፈ ነገሥት ቀዳማዊ.json',
      'anywaa': '1 Nyeye',
      'number': '22',
      'abbrev': '1KI'
    },
    {
      'title': "2 Kings",
      'amharic': '12_መጽሐፈ ነገሥት ካልዕ.json',
      'anywaa': '2 Nyeye',
      'number': '25',
      'abbrev': '2KI'
    },
    {
      'title': "1 Chronicles",
      'amharic': '13_መጽሐፈ ዜና መዋዕል ቀዳማዊ.json',
      'anywaa': '1 Luup Nyeye',
      'number': '29',
      'abbrev': '1CH'
    },
    {
      'title': "2 Chronicles",
      'amharic': '14_መጽሐፈ ዜና መዋዕል ካልዕ.json',
      'anywaa': '2 Luup Nyeye',
      'number': '36',
      'abbrev': '2CH'
    },
    {
      'title': "Ezra",
      'amharic': '15_መጽሐፈ ዕዝራ.json',
      'anywaa': 'Edhera',
      'number': '10',
      'abbrev': 'EZR'
    },
    {
      'title': "Nehemiah",
      'amharic': '16_መጽሐፈ ነህምያ.json',
      'anywaa': 'Neemiya',
      'number': '13',
      'abbrev': 'NEH'
    },
    {
      'title': "Esther",
      'amharic': '17_መጽሐፈ አስቴር.json',
      'anywaa': 'Acther',
      'number': '10',
      'abbrev': 'EST'
    },
    {
      'title': "Job",
      'amharic': '18_መጽሐፈ ኢዮብ.json',
      'anywaa': 'Jööp',
      'number': '42',
      'abbrev': 'JOB'
    },
    {
      'title': "Psalms",
      'amharic': '19_መዝሙረ ዳዊት.json',
      'anywaa': 'Dut Pwøc',
      'number': '150',
      'abbrev': 'PSA'
    },
    {
      'title': "Proverbs",
      'amharic': '20_መጽሐፈ ምሳሌ.json',
      'anywaa': 'Pwöc Leec Wïc',
      'number': '31',
      'abbrev': 'PRO'
    },
    {
      'title': "Ecclesiastes",
      'amharic': '21_መጽሐፈ መክብብ.json',
      'anywaa': 'Luup Dïpööy',
      'number': '12',
      'abbrev': 'ECC'
    },
    {
      'title': "Song of Solomon",
      'amharic': '22_መኃልየ መኃልይ ዘሰሎሞን.json',
      'anywaa': 'Obeec Dudi',
      'number': '8',
      'abbrev': 'SNG'
    },
    {
      'title': 'Isaiah',
      'amharic': '23_ትንቢተ ኢሳይያስ.json',
      'anywaa': 'Aydheea',
      'number': '66',
      'abbrev': 'ISA'
    },
    {
      'title': 'Jeremiah',
      'amharic': '24_ትንቢተ ኤርምያስ.json',
      'anywaa': 'Jeremaya',
      'number': '52',
      'abbrev': 'JER'
    },
    {
      'title': 'Lamentations',
      'amharic': '25_ሰቆቃው ኤርምያስ.json',
      'anywaa': 'Wëël Kïmmö',
      'number': '5',
      'abbrev': 'LAM'
    },
    {
      'title': 'Ezekiel',
      'amharic': '26_ትንቢተ ሕዝቅኤል.json',
      'anywaa': 'Edhikiel',
      'number': '48',
      'abbrev': 'EZK'
    },
    {
      'title': 'Daniel',
      'amharic': '27_ትንቢተ ዳንኤል.json',
      'anywaa': 'Daniel',
      'number': '12',
      'abbrev': 'DAN'
    },
    {
      'title': 'Hosea',
      'amharic': '28_ትንቢተ ሆሴዕ.json',
      'anywaa': 'Odheea',
      'number': '14',
      'abbrev': 'HOS'
    },
    {
      'title': 'Joel',
      'amharic': '29_ትንቢተ ኢዮኤል.json',
      'anywaa': 'Jool',
      'number': '3',
      'abbrev': 'JOL'
    },
    {
      'title': 'Amos',
      'amharic': '30_ትንቢተ አሞጽ.json',
      'anywaa': 'Amøc',
      'number': '9',
      'abbrev': 'AMO'
    },
    {
      'title': 'Obadiah',
      'amharic': '31_ትንቢተ አብድዩ.json',
      'anywaa': 'Obadiya',
      'number': '1',
      'abbrev': 'OBA'
    },
    {
      'title': 'Jonah',
      'amharic': '32_ትንቢተ ዮናስ.json',
      'anywaa': 'Joona',
      'number': '4',
      'abbrev': 'JON'
    },
    {
      'title': 'Micah',
      'amharic': '33_ትንቢተ ሚክያስ.json',
      'anywaa': 'Mikiya',
      'number': '7',
      'abbrev': 'MIC'
    },
    {
      'title': 'Nahum',
      'amharic': '34_ትንቢተ ናሆም.json',
      'anywaa': 'Neeyam',
      'number': '3',
      'abbrev': 'NAH'
    },
    {
      'title': 'Habakkuk',
      'amharic': '35_ትንቢተ ዕንባቆም.json',
      'anywaa': 'Abakuk',
      'number': '3',
      'abbrev': 'HAB'
    },
    {
      'title': 'Zephaniah',
      'amharic': '36_ትንቢተ ሶፎንያስ.json',
      'anywaa': 'Jepaniya',
      'number': '3',
      'abbrev': 'ZEP'
    },
    {
      'title': 'Haggai',
      'amharic': '37_ትንቢተ ሐጌ.json',
      'anywaa': 'Agëë',
      'number': '2',
      'abbrev': 'HAG'
    },
    {
      'title': 'Zechariah',
      'amharic': '38_ትንቢተ ዘካርያስ.json',
      'anywaa': 'Dhekaraya',
      'number': '14',
      'abbrev': 'ZEC'
    },
    {
      'title': 'Malachi',
      'amharic': '39_ትንቢተ ሚልክያ.json',
      'anywaa': 'Milkiya',
      'number': '4',
      'abbrev': 'MAL'
    },
  ];

  List<Map<String, String>> newTestList = [
    {
      'title': 'Matthew',
      'anyTitle': 'Mathiew',
      'amharic': '40_የማቴዎስ ወንጌል.json',
      'anywaa': 'MAT',
      'number': '28',
      'abbrev': 'MAT'
    },
    {
      'title': 'Mark',
      'anyTitle': 'Maak',
      'amharic': '41_የማርቆስ ወንጌል.json',
      'anywaa': 'MRK',
      'number': '16',
      'abbrev': 'MRK'
    },
    {
      'title': 'Luke',
      'anyTitle': 'Luk',
      'amharic': '42_የሉቃስ ወንጌል.json',
      'anywaa': 'LUK',
      'number': '24',
      'abbrev': 'LUK'
    },
    {
      'title': 'John',
      'anyTitle': 'Jøøn',
      'amharic': '43_የዮሐንስ ወንጌል.json',
      'anywaa': 'JHN',
      'number': '21',
      'abbrev': 'JHN'
    },
    {
      'title': 'Acts',
      'anyTitle': 'Moa Tïïc Nyïïatwieli',
      'amharic': '44_የሐዋርያት ሥራ.json',
      'anywaa': 'ACT',
      'number': '28',
      'abbrev': 'ACT'
    },
    {
      'title': 'Romans',
      'anyTitle': 'Röm',
      'amharic': '45_ወደ ሮሜ ሰዎች.json',
      'anywaa': 'ROM',
      'number': '16',
      'abbrev': 'ROM'
    },
    {
      'title': '1 Corinthians',
      'anyTitle': '1 Körin',
      'amharic': '46_1ኛ ወደ ቆሮንቶስ ሰዎች.json',
      'anywaa': '1CO',
      'number': '16',
      'abbrev': '1CO'
    },
    {
      'title': '2 Corinthians',
      'anyTitle': '2 Körin',
      'amharic': '47_2ኛ ወደ ቆሮንቶስ ሰዎች.json',
      'anywaa': '2CO',
      'number': '13',
      'abbrev': '2CO'
    },
    {
      'title': 'Galatians',
      'anyTitle': 'Galeecia',
      'amharic': '48_ወደ ገላትያ ሰዎች.json',
      'anywaa': 'GAL',
      'number': '6',
      'abbrev': 'GAL'
    },
    {
      'title': 'Ephesians',
      'anyTitle': 'Epeca',
      'amharic': '49_ወደ ኤፌሶን ሰዎች.json',
      'anywaa': 'EPH',
      'number': '6',
      'abbrev': 'EPH'
    },
    {
      'title': 'Philippians',
      'anyTitle': 'Pilipay',
      'amharic': '50_ወደ ፊልጵስዩስ ሰዎች.json',
      'anywaa': 'PHP',
      'number': '4',
      'abbrev': 'PHP'
    },
    {
      'title': 'Colossians',
      'anyTitle': 'Köløcia',
      'amharic': '51_ወደ ቆላስይስ ሰዎች.json',
      'anywaa': 'COL',
      'number': '4',
      'abbrev': 'COL'
    },
    {
      'title': '1 Thessalonians',
      'anyTitle': '1 Thecalönika',
      'amharic': '52_1ኛ ወደ ተሰሎንቄ ሰዎች.json',
      'anywaa': '1TH',
      'number': '5',
      'abbrev': '1TH'
    },
    {
      'title': '2 Thessalonians',
      'anyTitle': '2 Thecalönika',
      'amharic': '53_2ኛ ወደ ተሰሎንቄ ሰዎች.json',
      'anywaa': '2TH',
      'number': '3',
      'abbrev': '2TH'
    },
    {
      'title': '1 Timothy',
      'anyTitle': '1 Timöthi',
      'amharic': '54_1ኛ ወደ ጢሞቴዎስ.json',
      'anywaa': '1TI',
      'number': '6',
      'abbrev': '1TI'
    },
    {
      'title': '2 Timothy',
      'anyTitle': '2 Timöthi',
      'amharic': '55_2ኛ ወደ ጢሞቴዎስ.json',
      'anywaa': '2TI',
      'number': '4',
      'abbrev': '2TI'
    },
    {
      'title': 'Titus',
      'amharic': '56_ወደ ቲቶ.json',
      'anyTitle': 'Tayta',
      'anywaa': 'TIT',
      'number': '3',
      'abbrev': 'TIT'
    },
    {
      'title': 'Philemon',
      'amharic': '57_ወደ ፊልሞና.json',
      'anyTitle': 'Piliman',
      'anywaa': 'PHM',
      'number': '1',
      'abbrev': 'PHM'
    },
    {
      'title': 'Hebrews',
      'anyTitle': 'Ibaru',
      'amharic': '58_ወደ ዕብራውያን.json',
      'anywaa': 'HEB',
      'number': '13',
      'abbrev': 'HEB'
    },
    {
      'title': 'James',
      'anyTitle': 'Jeemeth',
      'amharic': '59_የያዕቆብ መልእክት.json',
      'anywaa': 'JAS',
      'number': '5',
      'abbrev': 'JAS'
    },
    {
      'title': '1 Peter',
      'anyTitle': '1 Piter',
      'amharic': '60_1ኛ የጴጥሮስ መልእክት.json',
      'anywaa': '1PE',
      'number': '5',
      'abbrev': '1PE'
    },
    {
      'title': '2 Peter',
      'anyTitle': '2 Piter',
      'amharic': '61_2ኛ የጴጥሮስ መልእክት.json',
      'anywaa': '2PE',
      'number': '3',
      'abbrev': '2PE'
    },
    {
      'title': '1 John',
      'anyTitle': '1 Jøøn',
      'amharic': '62_1ኛ የዮሐንስ መልእክት.json',
      'anywaa': '1JN',
      'number': '5',
      'abbrev': '1JN'
    },
    {
      'title': '2 John',
      'anyTitle': '2 Jøøn',
      'amharic': '63_2ኛ የዮሐንስ መልእክት.json',
      'anywaa': '2JN',
      'number': '1',
      'abbrev': '2JN'
    },
    {
      'title': '3 John',
      'anyTitle': '3 Jøøn',
      'amharic': '64_3ኛ የዮሐንስ መልእክት.json',
      'anywaa': '3JN',
      'number': '1',
      'abbrev': '3JN'
    },
    {
      'title': 'Jude',
      'anyTitle': 'Juut',
      'amharic': '65_የይሁዳ መልእክት.json',
      'anywaa': 'JUD',
      'number': '1',
      'abbrev': 'JUD'
    },
    {
      'title': 'Revelation',
      'anyTitle': 'Mana Nyooth',
      'amharic': '66_የዮሐንስ ራእይ.json',
      'anywaa': 'REV',
      'number': '22',
      'abbrev': 'REV'
    }
  ];

  int currentOpenedPanelIndex = -1;

  SelectedFontStyle style = SelectedFontStyle()..init();
  String bibleVersion = '';
  int chapter = 0;
  Brightness currentTheme = Brightness.dark;
  SelectedFontStyle selectedFontStyle = SelectedFontStyle()..init();
  int? testementNumber;
  int tabIndex = 0;
  ScrollController scrollController = ScrollController();

  List<Map<String, String>> _foundBook = [];
  List<Map<String, String>> _foundOldBook = [];

  @override
  void initState() {
    refresh();
    getLanguageVersion();

    // TODO: implement initState
    _foundBook = newTestList;
    _foundOldBook = oldTestList;

    super.initState();
  }

  static String version = '';
  int listIndex = 0;
  void getLanguageVersion() async {
    final languageVersion = await style.getLanguageVersion();

    String currentVersion = languageVersion.split(' ')[0];
    final myListIndex = await style.getBookIndex();

    setState(() {
      version = currentVersion;
      listIndex = myListIndex;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.jumpTo(myListIndex * 50);
    });
    // print(testementNumber);
  }

  void _runFilter(String enteredKeyword) {
    List<Map<String, String>> result = [];
    List<Map<String, String>> oldTestResult = [];
    if (enteredKeyword.isEmpty) {
      result = newTestList;
      oldTestResult = oldTestList;
    } else {
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

  void refresh() async {
    final myTestemetNum = await style.getTestementNum();
    setState(() {
      testementNumber = myTestemetNum;
    });
  }

  // List<Widget> myTabs =;

  @override
  Widget build(BuildContext context) {
    // getLanguageVersion();
    print('initila index: $testementNumber');
    currentTheme = Theme.of(context).brightness;
    return testementNumber == null
        ? const Center(
            child: SpinKitWaveSpinner(
              color: Color.fromARGB(255, 13, 33, 65),
              size: 50.0,
            ),
          )
        : DefaultTabController(
            animationDuration: Duration.zero,
            initialIndex: testementNumber!,
            length: 2,
            child: Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  toolbarHeight: 100,
                  forceMaterialTransparency: true,
                  title: Column(
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
                              icon: const Icon(
                                Icons.arrow_back_rounded,
                              )),
                          Text(
                              version == 'ANY'
                                  ? 'Nyeŋ Weet Jwøk'
                                  : version == 'AMH'
                                      ? 'መጻሕፍት'
                                      : 'Holy bible books',
                              style: const TextStyle(
                                fontSize: 19,
                              )),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                              height: 50,
                              width: 50,
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(155, 75, 75, 75),
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      topLeft: Radius.circular(20))),
                              child: const Center(
                                child: Icon(
                                  Icons.search,
                                  size: 30,
                                ),
                              )),
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              width: double.infinity,
                              child: TextField(
                                onChanged: (value) => _runFilter(value),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          bottomRight: Radius.circular(20))),
                                  filled: true,
                                  focusedBorder: InputBorder.none,
                                  fillColor: Color.fromARGB(155, 75, 75, 75),
                                  label: Text(
                                    '',
                                    style: TextStyle(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  bottom: TabBar(
                      // controller: tabController,
                      // physics: NeverScrollableScrollPhysics(),
                      onTap: (index) {
                        setState(() {
                          tabIndex = index;
                        });
                      },
                      labelColor: Colors.amber,
                      indicatorColor: Colors.amber,
                      tabs: [
                        Tab(
                          height: 80,
                          child: ListTile(
                            title: const Text(
                              'Old Testement',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            subtitle: version == 'AMH'
                                ? const Text('ብሉይ ኪዳን',
                                    style: TextStyle(fontSize: 15))
                                : version == 'ANY'
                                    ? const Text('Wëël Luumma Kwøŋ Tuut')
                                    : const Text(''),
                          ),
                        ),
                        Tab(
                          height: 80,
                          child: ListTile(
                            title: const Text(
                              'New Testement',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17.7),
                            ),
                            subtitle: version == 'AMH'
                                ? const Text('አዲስ ኪዳን',
                                    style: TextStyle(fontSize: 15))
                                : version == 'ANY'
                                    ? const Text('Wëël Luumma Nyään Na Tuut')
                                    : const Text(''),
                          ),
                        ),
                      ]),
                ),
                body: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    // controller: tabController,
                    children: <Widget>[
                      oldTestement(),
                      newTestement(),
                    ])),
          );
  }

  Widget oldTestement() {
    return ListView.builder(
        controller: scrollController,
        shrinkWrap: true,
        itemCount: _foundOldBook.length,
        itemBuilder: (context, listviewindex) {
          return ListTile(
            key: ValueKey(_foundOldBook[listviewindex]['title']),
            trailing: version == 'AMH'
                ? Text(
                    _foundOldBook[listviewindex]['amharic']!
                        .split('_')[1]
                        .split('.')[0],
                    style: TextStyle(
                        fontSize: 16,
                        color:
                            (listviewindex == listIndex && testementNumber == 0)
                                ? Colors.amber
                                : null),
                  )
                : version == 'ANY'
                    ? Text(
                        '${_foundOldBook[listviewindex]['title']}',
                        style: TextStyle(
                            fontSize: 16,
                            color: (listviewindex == listIndex &&
                                    testementNumber == 0)
                                ? Colors.amber
                                : Colors.grey),
                      )
                    : const Text(''),
            title: version == 'ANY'
                ? Text(
                    '${_foundOldBook[listviewindex]['anywaa']}',
                    style: TextStyle(
                        fontSize: 19.5,
                        color:
                            (listviewindex == listIndex && testementNumber == 0)
                                ? Colors.amber
                                : null),
                  )
                : Text(
                    '${_foundOldBook[listviewindex]['title']}',
                    style: TextStyle(
                        fontSize: 19.5,
                        color:
                            (listviewindex == listIndex && testementNumber == 0)
                                ? Colors.amber
                                : null),
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
                              : version == 'ANY'
                                  ? '${_foundOldBook[listviewindex]['title']} | ${_foundOldBook[listviewindex]['anywaa']}'
                                  : '${_foundOldBook[listviewindex]['title']} ',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      body: Padding(
                        padding: const EdgeInsets.only(
                            top: 20, left: 10, right: 10, bottom: 40),
                        child: GridView.count(
                          physics: const ScrollPhysics(
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
                                              ? const Color.fromARGB(
                                                  255, 250, 219, 124)
                                              : const Color.fromARGB(
                                                  255, 0, 4, 17))),
                                  onPressed: () async {
                                    getLanguageVersion();
                                    bibleVersion = version == 'AMH'
                                        ? '${_foundOldBook[listviewindex]['amharic']}'
                                        : version == 'ANY'
                                            ? 'ANY/OT/${_foundOldBook[listviewindex]['abbrev']}.json'
                                            : 'OT/${_foundOldBook[listviewindex]['abbrev']}/$version.json';
                                    style.setBookIndex(listviewindex);

                                    style.setBibleVersion(bibleVersion);
                                    style.setTestementNum(0);
                                    selectedFontStyle.setPage(index);
                                    setState(() {
                                      chapter = index;
                                    });

                                    Navigator.pop(context, chapter);
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
        controller: scrollController,
        shrinkWrap: true,
        itemCount: _foundBook.length,
        itemBuilder: (context, listviewindex) {
          return ListTile(
            key: ValueKey(_foundBook[listviewindex]['title']),
            title: version == 'AMH'
                ? Text(
                    '${_foundBook[listviewindex]['title']}',
                    style: TextStyle(
                        fontSize: 19.5,
                        color:
                            (listviewindex == listIndex && testementNumber == 1)
                                ? Colors.amber
                                : null),
                  )
                : version == 'ANY'
                    ? Text(
                        '${_foundBook[listviewindex]['anyTitle']}',
                        style: TextStyle(
                            fontSize: 19.5,
                            color: (listviewindex == listIndex &&
                                    testementNumber == 1)
                                ? Colors.amber
                                : null),
                      )
                    : Text(
                        '${_foundBook[listviewindex]['title']}',
                        style: TextStyle(
                            fontSize: 19.5,
                            color: (listviewindex == listIndex &&
                                    testementNumber == 1)
                                ? Colors.amber
                                : null),
                      ),
            trailing: version == 'AMH'
                ? Text(
                    _foundBook[listviewindex]['amharic']!
                        .split('_')[1]
                        .split('.')[0],
                    style: TextStyle(
                        fontSize: 16,
                        color:
                            (listviewindex == listIndex && testementNumber == 1)
                                ? Colors.amber
                                : null),
                  )
                : version == 'ANY'
                    ? Text(
                        '${_foundBook[listviewindex]['title']}',
                        style: TextStyle(
                            fontSize: 16,
                            color: (listviewindex == listIndex &&
                                    testementNumber == 1)
                                ? Colors.amber
                                : Colors.grey),
                      )
                    : const Text(''),
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Scaffold(
                      appBar: AppBar(
                        // centerTitle: true,
                        title: version == 'ANY'
                            ? Text(
                                '${_foundBook[listviewindex]['title']} | ${_foundBook[listviewindex]['anyTitle']}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              )
                            : version == 'AMH'
                                ? Text(
                                    '${_foundBook[listviewindex]['title']} | ${_foundBook[listviewindex]['amharic']?.split('_')[1].split('.')[0]}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  )
                                : Text(
                                    '${_foundBook[listviewindex]['title']}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                      ),
                      body: Padding(
                        padding: const EdgeInsets.only(
                            top: 20, left: 10, right: 10, bottom: 40),
                        child: GridView.count(
                          physics: const ScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          shrinkWrap: true,
                          crossAxisCount: 6,
                          children: List.generate(
                              int.parse(
                                  '${_foundBook[listviewindex]['number']}'),
                              (index) {
                            return Card(
                              child: Center(
                                child: TextButton(
                                  child: Text('${index + 1}',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color:
                                              currentTheme == Brightness.light
                                                  ? const Color.fromARGB(
                                                      255, 0, 4, 17)
                                                  : const Color.fromARGB(
                                                      255, 250, 219, 124))),
                                  onPressed: () async {
                                    getLanguageVersion();
                                    bibleVersion = version != 'AMH'
                                        ? version == 'ANY'
                                            ? 'ANY/NT/${_foundBook[listviewindex]['abbrev']}.json'
                                            : 'NT/${_foundBook[listviewindex]['abbrev']}/$version.json'
                                        : '${_foundBook[listviewindex]['amharic']}';
                                    style.setBookIndex(listviewindex);
                                    style.setBibleVersion(bibleVersion);
                                    style.setTestementNum(1);
                                    selectedFontStyle.setPage(index);
                                    setState(() {
                                      chapter = index;
                                    });

                                    Navigator.pop(context, chapter);
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
