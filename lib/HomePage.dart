import 'dart:convert';

import 'package:dha_anywaa_bible/components/Book.dart';
import 'package:dha_anywaa_bible/components/account.dart';
import 'package:dha_anywaa_bible/components/chapter_list.dart';

import 'package:dha_anywaa_bible/classes/SQLHelper.dart';
import 'package:dha_anywaa_bible/classes/color_highlight.dart';
import 'package:dha_anywaa_bible/classes/dailyText.dart';
import 'package:dha_anywaa_bible/classes/font_size.dart';
import 'package:dha_anywaa_bible/classes/font_style.dart';
import 'package:dha_anywaa_bible/classes/highlights.dart';
import 'package:dha_anywaa_bible/components/daily_text.dart';
import 'package:dha_anywaa_bible/components/differentVerse.dart';
import 'package:dha_anywaa_bible/components/pray.dart';
import 'package:dha_anywaa_bible/components/setting.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:share_plus/share_plus.dart';

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
        title = englishBook!.name;
      });
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
        title = anywaaBook!.chapters[pageIndex].name;
      });
    } catch (e) {
      print('dha anywaa problem ghgh');
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
      });
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
  void getFontSize() async {
    var fontsize = await fontSize.getFontSize();
    var fontStyle = await style.getFontStyle();
    setState(() {
      _currentFontSize = fontsize;
      currentFont = fontStyle;
    });
  }

  void getBibleVersion({bool? fromChoosing}) async {
    bibleVersion = await style.getBibleVersion();
    final language = await style.getLanguageVersion();
    int currentPage = await style.getPage();
    if (fromChoosing == true) {
      pageController.jumpToPage(currentPage);
    }

    if (language.split(' ')[0] == 'AMH') {
      setState(() {
        amhBibleVersion = bibleVersion;
        // print(amhBibleVersion);
        amharicJsonString = 'assets/holybooks/AM/$amhBibleVersion';
      });
      amhLoadData();
    } else if (language.split(' ')[0] == 'ANY') {
      setState(() {
        anywaaJsonString = 'assets/holybooks/$bibleVersion';
      });
      anywaaLoadData();
    } else {
      {
        setState(() {
          englishJsonString = 'assets/holybooks/$bibleVersion';
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
    pageController = PageController(initialPage: mypage);

    print('the page index: $pageIndex');
  }

  Future<void> refresher() async {
    final highlight = await ColorHighlight.gethighlight();
    setState(() {
      _highlight = highlight;
    });
  }

  @override
  void initState() {
    refresher();
    super.initState();
    controller.addListener(listen);
    info();
    getBibleVersion();
  }

  Color selectedColor = Colors.blue;
  late PageController pageController;

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
      getBibleVersion();
    });
  }

  ColorHighlight colorHighlight = ColorHighlight();
  ScrollController controller = ScrollController();
  ScrollController mycontroller = ScrollController();
  bool isVisible = true;
  SelectedFontStyle selectedFontStyle = SelectedFontStyle();
  UniqueKey key = UniqueKey();

  @override
  void dispose() {
    // TODO: implement dispose
    controller.removeListener(listen);
    controller.dispose();
    pageController.dispose();
    super.dispose();
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
  bool atEnd = false;
  bool atBeggining = false;
  bool thereIsComment = true;
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
    // if (fromChoosing != null) {
    if (fromChoosing != null) {
      print('from choosing');
    } else if (fromChoosing == null) {
      style.setPage(index);
      print('from just changing');
      // }
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
                      } catch (e) {
                        print('Error sharing the verse: $e');
                      }
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
            title: TextButton(
                onPressed: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Pray()),
                    );
                  });
                },
                child: Text(
                  _language == 'AMH'
                      ? 'ፀልይ'
                      : _language == 'ANY'
                          ? 'Lämï'
                          : 'Pray',
                  style: TextStyle(
                    fontSize: 20.5,
                    color: currentTheme == Brightness.light
                        ? const Color.fromARGB(255, 1, 11, 36)
                        : const Color.fromARGB(255, 243, 179, 83),
                  ),
                )),
            forceMaterialTransparency: true,
          );
        case 1:
          return AppBar(forceMaterialTransparency: true, actions: [
            _language == 'ERV' || _language == 'ANY'
                ? IconButton(
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
                  )
                : const Visibility(visible: false, child: Text('')),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/chooseBible').then((_) {
                  languageVerson();
                  getBibleVersion();
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
            IconButton(
              icon: const Icon(
                Icons.search,
                color: Color.fromARGB(255, 227, 171, 2),
              ),
              onPressed: () {},
            ),
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

    return Scaffold(
      drawer: _selectedIndex == 2
          ? Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const DrawerHeader(
                    child: Text(''),
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
                          print(value);
                        });
                      });
                    },
                    title: const Text(
                      'Settings',
                    ),
                  ),
                  const ListTile(
                    leading: Icon(Icons.share),
                    title: Text(
                      'Share',
                      style: TextStyle(),
                    ),
                  ),
                  const ListTile(
                    leading: Icon(Icons.help_outline),
                    title: Text(
                      'Get help',
                      style: TextStyle(),
                    ),
                  ),
                  const ListTile(
                    leading: Icon(Icons.attribution_outlined),
                    title: Text(
                      'About the app',
                      style: TextStyle(),
                    ),
                  ),
                  const ListTile(
                    leading: Icon(
                      Icons.menu_book_rounded,
                    ),
                    title: Text(
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
                  : PageView.builder(
                      key: key,
                      controller: pageController,
                      onPageChanged: (index) {
                        setPageIndex(index: index);
                        print('onPageChanged');
                        setState(() {
                          getBibleVersion();
                          if (amharicBook!.chapters.length - 1 == index) {
                            atEnd = true;
                            // print('end');
                          } else if (index == 0) {
                            // print('beginning');
                            atBeggining = true;
                          } else {
                            atEnd = false;
                            atBeggining = false;
                          }
                        });
                      },
                      itemCount: amharicBook!.chapters.length,
                      itemBuilder: (BuildContext context, int pageIndex) {
                        var amhbook = amharicBook!.chapters[pageIndex];

                        return Padding(
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
                                var nextAmhChapter = amhchapters;
                                if (amhbook.verses.length - 1 > listIndex) {
                                  nextAmhChapter = amharicBook!
                                      .chapters[pageIndex]
                                      .verses[listIndex + 1];
                                }
                                return Column(
                                  children: [
                                    listIndex == 0
                                        ? Text(
                                            amharicBook!.title,
                                            style: const TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey),
                                          )
                                        : const Visibility(
                                            visible: false, child: Text('')),
                                    listIndex == 0
                                        ? Text(
                                            amhbook.chapter,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 72),
                                          )
                                        : const Visibility(
                                            visible: false,
                                            child: Text('data')),
                                    Padding(
                                      padding: amhbook.verses.length - 1 ==
                                              listIndex
                                          ? const EdgeInsets.only(bottom: 80)
                                          : EdgeInsets.zero,
                                      child: GestureDetector(
                                        onTap: () {
                                          currentBibleVerse = amhchapters;
                                          currentVerseIndex = listIndex;
                                          markText(
                                              index: listIndex,
                                              chapterName: amharicBook!.title,
                                              text: amhchapters,
                                              chapterNumber: amhbook.chapter,
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
                                                : Text(
                                                    '${listIndex + 1}  ',
                                                    style: TextStyle(
                                                        fontFamily: currentFont,
                                                        fontSize:
                                                            _currentFontSize,
                                                        color: Colors.grey),
                                                  ),
                                            amhchapters == '' ||
                                                    amhchapters == '-'
                                                ? const Visibility(
                                                    visible: false,
                                                    child: Text(''))
                                                : Expanded(
                                                    child: RichText(
                                                      text: TextSpan(
                                                        style:
                                                            DefaultTextStyle.of(
                                                                    context)
                                                                .style,
                                                        children: [
                                                          TextSpan(
                                                            text: amhchapters,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  currentFont,
                                                              fontSize:
                                                                  _currentFontSize,
                                                              backgroundColor: _highlight
                                                                  .map((verse) => verse[
                                                                              'id'] ==
                                                                          amhchapters
                                                                      ? colorList[
                                                                          verse[
                                                                              'color']]
                                                                      : null)
                                                                  .firstWhere(
                                                                      (color) =>
                                                                          color !=
                                                                          null,
                                                                      orElse: () =>
                                                                          Colors
                                                                              .transparent),
                                                              decoration: markedText
                                                                      .any((dic) =>
                                                                          dic['text'] ==
                                                                          amhchapters)
                                                                  ? TextDecoration
                                                                      .underline
                                                                  : null,
                                                              decorationStyle: markedText
                                                                      .any((dic) =>
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
                        );
                      })
              : (anywaaBook == null && englishBook == null)
                  ? const Center(
                      child: SpinKitWaveSpinner(
                        color: Color.fromARGB(255, 13, 33, 65),
                        size: 50.0,
                      ),
                    )
                  : _language == 'ANY'
                      ? anywaaBook == null
                          ? const Center(
                              child: SpinKitWaveSpinner(
                                color: Color.fromARGB(255, 13, 33, 65),
                                size: 50.0,
                              ),
                            )
                          : PageView.builder(
                              key: key,
                              onPageChanged: (index) {
                                setPageIndex(index: index);
                                print('onPageChanged 2');
                                markedText = [];
                                setState(() {
                                  getBibleVersion();
                                });
                              },
                              itemCount: anywaaBook!.chapters.length,
                              controller: pageController,
                              itemBuilder: (BuildContext context, int index) {
                                var book = anywaaBook!.chapters[index];
                                return Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: ListView.builder(
                                      key: key,
                                      itemCount: book.verses.length,
                                      shrinkWrap: true,
                                      controller: controller,
                                      itemBuilder: (BuildContext context,
                                          int listindex) {
                                        var chapter = book.verses[listindex];
                                        var chapterNumber = book.name
                                                .split(' ')[
                                            book.name.split(' ').length - 1];
                                        String first =
                                            book.name.split(' ').length > 2
                                                ? book.name.split(' ')[0]
                                                : '';
                                        print(book.name.split(' '));
                                        var chapterName =
                                            '$first ${book.name.split(' ')[book.name.split(' ').length - 2]}';
                                        return Column(
                                          children: [
                                            listindex == 0
                                                ? Text(
                                                    chapterName,
                                                    style: const TextStyle(
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.grey),
                                                  )
                                                : const SizedBox(),
                                            Visibility(
                                                visible: listindex == 0,
                                                child: Text(
                                                  chapterNumber,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 72),
                                                )),
                                            listindex == 0
                                                ? const SizedBox(
                                                    height: 20,
                                                  )
                                                : const Visibility(
                                                    visible: false,
                                                    child: Text('')),
                                            (book.verses[listindex].title!
                                                    .isNotEmpty)
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 30,
                                                            right: 30,
                                                            bottom: 6),
                                                    child: Text(
                                                      '\n${book.verses[listindex].title}',
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
                                                  visible: book
                                                      .verses[listindex]
                                                      .reference!
                                                      .isNotEmpty,
                                                  child: Text(
                                                    '${book.verses[listindex].reference}',
                                                    style: const TextStyle(
                                                        fontSize: 15.5,
                                                        color: Colors.grey),
                                                  )),
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                chapter.text != ''
                                                    ? Text(
                                                        chapter.id,
                                                        style: const TextStyle(
                                                            color: Colors.grey),
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
                                                                '${book.id}${chapter.id}';

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
                                                                TextSpan(
                                                                  text: chapter
                                                                      .text,
                                                                  style:
                                                                      TextStyle(
                                                                    backgroundColor: _highlight
                                                                        .map((verse) => verse['id'] ==
                                                                                '${book.id}${chapter.id}'
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
                                                            '${chapter.comment}',
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
                                              height: 0,
                                            ),
                                            listindex ==
                                                    (book.verses.length - 1)
                                                ? const Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 100),
                                                  )
                                                : const Visibility(
                                                    visible: false,
                                                    child: Text(''),
                                                  ),
                                          ],
                                        );
                                      }),
                                );
                              })
                      : PageView.builder(
                          key: key,
                          onPageChanged: (index) {
                            setPageIndex(index: index);

                            print('onpagechanged 3 $index');
                            markedText = [];
                            setState(() {
                              getBibleVersion();
                            });
                          },
                          itemCount: englishBook!.chapters.length,
                          controller: pageController,
                          itemBuilder: (BuildContext context, int index) {
                            var book = englishBook!.chapters[index];
                            return Padding(
                              padding: const EdgeInsets.all(10),
                              child: ListView.builder(
                                  key: key,
                                  itemCount: book.verses.length,
                                  shrinkWrap: true,
                                  controller: controller,
                                  itemBuilder:
                                      (BuildContext context, int listindex) {
                                    var chapter = book.verses[listindex];
                                    var chapterNumber = book.name.split(
                                        ' ')[book.name.split(' ').length - 1];
                                    String first =
                                        book.name.split(' ').length > 2
                                            ? book.name.split(' ')[0]
                                            : '';
                                    var chapterName =
                                        '$first ${book.name.split(' ')[book.name.split(' ').length - 2]}';
                                    return Column(
                                      children: [
                                        listindex == 0
                                            ? Text(
                                                chapterName,
                                                style: const TextStyle(
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey),
                                              )
                                            : const SizedBox(),
                                        listindex == 0
                                            ? Text(
                                                chapterNumber,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 72),
                                              )
                                            : const Visibility(
                                                visible: false,
                                                child: Text('')),
                                        listindex == 0
                                            ? const SizedBox(
                                                height: 20,
                                              )
                                            : const Visibility(
                                                visible: false,
                                                child: Text('')),
                                        (book.title!.isNotEmpty &&
                                                listindex == 0)
                                            ? Text(
                                                '${book.title}\n',
                                                style: const TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
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
                                            chapter.text != ''
                                                ? Text(
                                                    chapter.id,
                                                    style: const TextStyle(
                                                        color: Colors.grey),
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
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        // print(_highlight);
                                                        currentBibleVerse =
                                                            '${book.id}${chapter.id}';
                                                        print(chapter.id);
                                                        print(listindex);

                                                        setState(() {
                                                          currentVerseIndex =
                                                              int.parse(
                                                                  chapter.id);
                                                          selectedColorIndex =
                                                              listindex;
                                                        });
                                                        print(
                                                            'current verse index: ${chapter.id}');

                                                        markText(
                                                            index: listindex,
                                                            chapterName:
                                                                chapterName,
                                                            text: chapter.text,
                                                            chapterNumber:
                                                                chapterNumber,
                                                            chapterId:
                                                                chapter.id,
                                                            textId:
                                                                currentBibleVerse);
                                                      },
                                                      child: RichText(
                                                          text: TextSpan(
                                                              style: DefaultTextStyle
                                                                      .of(context)
                                                                  .style,
                                                              children: [
                                                            TextSpan(
                                                              text:
                                                                  chapter.text,
                                                              style: TextStyle(
                                                                backgroundColor: _highlight
                                                                    .map((verse) => verse['id'] ==
                                                                            '${book.id}${chapter.id}'
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
                                                      visible: chapter.comment!
                                                              .isNotEmpty &&
                                                          thereIsComment,
                                                      child: Text(
                                                        chapter.comment!
                                                                    .isNotEmpty &&
                                                                thereIsComment
                                                            ? '${chapter.comment![0]}'
                                                            : '',
                                                        style: const TextStyle(
                                                            color: Colors.grey,
                                                            fontStyle: FontStyle
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
                                        listindex == (book.verses.length - 1)
                                            ? const Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 100),
                                              )
                                            : const Visibility(
                                                visible: false,
                                                child: Text(''),
                                              ),
                                      ],
                                    );
                                  }),
                            );
                          })
          : (_selectedIndex == 0 ? const DailyText() : const Account()),
      appBar: buildAppBar(),
      bottomNavigationBar: AnimatedContainer(
        height: isVisible
            ? _selectedIndex == 1
                ? 129
                : 53
            : 53,
        duration: const Duration(milliseconds: 0),
        child: Wrap(children: [
          Visibility(
            visible: _selectedIndex == 1,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: !isVisible
                      ? Colors.transparent
                      : const Color.fromARGB(125, 71, 68, 68),
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      isVisible
                          ? IconButton(
                              onPressed: () {
                                pageController.previousPage(
                                    duration: const Duration(microseconds: 1),
                                    curve: Curves.linear);
                              },
                              icon: const Icon(
                                Icons.chevron_left_sharp,
                                size: 40,
                              ),
                            )
                          : const Visibility(visible: false, child: Text('')),
                      TextButton(
                        onPressed: () async {
                          var refresh = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChapterList()))
                              .then((value) {
                            print('the value from choosing: $value');
                          });

                          if (refresh != null) {
                            // setState(() {
                            //   mypage = refresh;
                            // });

                            // pageController.jumpToPage(mypage);
                            setPageIndex(index: mypage, fromChoosing: true);
                          }
                          getBibleVersion(fromChoosing: true);
                          print('the page index from: $mypage');
                        },
                        child: Text(
                          title,
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: currentTheme == Brightness.dark
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                      Visibility(
                          visible: isVisible,
                          child: IconButton(
                            onPressed: () {
                              pageController.nextPage(
                                  duration: const Duration(microseconds: 1),
                                  curve: Curves.linear);
                            },
                            icon: const Icon(
                              Icons.chevron_right,
                              size: 40,
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
            selectedItemColor: const Color.fromARGB(255, 227, 171, 2),
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
                              for (Map currentMarkedText in markedText) {
                                ColorHighlight.deleteItem(
                                    currentMarkedText['textId']);
                              }
                            } else {
                              ColorHighlight.deleteItem(currentBibleVerse);
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
                              for (var currentMarkedText in markedText) {
                                ColorHighlight.createItem(
                                    currentMarkedText['textId'], 0);
                              }
                            } else {
                              ColorHighlight.createItem(currentBibleVerse, 0);
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
                              color: const Color.fromARGB(102, 244, 67, 54),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        TextButton(
                          onPressed: () {
                            if (markedText.length > 1) {
                              for (var currentMarkedText in markedText) {
                                ColorHighlight.createItem(
                                    currentMarkedText['textId'], 1);
                              }
                            } else {
                              ColorHighlight.createItem(currentBibleVerse, 1);
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
                              color: const Color.fromARGB(88, 233, 30, 98),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        TextButton(
                          onPressed: () {
                            if (markedText.length > 1) {
                              for (var currentMarkedText in markedText) {
                                ColorHighlight.createItem(
                                    currentMarkedText['textId'], 2);
                              }
                            } else {
                              ColorHighlight.createItem(currentBibleVerse, 2);
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
                              color: const Color.fromARGB(93, 158, 158, 158),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        TextButton(
                          onPressed: () {
                            if (markedText.length > 1) {
                              for (var currentMarkedText in markedText) {
                                ColorHighlight.createItem(
                                    currentMarkedText['textId'], 3);
                              }
                            } else {
                              ColorHighlight.createItem(currentBibleVerse, 3);
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
                              color: const Color.fromARGB(99, 76, 175, 79),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        TextButton(
                          onPressed: () {
                            if (markedText.length > 1) {
                              for (var currentMarkedText in markedText) {
                                ColorHighlight.createItem(
                                    currentMarkedText['textId'], 4);
                              }
                            } else {
                              ColorHighlight.createItem(currentBibleVerse, 4);
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
                              color: const Color.fromARGB(106, 79, 33, 243),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            if (markedText.length > 1) {
                              for (var currentMarkedText in markedText) {
                                ColorHighlight.createItem(
                                    currentMarkedText['textId'], 5);
                              }
                            } else {
                              ColorHighlight.createItem(currentBibleVerse, 5);
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
                              color: const Color.fromARGB(123, 159, 30, 233),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        TextButton(
                          onPressed: () {
                            if (markedText.length > 1) {
                              for (var currentMarkedText in markedText) {
                                ColorHighlight.createItem(
                                    currentMarkedText['textId'], 6);
                              }
                            } else {
                              ColorHighlight.createItem(currentBibleVerse, 6);
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
                              color: const Color.fromARGB(113, 30, 142, 233),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            if (markedText.length > 1) {
                              for (var currentMarkedText in markedText) {
                                ColorHighlight.createItem(
                                    currentMarkedText['textId'], 7);
                              }
                            } else {
                              ColorHighlight.createItem(currentBibleVerse, 7);
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
                              color: const Color.fromARGB(125, 255, 153, 0),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            if (markedText.length > 1) {
                              for (var currentMarkedText in markedText) {
                                ColorHighlight.createItem(
                                    currentMarkedText['textId'], 8);
                              }
                            } else {
                              ColorHighlight.createItem(currentBibleVerse, 8);
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
                              color: const Color.fromARGB(146, 255, 193, 7),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            if (markedText.length > 1) {
                              for (var currentMarkedText in markedText) {
                                ColorHighlight.createItem(
                                    currentMarkedText['textId'], 9);
                              }
                            } else {
                              ColorHighlight.createItem(currentBibleVerse, 9);
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
                              color: const Color.fromARGB(84, 130, 243, 134),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            if (markedText.length > 1) {
                              for (var currentMarkedText in markedText) {
                                ColorHighlight.createItem(
                                    currentMarkedText['textId'], 10);
                              }
                            } else {
                              ColorHighlight.createItem(currentBibleVerse, 10);
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
                                      const Color.fromARGB(94, 201, 125, 245))),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          : null,
    );
  }
}
