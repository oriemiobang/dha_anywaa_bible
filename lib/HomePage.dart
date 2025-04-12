// ignore_for_file: empty_catches

import 'dart:convert';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:dha_anywaa_bible/classes/position_data.dart';
import 'package:dha_anywaa_bible/components/Book.dart';
import 'package:dha_anywaa_bible/components/account.dart';
import 'package:dha_anywaa_bible/components/chapter_list.dart';

// import 'package:audioplayers/audioplayers.dart';
import 'package:dha_anywaa_bible/classes/SQLHelper.dart';
import 'package:dha_anywaa_bible/classes/color_highlight.dart';
import 'package:dha_anywaa_bible/classes/dailyText.dart';
import 'package:dha_anywaa_bible/classes/font_size.dart';
import 'package:dha_anywaa_bible/classes/font_style.dart';
import 'package:dha_anywaa_bible/classes/highlights.dart';
import 'package:dha_anywaa_bible/daily_text.dart';
import 'package:dha_anywaa_bible/components/differentVerse.dart';
import 'package:dha_anywaa_bible/components/setting.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';


import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:share_plus/share_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  String myjsonString = 'assets/fonts/chapters/Any/Genesis.json';
  String englishJsonString = 'assets/holybooks/$bibleVersion';
  String anywaaJsonString = 'assets/holybooks/ANY/$bibleVersion';
  String amharicJsonString = 'assets/holybooks/AM/$amhBibleVersion';

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

  Future engLoadData() async {
    try {
      String engJsonString = await _engLoadData();
      final engJsonResponse = json.decode(engJsonString);
      setState(() {
        englishBook = EnglishBook.fromJson(engJsonResponse);
        pageLength = englishBook!.chapters.length;
        // title = englishBook!.name;
      });
      if (player.playing) {
        player.stop();
      }
    } catch (e) {
      print('english problem');
      print(e);
    }
  }

  Future anywaaLoadData() async {
    try {
      String anyJsonString = await _anywaaLoadData();
      final anyJsonResponse = json.decode(anyJsonString);
      setState(() {
        anywaaBook = AnywaaBook.fromJson(anyJsonResponse);
        pageLength = anywaaBook!.chapters.length;
      });

      var link = anywaaBook!.chapters[pageIndex].audioLink;
      if (link != null) {
        player.setUrl(link);
      }
    } catch (e) {
      print('dha anywaa problem');
      print(e);
    }
  }

  Future amhLoadData() async {
    try {
      String amhJsonString = await _amhLoadData();
      final amhJsonResponse = json.decode(amhJsonString);
      setState(() {
        amharicBook = AmharicChapters.fromJson(amhJsonResponse);
        title = amharicBook!.title;
        pageLength = amharicBook!.chapters.length;
      });
      if (player.playing) {
        player.stop();
      }
    } catch (e) {
      print('amharic problem');
      print(e);
    }
  }

  FontSize fontSize = FontSize();
  SelectedFontStyle style = SelectedFontStyle()..init();
  double _currentFontSize = 0;
  String currentFont = '';
  static String bibleVersion = '';
  static String amhBibleVersion = '';
  String _language = '';
  static int mypage = 0;
  bool isPlaying = false;
  bool showPlay = false;
  late int bookIndex;
  late AudioPlayer player;
  void getFontSize() async {
    var fontsize = await fontSize.getFontSize();
    var fontStyle = await style.getFontStyle();
    setState(() {
      _currentFontSize = fontsize;
      currentFont = fontStyle;
    });
  }

  void getBibleVersion(
      {bool? fromChoosing, bool? fromInState, bool? noLoad}) async {
    bookIndex = await style.getTestementNum();
    bibleVersion = await style.getBibleVersion();
    final language = await style.getLanguageVersion();
    int currentPage = await style.getPage();

    if (noLoad == null) {
      if (language.split(' ')[0] == 'AMH') {
        setState(() {
          amhBibleVersion = bibleVersion;
          // print(amhBibleVersion);
          amharicJsonString = 'assets/holybooks/AM/$amhBibleVersion';
        });
        amhLoadData();
      } else if (language.split(' ')[0] == 'ANY') {
        anywaaJsonString = 'assets/holybooks/$bibleVersion';

        englishJsonString = 'assets/holybooks/$bibleVersion';

        for (int myIndex = 0; myIndex < bookList.length; myIndex++) {
          var nowVersion = bookList[myIndex];
          if (nowVersion['abbrev'] ==
              bibleVersion.split('/')[2].split('.')[0]) {
            title =
                myIndex < 39 ? nowVersion['anywaa']! : nowVersion['anyTitle']!;
            break;
          }
        }
        setState(() {});

        anywaaLoadData();
      } else {
        setState(() {
          englishJsonString = 'assets/holybooks/$bibleVersion';
          for (var nowVersion in bookList) {
            if (nowVersion['abbrev'] == bibleVersion.split('/')[1]) {
              title = nowVersion['title']!;
              break;
            }
          }
        });
        engLoadData();
      }
    }
    setState(() {
      pageIndex = currentPage;
      getFontSize();
      languageVerson();
      _language = language.split(' ')[0];
      mypage = currentPage;
    });
  }

  Future<void> refresher() async {
    final highlight = await ColorHighlight.gethighlight();
    setState(() {
      _highlight = highlight;
    });
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        player.positionStream,
        player.bufferedPositionStream,
        player.durationStream,
        (position, bufferedPosition, duration) => PositionData(
          position,
          bufferedPosition,
          duration ?? Duration.zero,
        ),
      );

  @override
  void initState() {
    player = AudioPlayer();

    refresher();
    super.initState();
    controller.addListener(listen);
    info();
    getBibleVersion(fromInState: true);
  }

  Color selectedColor = Colors.blue;

  //=====================================================
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex != 1) {
        markedText = [];
      }
      // print(_highlight);
      info();
      getBibleVersion(noLoad: true);
    });
  }

  ColorHighlight colorHighlight = ColorHighlight();
  ScrollController controller = ScrollController();
  ScrollController mycontroller = ScrollController();
  bool isVisible = true;
  SelectedFontStyle selectedFontStyle = SelectedFontStyle();
  UniqueKey key = UniqueKey();

  final Uri webUrl = Uri.parse('https://oriemioriemi.netlify.app');

  @override
  void dispose() {
    // TODO: implement dispose
    controller.removeListener(listen);
    controller.dispose();

    super.dispose();
    player.dispose();
  }

  show() {
    if (!isVisible) {
      setState(() {
        isVisible = true;
      });
    }
  }

  hide() {
    if (isVisible) {
      setState(() {
        isVisible = false;
      });
    }
  }

  listen() {
    final direction = controller.position.userScrollDirection;
    if (direction == ScrollDirection.forward || controller.position.atEdge) {
      show();
    } else if (direction == ScrollDirection.reverse) {
      hide();
    }
  }

  DailyVerse dailyText = DailyVerse();
  String currentText = "";
  String currentVerse = "";

  String title = "";
  bool thereIsComment = true;
  int pageLength = 0;
  bool isExist = false;
  int currentVerseIndex = 0;
  String currentBibleVerse = '';
  int pageIndex = 0;
  int colorIndex = 0;
  int selectedColorIndex = -1;
  String date = "";
  List markedText = [];
  List<Map<String, dynamic>> _highlight = [];
  List<Color> colorList = [
    const Color.fromARGB(102, 244, 67, 54),
    const Color.fromARGB(88, 233, 30, 98),
    const Color.fromARGB(93, 158, 158, 158),
    const Color.fromARGB(99, 76, 175, 79),
    const Color.fromARGB(106, 79, 33, 243),
    const Color.fromARGB(123, 159, 30, 233),
    const Color.fromARGB(113, 30, 142, 233),
    const Color.fromARGB(125, 255, 153, 0),
    const Color.fromARGB(146, 255, 193, 7),
    const Color.fromARGB(84, 130, 243, 134),
    const Color.fromARGB(94, 201, 125, 245)
  ];

  Future<int> _getItem() async {
    final item = await SQLHelper.getItem(1);
    return item[0]['counter'];
  }

  void info() async {
    try {
      int myIndex = await _getItem();
      currentText = dailyText.dailyVerseList[myIndex]['text']!;
      currentVerse = dailyText.dailyVerseList[myIndex]['verse']!;
    } catch (e) {
      print('error: $e');
    }
  }

  String _currentVersion = '';

  void languageVerson() async {
    final currentVersion = await selectedFontStyle.getLanguageVersion();
    setState(() {
      _currentVersion = currentVersion.split(' ')[0];
    });
  }

  void markText({index, chapterName, chapterNumber, chapterId, text, textId}) {
    Map currentDict = {
      "chapterId": chapterId,
      "chapterName": chapterName,
      "chapterNumber": chapterNumber,
      "text": text,
      'textId': textId
    };
    isExist = markedText.any((dic) => mapEquals(dic, currentDict));

    if (isExist) {
      markedText.removeWhere((element) => element['text'] == '$text');
    } else {
      markedText.add({
        "chapterId": chapterId,
        "chapterName": chapterName,
        "chapterNumber": chapterNumber,
        "text": text,
        'textId': textId
      });
    }
    setState(() {});
  }

  void getCurrentDate() {
    int hour = 0;
    int minute = 0;
    int second = 0;
    final now = DateTime.now();
    var formatter = DateFormat('MMMM dd yyyy');
    var formattedDate = formatter.format(now);
    hour = DateTime.now().hour > 12
        ? DateTime.now().hour - 12
        : DateTime.now().hour == 0
            ? 12
            : DateTime.now().hour;
    minute = DateTime.now().minute;
    second = DateTime.now().second;
    String amOrPm = DateFormat('a').format(now);

    formattedDate = '$formattedDate $hour:$minute:$second $amOrPm';
    setState(() {
      date = formattedDate;
    });
  }

  void addBookmark(bookmarks) {
    getCurrentDate();
    if (bookmarks.length > 1) {
      String textVerse = '';
      String verseNumber = '';

      for (var bookmark in bookmarks) {
        textVerse = '${textVerse + bookmark['text']}\n';
        verseNumber = '${verseNumber + bookmark['chapterId']}, ';
      }
      Highlight.createItem(
          textVerse,
          '${bookmarks[0]['chapterName']} ${bookmarks[0]['chapterNumber']}: $verseNumber',
          date,
          _language);
      Fluttertoast.showToast(
          msg: "Bookmarks added",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: const Color.fromARGB(255, 0, 4, 17),
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Highlight.createItem(
          bookmarks[0]['text'],
          '${bookmarks[0]['chapterName']} ${bookmarks[0]['chapterNumber']}: ${bookmarks[0]['chapterId']}',
          date,
          _language);

      Fluttertoast.showToast(
          msg: "Bookmark added",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: const Color.fromARGB(255, 0, 4, 17),
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  void copyVerse(markedText) {
    if (markedText.length > 1) {
      String textVerse = '';
      String verseNumber = '';
      for (var currentMarkedText in markedText) {
        textVerse = '${textVerse + currentMarkedText['text']}\n';
        verseNumber = '${verseNumber + currentMarkedText['chapterId']}, ';
      }
      Clipboard.setData(ClipboardData(text: '$textVerse \n\n $verseNumber'));
    } else {
      Clipboard.setData(ClipboardData(text: markedText[0]['text']));
    }

    Fluttertoast.showToast(
        msg: "Text copied!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color.fromARGB(255, 0, 4, 17),
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void shareVerse(markedText) {
    if (markedText.length > 1) {
      String textVerse = '';
      String verseNumber = '';
      for (var currentMarkedText in markedText) {
        textVerse = '${textVerse + currentMarkedText['text']}\n';
        verseNumber = '${verseNumber + currentMarkedText['chapterId']}, ';
      }
      Share.share(
          "$textVerse\n ${markedText[0]['chapterName']} ${markedText[0]['chapterNumber']}: $verseNumber");
    } else {
      Share.share(
          "${markedText[0]['text']}\n ${markedText[0]['chapterName']} ${markedText[0]['chapterNumber']}: ${markedText[0]['chapterId']}}");
    }
  }

  void setPageIndex({required int index, bool? fromChoosing}) {
    if (fromChoosing == null) {
      style.setPage(index);
    }
  }

  List<Map<String, String>> bookList = [
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

  Future<void> _openUrl() async {
    try {
      await launchUrl(
        webUrl,
        webOnlyWindowName: '_blank',
        mode: LaunchMode.externalApplication,
        webViewConfiguration:
            const WebViewConfiguration(enableJavaScript: true),
      );
    } catch (e) {
      print('error $e');
    }
  }

  // share the app

  void playSong() async {
    if (!player.playing) {
      await player.play();
    } else {
      await player.pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    Brightness currentTheme = Theme.of(context).brightness;
    PreferredSizeWidget buildAppBar() {
      switch (_selectedIndex) {
        case 0:
          return AppBar(
            backgroundColor: Colors.transparent,
            actions: [
              Container(
                height: 37,
                width: 37,
                decoration: BoxDecoration(
                  color: currentTheme == Brightness.light
                      ? const Color.fromARGB(255, 231, 235, 254)
                      : const Color.fromARGB(162, 95, 90, 74),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: IconButton(
                    onPressed: () async {
                      try {
                        await Share.share('$currentVerse \n $currentText');
                      } catch (e) {}
                    },
                    icon: Icon(
                      Icons.share,
                      color: currentTheme == Brightness.light
                          ? const Color.fromARGB(255, 1, 17, 57)
                          : Colors.amber,
                    ),
                  ),
                ),
              )
            ],
            // title: TextButton(
            //     onPressed: () {
            //       setState(() {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(builder: (context) => const Pray()),
            //         );
            //       });
            //     },
            //     child: Text(
            //       _language == 'AMH'
            //           ? 'ፀልይ'
            //           : _language == 'ANY'
            //               ? 'Lämï'
            //               : 'Pray',
            //       style: TextStyle(
            //         fontSize: 20.5,
            //         color: currentTheme == Brightness.light
            //             ? const Color.fromARGB(255, 1, 11, 36)
            //             : const Color.fromARGB(255, 243, 179, 83),
            //       ),
            //     )),
            // leadingWidth: 200,
            forceMaterialTransparency: true,
          );
        case 1:
          return AppBar(
              leadingWidth: 200,
              leading: SizedBox(
                width: 200,
                child: TextButton(
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChapterList())).then((value) {
                      if (value != null) {
                        setState(() {
                          mypage = value;
                        });

                        setPageIndex(index: mypage, fromChoosing: true);
                      }
                      getBibleVersion(fromChoosing: true);
                    });
                  },
                  child: Text(
                    title,
                    style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ),
              ),
              forceMaterialTransparency: true,
              actions: [
                // Container(width: 100, color: Colors.grey),

                Row(
                  children: [
                    Visibility(
                        visible: _language == 'ERV' || _language == 'ANY',
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              thereIsComment = !thereIsComment;
                            });
                          },
                          icon: thereIsComment
                              ? const Icon(
                                  Icons.comment,
                                  size: 18,
                                )
                              : const Icon(
                                  Icons.comments_disabled,
                                  size: 18,
                                ),
                        )),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/chooseBible')
                            .then((value) {
                          if (value != null) {
                            languageVerson();
                            getBibleVersion();
                          }
                        });
                      },
                      child: Text(
                        _currentVersion,
                        style: TextStyle(
                            color: currentTheme == Brightness.dark
                                ? Colors.white
                                : Colors.black),
                      ),
                    ),
                  ],
                )
                // IconButton(
                //   icon: const Icon(
                //     Icons.search,
                //     color: Color.fromARGB(255, 227, 171, 2),
                //   ),
                //   onPressed: () {},
                // ),
              ]);
        case 2:
          return AppBar(
            title: const Text(
              'Bookmarks',
              style: TextStyle(),
            ),
            forceMaterialTransparency: true,
          );
        default:
          return AppBar(
            title: const Text('Flutter Navigation Example'),
          );
      }
    }

    return StreamBuilder<PlayerState>(
        stream: player.playerStateStream,
        builder: (context, snapshot) {
          final playerState = snapshot.data;
          // final processingState = playerState?.processingState;
          final playing = playerState?.playing;
          if (playing != null) {
            isPlaying = playing;
          }

          try {
            return Scaffold(
              drawer: _selectedIndex == 2
                  ? Drawer(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          const DrawerHeader(
                            child: Column(
                              children: [
                                Image(
                                    height: 110,
                                    image: AssetImage(
                                        'assets/images/weel_jwok_icon.png')),
                                Text(
                                  "Wëël Jwøk",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          ListTile(
                            leading: const Icon(Icons.settings),
                            onTap: () {
                              setState(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Setting()),
                                ).then((value) {
                                  getBibleVersion();
                                });
                              });
                            },
                            title: const Text(
                              'Settings',
                            ),
                          ),
                          // const ListTile(
                          //   leading: Icon(Icons.share),
                          //   title: Text(
                          //     'Share',
                          //     style: TextStyle(),
                          //   ),
                          // ),
                          // const ListTile(
                          //   leading: Icon(Icons.help_outline),
                          //   title: Text(
                          //     'Help',
                          //     style: TextStyle(),
                          //   ),
                          // ),
                          ListTile(
                            onTap: () {
                              Navigator.pushNamed(context, '/about');
                            },
                            leading: const Icon(Icons.menu_book_rounded),
                            title: const Text(
                              'About the app',
                              style: TextStyle(),
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              _openUrl();
                            },
                            leading: const Icon(
                              Icons.person,
                            ),
                            title: const Text(
                              'About the developer',
                              style: TextStyle(),
                            ),
                          ),
                        ],
                      ),
                    )
                  : null,
              body: _selectedIndex == 1
                  ? _language == 'AMH'
                      ? amharicBook == null
                          ? const Center(
                              child: SpinKitWaveSpinner(
                                color: Color.fromARGB(255, 13, 33, 65),
                                size: 50.0,
                              ),
                            )
                          :
                          // PageView.builder(
                          //     physics: const NeverScrollableScrollPhysics(),
                          //     key: key,

                          //     onPageChanged: (index) {
                          //       setPageIndex(index: index);
                          //       print('onPageChanged');
                          //       setState(() {
                          //         getBibleVersion();

                          //       });
                          //     },
                          //     itemCount: amharicBook!.chapters.length,
                          //     itemBuilder: (BuildContext context, int pageIndex) {
                          //       // var amhbook = amharicBook!.chapters[pageIndex];

                          //       return
                          Padding(
                              padding: const EdgeInsets.only(
                                  top: 8, left: 10, bottom: 0, right: 9),
                              child: ListView.builder(
                                  key: key,
                                  controller: controller,
                                  itemCount: amharicBook!
                                      .chapters[pageIndex].verses.length,
                                  itemBuilder:
                                      (BuildContext context, int listIndex) {
                                    var amhchapters = amharicBook!
                                        .chapters[pageIndex].verses[listIndex];
                                    // var nextAmhChapter = amhchapters;
                                    // if (amharicBook!.chapters[pageIndex].verses
                                    //             .length -
                                    //         1 >
                                    //     listIndex) {
                                    //   nextAmhChapter = amharicBook!
                                    //       .chapters[pageIndex]
                                    //       .verses[listIndex + 1];
                                    // }
                                    return Column(
                                      children: [
                                        // listIndex == 0
                                        //     ? Text(
                                        //         amharicBook!.title,
                                        //         style: const TextStyle(
                                        //             fontSize: 22,
                                        //             fontWeight: FontWeight.bold,
                                        //             color: Colors.grey),
                                        //       )
                                        //     : const Visibility(
                                        //         visible: false,
                                        //         child: Text('')),
                                        // listIndex == 0
                                        //     ? Text(
                                        //         amhbook.chapter,
                                        //         style: const TextStyle(
                                        //             fontWeight:
                                        //                 FontWeight.bold,
                                        //             fontSize: 72),
                                        //       )
                                        //     : const Visibility(
                                        //         visible: false,
                                        //         child: Text('data')),
                                        Visibility(
                                            visible: listIndex == 0,
                                            child: const SizedBox(height: 5)),
                                        Padding(
                                          padding: amharicBook!
                                                          .chapters[pageIndex]
                                                          .verses
                                                          .length -
                                                      1 ==
                                                  listIndex
                                              ? const EdgeInsets.only(
                                                  bottom: 80)
                                              : EdgeInsets.zero,
                                          child: GestureDetector(
                                            onTap: () {
                                              currentBibleVerse = amhchapters;
                                              currentVerseIndex = listIndex;
                                              markText(
                                                  index: listIndex,
                                                  chapterName:
                                                      amharicBook!.title,
                                                  text: amhchapters,
                                                  chapterNumber: amharicBook!
                                                      .chapters[pageIndex]
                                                      .chapter,
                                                  chapterId: '${listIndex + 1}',
                                                  textId: currentBibleVerse);
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                amhchapters == '' ||
                                                        amhchapters == '-'
                                                    ? const Visibility(
                                                        visible: false,
                                                        child: Text(''))
                                                    : Visibility(
                                                        visible: listIndex != 0,
                                                        child: Text(
                                                          '${listIndex + 1}  ',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  currentFont,
                                                              fontSize:
                                                                  _currentFontSize,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      ),
                                                amhchapters == '' ||
                                                        amhchapters == '-'
                                                    ? const Visibility(
                                                        visible: false,
                                                        child: Text(''))
                                                    : Expanded(
                                                        child: RichText(
                                                          text: TextSpan(
                                                            style: DefaultTextStyle
                                                                    .of(context)
                                                                .style,
                                                            children: [
                                                              listIndex == 0
                                                                  ? TextSpan(
                                                                      text:
                                                                          '${amharicBook!.chapters[pageIndex].chapter} ',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontFamily:
                                                                              currentFont,
                                                                          fontSize:
                                                                              57,
                                                                          color: const Color
                                                                              .fromARGB(
                                                                              255,
                                                                              255,
                                                                              179,
                                                                              0)),
                                                                    )
                                                                  : const TextSpan(),
                                                              TextSpan(
                                                                text:
                                                                    amhchapters,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      currentFont,
                                                                  fontSize:
                                                                      _currentFontSize,
                                                                  backgroundColor: _highlight
                                                                      .map((verse) => verse['id'] ==
                                                                              amhchapters
                                                                          ? colorList[verse[
                                                                              'color']]
                                                                          : null)
                                                                      .firstWhere(
                                                                          (color) =>
                                                                              color !=
                                                                              null,
                                                                          orElse: () =>
                                                                              Colors.transparent),
                                                                  decoration: markedText.any((dic) =>
                                                                          dic['text'] ==
                                                                          amhchapters)
                                                                      ? TextDecoration
                                                                          .underline
                                                                      : null,
                                                                  decorationStyle: markedText.any((dic) =>
                                                                          dic['text'] ==
                                                                          amhchapters)
                                                                      ? TextDecorationStyle
                                                                          .dashed
                                                                      : null,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 7,
                                        )
                                      ],
                                    );
                                  }),
                            )
                      : _language == 'ANY'
                          ? anywaaBook == null
                              ? const Center(
                                  child: SpinKitWaveSpinner(
                                    color: Color.fromARGB(255, 13, 33, 65),
                                    size: 50.0,
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: ListView.builder(
                                      key: key,
                                      itemCount: anywaaBook!
                                          .chapters[pageIndex].verses.length,
                                      shrinkWrap: true,
                                      controller: controller,
                                      itemBuilder: (BuildContext context,
                                          int listindex) {
                                        var chapter = anywaaBook!
                                            .chapters[pageIndex]
                                            .verses[listindex];
                                        var chapterNumber = anywaaBook!
                                            .chapters[pageIndex].name
                                            .split(' ')[anywaaBook!
                                                .chapters[pageIndex].name
                                                .split(' ')
                                                .length -
                                            1];

                                        List splittedName = anywaaBook!
                                            .chapters[pageIndex].name
                                            .split(' ');
                                        splittedName.removeWhere((element) =>
                                            int.tryParse(element) != null);
                                        String chapterName =
                                            splittedName.join(' ');

                                        return Column(
                                          // crossAxisAlignment:
                                          //     CrossAxisAlignment.start,
                                          children: [
                                            // listindex == 0
                                            //     ? Text(
                                            //         chapterName,
                                            //         style: const TextStyle(
                                            //             fontSize: 26,
                                            //             fontWeight:
                                            //                 FontWeight.bold,
                                            //             color: Colors.grey),
                                            //       )
                                            //     : const SizedBox(),

                                            Visibility(
                                              visible: listindex == 0,
                                              child: const SizedBox(
                                                height: 5,
                                              ),
                                            ),
                                            (anywaaBook!
                                                    .chapters[pageIndex]
                                                    .verses[listindex]
                                                    .title!
                                                    .isNotEmpty)
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 30,
                                                            right: 30,
                                                            bottom: 6),
                                                    child: Text(
                                                      '\n${anywaaBook!.chapters[pageIndex].verses[listindex].title}',
                                                      style: const TextStyle(
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  )
                                                : const Visibility(
                                                    visible: false,
                                                    child: Text(''),
                                                  ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 9),
                                              child: Visibility(
                                                  visible: anywaaBook!
                                                      .chapters[pageIndex]
                                                      .verses[listindex]
                                                      .reference!
                                                      .isNotEmpty,
                                                  child: Text(
                                                    '${anywaaBook!.chapters[pageIndex].verses[listindex].reference}',
                                                    style: const TextStyle(
                                                        fontSize: 15.5,
                                                        color: Colors.grey),
                                                  )),
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                chapter.text != '' &&
                                                        chapter.id != '1'
                                                    ? Text(
                                                        chapter.id == '1'
                                                            ? chapterNumber
                                                            : chapter.id,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: chapter.id ==
                                                                    '1'
                                                                ? const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    4,
                                                                    74,
                                                                    131,
                                                                  )
                                                                : Colors.grey,
                                                            fontSize:
                                                                chapter.id ==
                                                                        '1'
                                                                    ? 57
                                                                    : null),
                                                      )
                                                    : const Visibility(
                                                        visible: false,
                                                        child: Text('')),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Visibility(
                                                  visible: chapter.text != '',
                                                  child: Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            // print(_highlight);
                                                            currentBibleVerse =
                                                                '${anywaaBook!.chapters[pageIndex].id}${chapter.id}';

                                                            setState(() {
                                                              currentVerseIndex =
                                                                  int.parse(
                                                                      chapter
                                                                          .id);
                                                              selectedColorIndex =
                                                                  listindex;
                                                            });

                                                            markText(
                                                                index:
                                                                    listindex,
                                                                chapterName:
                                                                    chapterName,
                                                                text: chapter
                                                                    .text,
                                                                chapterNumber:
                                                                    chapterNumber,
                                                                chapterId:
                                                                    chapter.id,
                                                                textId:
                                                                    currentBibleVerse);
                                                          },
                                                          child: RichText(
                                                            text: TextSpan(
                                                                style: DefaultTextStyle.of(
                                                                        context)
                                                                    .style,
                                                                children: [
                                                                  chapter.id ==
                                                                          '1'
                                                                      ? TextSpan(
                                                                          text:
                                                                              '$chapterNumber ',
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              color: chapter.id == '1' ? const Color.fromARGB(255, 255, 179, 0) : Colors.grey,
                                                                              fontSize: chapter.id == '1' ? 57 : null),
                                                                        )
                                                                      : const TextSpan(),
                                                                  TextSpan(
                                                                    text: chapter
                                                                        .text,
                                                                    style:
                                                                        TextStyle(
                                                                      backgroundColor: _highlight.map((verse) => verse['id'] == '${anywaaBook!.chapters[pageIndex].id}${chapter.id}' ? colorList[verse['color']] : null).firstWhere(
                                                                          (color) =>
                                                                              color !=
                                                                              null,
                                                                          orElse: () =>
                                                                              Colors.transparent),
                                                                      fontFamily:
                                                                          currentFont,
                                                                      fontSize:
                                                                          _currentFontSize,
                                                                      decoration: markedText.any((dic) =>
                                                                              dic['text'] ==
                                                                              chapter.text)
                                                                          ? TextDecoration.underline
                                                                          : null,
                                                                      decorationStyle: markedText.any((dic) =>
                                                                              dic['text'] ==
                                                                              chapter.text)
                                                                          ? TextDecorationStyle.dashed
                                                                          : null,
                                                                    ),
                                                                  )
                                                                ]),
                                                          ),
                                                        ),
                                                        Visibility(
                                                          visible: chapter
                                                                  .comment!
                                                                  .isNotEmpty &&
                                                              thereIsComment,
                                                          child: Text(
                                                            '${chapter.comment}',
                                                            style: const TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic),
                                                          ),
                                                        ),
                                                        Visibility(
                                                          visible: anywaaBook!
                                                                  .chapters[
                                                                      pageIndex]
                                                                  .author!
                                                                  .isNotEmpty &&
                                                              (listindex ==
                                                                  (anywaaBook!
                                                                          .chapters[
                                                                              pageIndex]
                                                                          .verses
                                                                          .length -
                                                                      1)),
                                                          child: Column(
                                                            children: [
                                                              const SizedBox(
                                                                  height: 20),
                                                              Text(
                                                                anywaaBook!
                                                                    .chapters[
                                                                        pageIndex]
                                                                    .author!,
                                                                style: const TextStyle(
                                                                    fontStyle:
                                                                        FontStyle
                                                                            .italic,
                                                                    color: Colors
                                                                        .grey,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 0,
                                            ),
                                            listindex ==
                                                    (anywaaBook!
                                                            .chapters[pageIndex]
                                                            .verses
                                                            .length -
                                                        1)
                                                ? const Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 140),
                                                  )
                                                : const Visibility(
                                                    visible: false,
                                                    child: Text(''),
                                                  ),
                                          ],
                                        );
                                      }),
                                )
                          // }) // pageview
                          : englishBook == null
                              ? const Center(
                                  child: SpinKitWaveSpinner(
                                    color: Color.fromARGB(255, 13, 33, 65),
                                    size: 50.0,
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: ListView.builder(
                                      key: key,
                                      itemCount: englishBook!
                                          .chapters[pageIndex].verses.length,
                                      shrinkWrap: true,
                                      controller: controller,
                                      itemBuilder: (BuildContext context,
                                          int listindex) {
                                        var chapter = englishBook!
                                            .chapters[pageIndex]
                                            .verses[listindex];
                                        var chapterNumber = englishBook!
                                            .chapters[pageIndex].name
                                            .split(' ')[englishBook!
                                                .chapters[pageIndex].name
                                                .split(' ')
                                                .length -
                                            1];
                                        return Column(
                                          children: [
                                            // listindex == 0
                                            //     ? Text(
                                            //         title,
                                            //         style: const TextStyle(
                                            //             fontSize: 22,
                                            //             fontWeight:
                                            //                 FontWeight.bold,
                                            //             color: Colors.grey),
                                            //       )
                                            //     : const SizedBox(),
                                            Visibility(
                                              visible: listindex == 0,
                                              child: const SizedBox(
                                                height: 15,
                                              ),
                                            ),
                                            (englishBook!.chapters[pageIndex]
                                                        .title!.isNotEmpty &&
                                                    listindex == 0)
                                                ? Text(
                                                    '${englishBook!.chapters[pageIndex].title}',
                                                    style: const TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )
                                                : const Visibility(
                                                    visible: false,
                                                    child: Text(''),
                                                  ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Visibility(
                                                  visible: chapter.text != '' &&
                                                      chapter.id != '1',
                                                  child: Text(
                                                    chapter.id == '1'
                                                        ? chapterNumber
                                                        : chapter.id,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: chapter.id == '1'
                                                            ? const Color
                                                                .fromARGB(
                                                                255,
                                                                4,
                                                                74,
                                                                131,
                                                              )
                                                            : Colors.grey,
                                                        fontSize:
                                                            chapter.id == '1'
                                                                ? 57
                                                                : null),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Visibility(
                                                  visible: chapter.text != '',
                                                  child: Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            // print(_highlight);
                                                            currentBibleVerse =
                                                                '${englishBook!.chapters[pageIndex].id}${chapter.id}';
                                                            print(chapter.id);
                                                            print(listindex);

                                                            setState(() {
                                                              currentVerseIndex =
                                                                  int.parse(
                                                                      chapter
                                                                          .id);
                                                              selectedColorIndex =
                                                                  listindex;
                                                            });
                                                            print(
                                                                'current verse index: ${chapter.id}');

                                                            markText(
                                                                index:
                                                                    listindex,
                                                                chapterName:
                                                                    title,
                                                                text: chapter
                                                                    .text,
                                                                chapterNumber:
                                                                    chapterNumber,
                                                                chapterId:
                                                                    chapter.id,
                                                                textId:
                                                                    currentBibleVerse);
                                                          },
                                                          child: RichText(
                                                              text: TextSpan(
                                                                  style: DefaultTextStyle.of(
                                                                          context)
                                                                      .style,
                                                                  children: [
                                                                chapter.id ==
                                                                        '1'
                                                                    ? TextSpan(
                                                                        text:
                                                                            '$chapterNumber ',
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight
                                                                                .bold,
                                                                            color: chapter.id == '1'
                                                                                ? const Color.fromARGB(255, 255, 179, 0)
                                                                                : Colors.grey,
                                                                            fontSize: chapter.id == '1' ? 57 : null),
                                                                      )
                                                                    : const TextSpan(),
                                                                TextSpan(
                                                                  text: chapter
                                                                      .text,
                                                                  style:
                                                                      TextStyle(
                                                                    backgroundColor: _highlight
                                                                        .map((verse) => verse['id'] ==
                                                                                '${englishBook!.chapters[pageIndex].id}${chapter.id}'
                                                                            ? colorList[verse[
                                                                                'color']]
                                                                            : null)
                                                                        .firstWhere(
                                                                            (color) =>
                                                                                color !=
                                                                                null,
                                                                            orElse: () =>
                                                                                Colors.transparent),
                                                                    fontFamily:
                                                                        currentFont,
                                                                    fontSize:
                                                                        _currentFontSize,
                                                                    decoration: markedText.any((dic) =>
                                                                            dic['text'] ==
                                                                            chapter
                                                                                .text)
                                                                        ? TextDecoration
                                                                            .underline
                                                                        : null,
                                                                    decorationStyle: markedText.any((dic) =>
                                                                            dic['text'] ==
                                                                            chapter
                                                                                .text)
                                                                        ? TextDecorationStyle
                                                                            .dashed
                                                                        : null,
                                                                  ),
                                                                )
                                                              ])),
                                                        ),
                                                        Visibility(
                                                          visible: chapter
                                                                  .comment!
                                                                  .isNotEmpty &&
                                                              thereIsComment,
                                                          child: Text(
                                                            chapter.comment!
                                                                        .isNotEmpty &&
                                                                    thereIsComment
                                                                ? '${chapter.comment![0]}'
                                                                : '',
                                                            style: const TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 4.5,
                                            ),
                                            listindex ==
                                                    (englishBook!
                                                            .chapters[pageIndex]
                                                            .verses
                                                            .length -
                                                        1)
                                                ? const Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 140),
                                                  )
                                                : const Visibility(
                                                    visible: false,
                                                    child: Text(''),
                                                  ),
                                          ],
                                        );
                                      }),
                                )
                  : (_selectedIndex == 0 ? const DailyText() : const Account()),
              appBar: buildAppBar(),
              bottomNavigationBar: AnimatedContainer(
                height: isVisible
                    ? _selectedIndex == 1
                        ? 117
                        : 55
                    : 0,
                duration: const Duration(milliseconds: 0),
                child: Wrap(children: [
                  Visibility(
                    visible: _selectedIndex == 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 47,
                        // width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              isVisible
                                  ? IconButton(
                                      onPressed: () {
                                        if (pageIndex > 0) {
                                          setState(() {
                                            pageIndex--;
                                          });
                                          setPageIndex(index: pageIndex);
                                          getBibleVersion();
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.chevron_left_sharp,
                                        size: 39,
                                      ),
                                    )
                                  : const Visibility(
                                      visible: false,
                                      child: Text(''),
                                    ),
                              Visibility(
                                visible: _selectedIndex == 1 &&
                                    (_language == 'ANY' && bookIndex == 1),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Visibility(
                                      visible: _selectedIndex == 1,
                                      child: Visibility(
                                        child: IconButton(
                                          onPressed: () {
                                            playSong();
                                          },
                                          icon: Icon(
                                            player.playing
                                                ? Icons.pause_circle
                                                : Icons
                                                    .play_circle_filled_outlined,
                                            size: 37,
                                            color: const Color.fromARGB(
                                                255, 4, 74, 131),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    SizedBox(
                                      height: 20,
                                      width: 200,
                                      child: StreamBuilder<PositionData>(
                                          stream: _positionDataStream,
                                          builder: (context, snapshot) {
                                            final positionData = snapshot.data;
                                            return ProgressBar(
                                              bufferedBarColor: Colors.grey,
                                              barHeight: 5,
                                              baseBarColor:
                                                  const Color.fromARGB(
                                                      105, 158, 158, 158),
                                              progressBarColor:
                                                  const Color.fromARGB(
                                                      255, 79, 79, 79),
                                              timeLabelTextStyle:
                                                  const TextStyle(
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.w600),
                                              progress:
                                                  positionData?.position ??
                                                      Duration.zero,
                                              buffered: positionData
                                                      ?.bufferedPosition ??
                                                  Duration.zero,
                                              total: positionData?.duration ??
                                                  Duration.zero,
                                              onSeek: player.seek,
                                            );
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                              Visibility(
                                  visible: isVisible,
                                  child: IconButton(
                                    onPressed: () {
                                      if (pageIndex + 1 < pageLength) {
                                        setState(() {
                                          pageIndex++;
                                        });
                                        setPageIndex(index: pageIndex);
                                        getBibleVersion();
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.chevron_right,
                                      size: 39,
                                      // weight: 100,
                                    ),
                                  ))
                            ]),
                      ),
                    ),
                  ),
                  BottomNavigationBar(
                    useLegacyColorScheme: true,
                    elevation: 0,
                    items: <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: Icon(
                          currentTheme == Brightness.light
                              ? Icons.wb_sunny_outlined
                              : Icons.nights_stay_outlined,
                        ),
                        label: _language == 'AMH'
                            ? 'ዛሬ'
                            : _language == 'ANY'
                                ? 'Dïcängï'
                                : 'Today',
                      ),
                      BottomNavigationBarItem(
                          icon: const Icon(
                            Icons.menu_book_rounded,
                          ),
                          label: _language == 'AMH'
                              ? 'መጽሃፍ ቅዱስ'
                              : _language == 'ANY'
                                  ? 'Wëël Jwøk'
                                  : 'Bible'),
                      BottomNavigationBarItem(
                          icon: const Icon(
                            Icons.bookmark,
                          ),
                          label: _language == 'AMH'
                              ? 'ቡክማርክ'
                              : _language == 'ANY'
                                  ? 'Buk maak'
                                  : 'Bookmark'),
                    ],
                    currentIndex: _selectedIndex,
                    selectedItemColor: const Color.fromARGB(255, 255, 179, 0),
                    onTap: _onItemTapped,
                  ),
                ]),
              ),
              bottomSheet: markedText.isNotEmpty
                  ? Container(
                      height: 110,
                      width: double.infinity,
                      color: currentTheme == Brightness.dark
                          ? const Color.fromARGB(255, 0, 4, 17)
                          : Colors.white,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      addBookmark(markedText);
                                      setState(() {
                                        markedText = [];
                                      });
                                    },
                                    icon: const Icon(Icons.bookmark_add),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      copyVerse(markedText);
                                      setState(() {
                                        markedText = [];
                                      });
                                    },
                                    icon: const Icon(Icons.copy),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      print('the book index: $bookIndex');
                                      shareVerse(markedText);
                                      setState(() {
                                        markedText = [];
                                      });
                                    },
                                    icon: const Icon(Icons.share),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        markedText = [];
                                      });
                                      // Navigator.pushNamed(context, '/differentVerse',
                                      //     arguments: [
                                      //       {
                                      //         "pageIndex": pageIndex,
                                      //         "listIndex": currentVerseIndex,
                                      //         "title": title,
                                      //         'version': _currentVersion
                                      //       }
                                      //     ]);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DifferentVerse(
                                              title: title,
                                              pageIndex: pageIndex,
                                              listIndex: currentVerseIndex,
                                              version: _currentVersion),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.table_rows_outlined),
                                  ),
                                ],
                              ),

                              // SizedBox(
                              //   width: 10,
                              // ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      markedText = [];
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.cancel_outlined,
                                    color: Color.fromARGB(229, 238, 122, 113),
                                  ))
                            ],
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    if (markedText.length > 1) {
                                      for (Map currentMarkedText
                                          in markedText) {
                                        ColorHighlight.deleteItem(
                                            currentMarkedText['textId']);
                                      }
                                    } else {
                                      ColorHighlight.deleteItem(
                                          currentBibleVerse);
                                    }
                                    setState(() {
                                      markedText = [];
                                      refresher();
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: Colors.transparent,
                                    ),
                                    child: const Icon(
                                      Icons.cancel,
                                      size: 40,
                                      color: Color.fromARGB(207, 158, 158, 158),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                TextButton(
                                  onPressed: () {
                                    if (markedText.length > 1) {
                                      for (var currentMarkedText
                                          in markedText) {
                                        ColorHighlight.createItem(
                                            currentMarkedText['textId'], 0);
                                      }
                                    } else {
                                      ColorHighlight.createItem(
                                          currentBibleVerse, 0);
                                    }
                                    setState(() {
                                      markedText = [];
                                      refresher();
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: const Color.fromARGB(
                                          102, 244, 67, 54),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                TextButton(
                                  onPressed: () {
                                    if (markedText.length > 1) {
                                      for (var currentMarkedText
                                          in markedText) {
                                        ColorHighlight.createItem(
                                            currentMarkedText['textId'], 1);
                                      }
                                    } else {
                                      ColorHighlight.createItem(
                                          currentBibleVerse, 1);
                                    }
                                    setState(() {
                                      markedText = [];
                                      refresher();
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color:
                                          const Color.fromARGB(88, 233, 30, 98),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                TextButton(
                                  onPressed: () {
                                    if (markedText.length > 1) {
                                      for (var currentMarkedText
                                          in markedText) {
                                        ColorHighlight.createItem(
                                            currentMarkedText['textId'], 2);
                                      }
                                    } else {
                                      ColorHighlight.createItem(
                                          currentBibleVerse, 2);
                                    }
                                    setState(() {
                                      markedText = [];
                                      refresher();
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: const Color.fromARGB(
                                          93, 158, 158, 158),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                TextButton(
                                  onPressed: () {
                                    if (markedText.length > 1) {
                                      for (var currentMarkedText
                                          in markedText) {
                                        ColorHighlight.createItem(
                                            currentMarkedText['textId'], 3);
                                      }
                                    } else {
                                      ColorHighlight.createItem(
                                          currentBibleVerse, 3);
                                    }
                                    setState(() {
                                      markedText = [];
                                      refresher();
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color:
                                          const Color.fromARGB(99, 76, 175, 79),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                TextButton(
                                  onPressed: () {
                                    if (markedText.length > 1) {
                                      for (var currentMarkedText
                                          in markedText) {
                                        ColorHighlight.createItem(
                                            currentMarkedText['textId'], 4);
                                      }
                                    } else {
                                      ColorHighlight.createItem(
                                          currentBibleVerse, 4);
                                    }
                                    setState(() {
                                      markedText = [];
                                      refresher();
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: const Color.fromARGB(
                                          106, 79, 33, 243),
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    if (markedText.length > 1) {
                                      for (var currentMarkedText
                                          in markedText) {
                                        ColorHighlight.createItem(
                                            currentMarkedText['textId'], 5);
                                      }
                                    } else {
                                      ColorHighlight.createItem(
                                          currentBibleVerse, 5);
                                    }
                                    setState(() {
                                      markedText = [];
                                      refresher();
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: const Color.fromARGB(
                                          123, 159, 30, 233),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                TextButton(
                                  onPressed: () {
                                    if (markedText.length > 1) {
                                      for (var currentMarkedText
                                          in markedText) {
                                        ColorHighlight.createItem(
                                            currentMarkedText['textId'], 6);
                                      }
                                    } else {
                                      ColorHighlight.createItem(
                                          currentBibleVerse, 6);
                                    }
                                    setState(() {
                                      markedText = [];
                                      refresher();
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: const Color.fromARGB(
                                          113, 30, 142, 233),
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    if (markedText.length > 1) {
                                      for (var currentMarkedText
                                          in markedText) {
                                        ColorHighlight.createItem(
                                            currentMarkedText['textId'], 7);
                                      }
                                    } else {
                                      ColorHighlight.createItem(
                                          currentBibleVerse, 7);
                                    }
                                    setState(() {
                                      markedText = [];
                                      refresher();
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: const Color.fromARGB(
                                          125, 255, 153, 0),
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    if (markedText.length > 1) {
                                      for (var currentMarkedText
                                          in markedText) {
                                        ColorHighlight.createItem(
                                            currentMarkedText['textId'], 8);
                                      }
                                    } else {
                                      ColorHighlight.createItem(
                                          currentBibleVerse, 8);
                                    }
                                    setState(() {
                                      markedText = [];
                                      refresher();
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: const Color.fromARGB(
                                          146, 255, 193, 7),
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    if (markedText.length > 1) {
                                      for (var currentMarkedText
                                          in markedText) {
                                        ColorHighlight.createItem(
                                            currentMarkedText['textId'], 9);
                                      }
                                    } else {
                                      ColorHighlight.createItem(
                                          currentBibleVerse, 9);
                                    }
                                    setState(() {
                                      markedText = [];
                                      refresher();
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: const Color.fromARGB(
                                          84, 130, 243, 134),
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    if (markedText.length > 1) {
                                      for (var currentMarkedText
                                          in markedText) {
                                        ColorHighlight.createItem(
                                            currentMarkedText['textId'], 10);
                                      }
                                    } else {
                                      ColorHighlight.createItem(
                                          currentBibleVerse, 10);
                                    }
                                    setState(() {
                                      markedText = [];
                                      refresher();
                                    });
                                  },
                                  child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          color: const Color.fromARGB(
                                              94, 201, 125, 245))),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  : null,
            );
          } catch (e) {
            print(e);
            return const Center(
              child: SpinKitWaveSpinner(
                color: Color.fromARGB(255, 13, 33, 65),
                size: 50.0,
              ),
            );
          }
        });
  }
}
