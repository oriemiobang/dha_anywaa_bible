// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, unnecessary_brace_in_string_interps

// import 'package:dha_anywaa_bible/main.dart';
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
import 'package:dha_anywaa_bible/components/setting.dart';
import 'package:flutter/foundation.dart';
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
  String amharicJsonString = 'assets/holybooks/AM/$amhBibleVersion';
  Future<String> _loadData() async {
    return await rootBundle.loadString(myjsonString);
  }

  Future<String> _engLoadData() async {
    return await rootBundle.loadString(englishJsonString);
  }

  Future<String> _amhLoadData() async {
    return await rootBundle.loadString(amharicJsonString);
  }

  Book? book;
  EnglishBook? englishBook;
  AmharicChapters? amharicBook;

  Future loadData() async {
    try {
      String jsonString = await _loadData();
      final jsonResponse = json.decode(jsonString);
      setState(() {
        book = Book.fromJson(jsonResponse);
      });
    } catch (e) {
      print(e);
    }
  }

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

  Future amhLoadData() async {
    try {
      String amhJsonString = await _amhLoadData();
      final amhJsonResponse = json.decode(amhJsonString);
      setState(() {
        amharicBook = AmharicChapters.fromJson(amhJsonResponse);
        title = amharicBook!.title;
        // print('${amharicBook.chapters[0].verses[1]}');
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
    print('my font size $fontsize');
    print('my font fontStyle $fontStyle');
    setState(() {
      _currentFontSize = fontsize;
      currentFont = fontStyle;
    });
  }

  void getBibleVersion() async {
    bibleVersion = await style.getBibleVersion();
    final language = await style.getLanguageVersion();
    int currentPage = await style.getPage();

    if (language.split(' ')[0] == 'AMH') {
      setState(() {
        amhBibleVersion = bibleVersion;
        print(amhBibleVersion);
        amharicJsonString = 'assets/holybooks/AM/$amhBibleVersion';
        amhLoadData();
      });
    } else {
      setState(() {
        englishJsonString = 'assets/holybooks/$bibleVersion';

        engLoadData();
      });
    }

    setState(() {
      pageIndex = currentPage;
      getFontSize();
      languageVerson();
      _language = language.split(' ')[0];
      mypage = currentPage;
      pageController = PageController(initialPage: mypage);
    });
  }

  Future<void> refresher() async {
    final highlight = await ColorHighlight.gethighlight();
    setState(() {
      print(highlight);
      _highlight = highlight;
    });
  }

  @override
  void initState() {
    refresher();
    super.initState();
    controller.addListener(listen);
    print('we are back');
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
      // print(controller.position.atEdge);

      show();
    } else if (direction == ScrollDirection.reverse) {
      // print(controller.position.atEdge);
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
  List markedText = [];
  List<Map<String, dynamic>> _highlight = [];
  List<Color> colorList = [
    const Color.fromARGB(175, 255, 193, 7),
    Color.fromARGB(158, 76, 175, 79),
    Color.fromARGB(174, 244, 67, 54),
    Color.fromARGB(158, 30, 142, 233),
    Color.fromARGB(150, 159, 30, 233),
  ];

  Future<int> _getItem() async {
    final item = await SQLHelper.getItem(1);
    // print('inner index: $item');
    return item[0]['counter'];
  }

  void info() async {
    try {
      int myIndex = await _getItem();
      // print('my index: $myIndex');
      currentText = dailyText.dailyVerseList[myIndex]['text']!;
      currentVerse = dailyText.dailyVerseList[myIndex]['verse']!;
      // setState(() {});
    } catch (e) {
      print('error: $e');
    }
  }

  String _currentVersion = '';

  void languageVerson() async {
    final currentVersion = await selectedFontStyle.getLanguageVersion();
    setState(() {
      _currentVersion = currentVersion.split(' ')[0];
      ;
    });
  }

  void markText({index, chapterName, chapterNumber, chapterId, text}) {
    Map currentDict = {
      "chapterId": chapterId,
      "chapterName": chapterName,
      "chapterNumber": chapterNumber,
      "text": text
    };
    isExist = markedText.any((dic) => mapEquals(dic, currentDict));
    print(isExist);
    setState(() {
      if (isExist) {
        // markedText.remove(index);
        markedText.removeWhere((element) => element['text'] == '$text');
      } else {
        // markedText.add(index);
        markedText.add({
          "chapterId": chapterId,
          "chapterName": chapterName,
          "chapterNumber": chapterNumber,
          "text": text
        });
      }

      print(markedText);
    });
  }

  void addBookmark(bookmarks) {
    Highlight.createItem(bookmarks[0]['text'],
        '${bookmarks[0]['chapterName']} ${bookmarks[0]['chapterNumber']}: ${bookmarks[0]['chapterId']}');

    Fluttertoast.showToast(
        msg: "Bookmark added",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Color.fromARGB(255, 0, 4, 17),
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void copyVerse(markedText) {
    Clipboard.setData(ClipboardData(text: markedText[0]['text']));

    Fluttertoast.showToast(
        msg: "Text copied!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Color.fromARGB(255, 0, 4, 17),
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void shareVerse(markedText) {
    Share.share(
        "${markedText[0]['text']}\n ${markedText[0]['chapterName']} ${markedText[0]['chapterNumber']}: ${markedText[0]['chapterId']}}");
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
                      ? Color.fromARGB(255, 231, 235, 254)
                      : Color.fromARGB(162, 95, 90, 74),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: IconButton(
                    onPressed: () async {
                      try {
                        await Share.share('$currentVerse \n $currentText');
                      } catch (e) {
                        print('yeah an error: $e');
                      }
                    },
                    icon: Icon(
                      Icons.share,
                      color: currentTheme == Brightness.light
                          ? Color.fromARGB(255, 1, 17, 57)
                          : Colors.amber,
                    ),
                  ),
                ),
              )
            ],
            // backgroundColor: Colors.transparent,
            title: Text(
              _language == 'AMH'
                  ? ''
                  : _language == 'ANY'
                      ? 'Dïcängï'
                      : 'Today',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            forceMaterialTransparency: true,
          );
        case 1:
          return AppBar(forceMaterialTransparency: true, actions: [
            _language == 'ERV'
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        thereIsComment = !thereIsComment;
                      });
                    },
                    icon: thereIsComment
                        ? Icon(
                            Icons.comment,
                            size: 18,
                          )
                        : Icon(
                            Icons.comments_disabled,
                            size: 18,
                          ),
                  )
                : Visibility(visible: false, child: Text('')),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/chooseBible').then((_) {
                  setState(() {
                    languageVerson();

                    getBibleVersion();
                  });
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
              icon: Icon(
                Icons.search,
                color: const Color.fromARGB(255, 227, 171, 2),
              ),
              onPressed: () {},
            ),
          ]);
        case 2:
          return AppBar(
            title: Text(
              'Highlights',
              style: TextStyle(),
            ),
            forceMaterialTransparency: true,
          );
        default:
          return AppBar(
            title: Text('Flutter Navigation Example'),
          );
      }
    }

    return Scaffold(
      drawer: _selectedIndex == 2
          ? Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    child: Text(''),
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    onTap: () {
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Setting()),
                        ).then((value) {
                          getBibleVersion();
                          print(value);
                        });
                      });
                    },
                    title: Text(
                      'Settings',
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.share),
                    title: Text(
                      'Share',
                      style: TextStyle(),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.help_outline),
                    title: Text(
                      'Get help',
                      style: TextStyle(),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.attribution_outlined),
                    title: Text(
                      'About the app',
                      style: TextStyle(),
                    ),
                  ),
                  ListTile(
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
                  ? Center(
                      child: SpinKitWaveSpinner(
                        color: const Color.fromARGB(255, 13, 33, 65),
                        size: 50.0,
                      ),
                    )
                  : PageView.builder(
                      key: key,
                      controller: pageController,
                      onPageChanged: (index) {
                        style.setPage(index);
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
                                return Container(
                                  child: Column(
                                    children: [
                                      listIndex == 0
                                          ? Text(
                                              amharicBook!.title,
                                              style: const TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey),
                                            )
                                          : Visibility(
                                              visible: false, child: Text('')),
                                      listIndex == 0
                                          ? Text(
                                              amhbook.chapter,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 72),
                                            )
                                          : Visibility(
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
                                                chapterId: listIndex + 1);
                                          },
                                          child: RichText(
                                            text: TextSpan(
                                              style:
                                                  DefaultTextStyle.of(context)
                                                      .style,
                                              children: [
                                                TextSpan(
                                                  text: nextAmhChapter == '' &&
                                                              amhchapters !=
                                                                  '' ||
                                                          nextAmhChapter == '-'
                                                      ? '${listIndex + 1} - ${listIndex + 2}  '
                                                      : amhchapters != '' &&
                                                              amhchapters != '-'
                                                          ? '${listIndex + 1}  '
                                                          : '',
                                                  style: TextStyle(
                                                      fontFamily: currentFont,
                                                      fontSize:
                                                          _currentFontSize,
                                                      color: Colors.grey),
                                                ),
                                                amhchapters != '' &&
                                                        amhchapters != '-'
                                                    ? TextSpan(
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
                                                                            .transparent)),
                                                      )
                                                    : TextSpan(),
                                                // amhchapters == ''
                                                //     ? TextSpan(
                                                //         text:
                                                //             '${listIndex + 1}',
                                                //         style: TextStyle(
                                                //             fontFamily:
                                                //                 currentFont,
                                                //             color: Colors.grey,
                                                //             fontSize:
                                                //                 _currentFontSize),
                                                //       )
                                                // : TextSpan(
                                                //     text: '',
                                                //     style: TextStyle(
                                                //         fontFamily:
                                                //             currentFont,
                                                //         color: Colors.grey,
                                                //         fontSize:
                                                //             _currentFontSize),
                                                //   ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 7,
                                      )
                                    ],
                                  ),
                                );
                              }),
                        );
                      })
              : englishBook == null
                  ? Center(
                      child: SpinKitWaveSpinner(
                        color: const Color.fromARGB(255, 13, 33, 65),
                        size: 50.0,
                      ),
                    )
                  : PageView.builder(
                      key: key,
                      onPageChanged: (index) {
                        style.setPage(index);
                        setState(() {
                          getBibleVersion();

                          // if (englishBook!.chapters.length - 1 == index) {
                          //   atEnd = true;
                          //   print('end');
                          // } else if (index == 0) {
                          //   print('beginning');
                          //   atBeggining = true;
                          // } else {
                          //   atEnd = false;
                          //   atBeggining = false;
                          // }
                        });
                      },
                      // scrollBehavior: const ScrollBehavior(),
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
                              // physics: ScrollPhysics(),
                              itemBuilder:
                                  (BuildContext context, int listindex) {
                                var chapter = book.verses[listindex];
                                var chapterNumber = book.name.split(
                                    ' ')[book.name.split(' ').length - 1];
                                String first = book.name.split(' ').length > 2
                                    ? book.name.split(' ')[0]
                                    : '';
                                print(book.name.split(' '));
                                var chapterName =
                                    '$first ${book.name.split(' ')[book.name.split(' ').length - 2]}';
                                return Container(
                                  child: Column(
                                    children: [
                                      listindex == 0
                                          ? Text(
                                              chapterName,
                                              style: const TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey),
                                            )
                                          : SizedBox(),
                                      listindex == 0
                                          ? Text(
                                              chapterNumber,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 72),
                                            )
                                          : const Visibility(
                                              visible: false, child: Text('')),
                                      listindex == 0
                                          ? SizedBox(
                                              height: 20,
                                            )
                                          : const Visibility(
                                              visible: false, child: Text('')),
                                      (book.title!.isNotEmpty && listindex == 0)
                                          ? Text(
                                              '${book.title}\n',
                                              style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          : Visibility(
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
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                )
                                              : const Visibility(
                                                  visible: false,
                                                  child: Text('')),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          chapter.text != ''
                                              ? Expanded(
                                                  child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        // print(_highlight);
                                                        currentBibleVerse =
                                                            '${book.id}${chapter.id}';
                                                        print(_highlight);
                                                        currentVerseIndex =
                                                            listindex;
                                                        selectedColorIndex =
                                                            listindex;
                                                        markText(
                                                            index: listindex,
                                                            chapterName:
                                                                chapterName,
                                                            text: chapter.text,
                                                            chapterNumber:
                                                                chapterNumber,
                                                            chapterId:
                                                                chapter.id);
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
                                                                          orElse: () => Colors
                                                                              .transparent),
                                                                  fontFamily:
                                                                      currentFont,
                                                                  fontSize:
                                                                      _currentFontSize,
                                                                  decoration: isExist
                                                                      ? TextDecoration
                                                                          .underline
                                                                      : null,
                                                                  decorationStyle: isExist
                                                                      ? TextDecorationStyle
                                                                          .dashed
                                                                      : null),
                                                            )
                                                          ])),
                                                    ),
                                                    chapter.comment!
                                                                .isNotEmpty &&
                                                            thereIsComment
                                                        ? Text(
                                                            '${chapter.comment![0]}',
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic),
                                                          )
                                                        : Visibility(
                                                            child: Text(''),
                                                            visible: false,
                                                          )
                                                  ],
                                                ))
                                              : Visibility(
                                                  child: Text(''),
                                                  visible: false,
                                                )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 4.5,
                                      ),
                                      listindex == (book.verses.length - 1)
                                          ? Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 100),
                                            )
                                          : Visibility(
                                              visible: false,
                                              child: Text(''),
                                            ),
                                    ],
                                  ),
                                );
                              }),
                        );
                      })
          : (_selectedIndex == 0 ? DailyText() : Account()),
      appBar: buildAppBar(),
      bottomNavigationBar: AnimatedContainer(
        height: isVisible
            ? _selectedIndex == 1
                ? 120
                : 50
            : 50,
        duration: Duration(milliseconds: 0),
        child: Wrap(children: [
          _selectedIndex == 1
              ? Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: !isVisible
                            ? Colors.transparent
                            : Color.fromARGB(125, 71, 68, 68)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          isVisible
                              ? IconButton(
                                  onPressed: () {
                                    pageController.previousPage(
                                        duration: Duration(microseconds: 1),
                                        curve: Curves.linear);
                                  },
                                  icon: Icon(
                                    Icons.chevron_left_sharp,
                                    size: 40,
                                  ),
                                )
                              : Visibility(visible: false, child: Text('')),
                          TextButton(
                            onPressed: () async {
                              int refresh = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChapterList()));

                              if (refresh == refresh) {
                                setState(() {
                                  mypage = refresh;
                                  getBibleVersion();
                                  pageController.jumpToPage(refresh);
                                });
                              }
                            },
                            child: Text(title,
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: currentTheme == Brightness.dark
                                        ? Colors.white
                                        : Colors.black)),
                          ),
                          isVisible
                              ? IconButton(
                                  onPressed: () {
                                    pageController.nextPage(
                                        duration: Duration(microseconds: 1),
                                        curve: Curves.linear);
                                  },
                                  icon: Icon(
                                    Icons.chevron_right,
                                    size: 40,
                                  ),
                                )
                              : Visibility(visible: false, child: Text(''))
                        ]),
                  ),
                )
              : Visibility(visible: false, child: Text('')),
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
                label: '',
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.menu_book_rounded,
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.bookmark,
                  ),
                  label: ''),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: const Color.fromARGB(255, 227, 171, 2),
            onTap: _onItemTapped,
          ),
        ]),
      ),
      bottomSheet: markedText.isNotEmpty
          ? Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          addBookmark(markedText);
                        },
                        icon: Icon(Icons.bookmark_add),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      IconButton(
                        onPressed: () {
                          copyVerse(markedText);
                        },
                        icon: Icon(Icons.copy),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      IconButton(
                        onPressed: () {
                          shareVerse(markedText);
                        },
                        icon: Icon(Icons.share),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/differentVerse',
                              arguments: [
                                {
                                  "pageIndex": pageIndex,
                                  "listIndex": currentVerseIndex,
                                  "title": title,
                                  'version': _currentVersion
                                }
                              ]);
                        },
                        icon: Icon(Icons.table_rows_outlined),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              markedText = [];
                            });
                          },
                          icon: Icon(
                            Icons.cancel_outlined,
                            color: Colors.red,
                          ))
                    ],
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              ColorHighlight.deleteItem(currentBibleVerse);
                              refresher();
                            });
                          },
                          child: Container(
                            child: Icon(Icons.cancel),
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              ColorHighlight.createItem(currentBibleVerse, 0);
                              refresher();
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.amber,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              ColorHighlight.createItem(currentBibleVerse, 1);
                              refresher();
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.green,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              ColorHighlight.createItem(currentBibleVerse, 2);
                              refresher();
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.red,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              ColorHighlight.createItem(currentBibleVerse, 3);
                              refresher();
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: const Color.fromARGB(255, 30, 142, 233),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              ColorHighlight.createItem(currentBibleVerse, 4);
                              refresher();
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Color.fromARGB(255, 159, 30, 233),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              height: 110,
              width: double.infinity,
              color: Color.fromARGB(255, 0, 4, 17),
            )
          : null,
    );
  }
}
