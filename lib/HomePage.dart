// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

// import 'package:dha_anywaa_bible/main.dart';
import 'dart:convert';

import 'package:dha_anywaa_bible/Book.dart';
import 'package:dha_anywaa_bible/account.dart';
import 'package:dha_anywaa_bible/chapter_list.dart';

import 'package:dha_anywaa_bible/classes/SQLHelper.dart';
import 'package:dha_anywaa_bible/classes/dailyText.dart';
import 'package:dha_anywaa_bible/classes/font_size.dart';
import 'package:dha_anywaa_bible/classes/font_style.dart';
import 'package:dha_anywaa_bible/classes/highlights.dart';
import 'package:dha_anywaa_bible/daily_text.dart';
import 'package:dha_anywaa_bible/setting.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
// import 'package:share_plus/share_plus.dart';
// import 'package:share/share.dart';

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:share_plus/share_plus.dart';
// import 'package:share_plus/share_plus.dart';

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

    // style.setBibleVersion('NT/1CO/KJV.json');

    // bibleVersion = style.bibleVersion;
    // print('font in chapter: $currentFont');

    // print('bible version in chapter: $bibleVersion');
  }

  String _language = '';

  void getBibleVersion() async {
    // print('no wahala here');
    bibleVersion = await style.getBibleVersion();
    final language = await style.getLanguageVersion();
    int currentPage = await style.getPage();
    // print(language);

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
        // print(bibleVersion);
        // loadData();
        engLoadData();
      });
    }
    // print('bible version in chapter: $bibleVersion');

    // print('object');
    // String currentBook = style.bibleVersion;
    // print('2');
    setState(() {
      getFontSize();
      languageVerson();
      _language = language.split(' ')[0];
      // bibleVersion = currentBook;

      mypage = currentPage;
      // print('currentPage: $currentPage');
      pageController = PageController(initialPage: mypage);

      // print('currentPage: $currentPage');
    });
    // pageController.jumpToPage(page);

    // print('bible version in chapter: $currentBook');
  }
  // void fetchdata(book) {}

  @override
  void initState() {
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

  ScrollController controller = ScrollController();
  bool isVisible = true;
  SelectedFontStyle selectedFontStyle = SelectedFontStyle();

  @override
  void dispose() {
    // TODO: implement dispose
    controller.removeListener(listen);
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
    if (direction == ScrollDirection.forward) {
      // print(controller.position.atEdge);
      // show();
    } else if (direction == ScrollDirection.reverse) {
      // print(controller.position.atEdge);
      // hide();
    }
  }

  DailyVerse dailyText = DailyVerse();
  String currentText = "";
  String currentVerse = "";
  String title = "";
  bool atEnd = false;
  bool atBeggining = false;

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
              'Dïcängï',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            forceMaterialTransparency: true,
          );
        case 1:
          return AppBar(
              forceMaterialTransparency: true,
              // title: SizedBox(
              //   width: 150,
              //   child: TextButton(
              //     onPressed: () {
              //       setState(() {
              //         Navigator.pushNamed(context, '/chapterList').then((_) {});
              //       });
              //     },
              //     child: Center(
              //       child: Container(
              //         width: 150,
              //         height: 40,
              //         decoration: BoxDecoration(
              //             color: Color.fromARGB(0, 75, 75, 75),
              //             borderRadius: BorderRadius.circular(15)),
              //         child: Text(
              //           'Wïlöölö',
              //           style: TextStyle(
              //               fontWeight: FontWeight.bold, fontSize: 17),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/chooseBible').then((_) {
                      setState(() {
                        languageVerson();
                        setState(() {
                          getBibleVersion();
                        });
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
                      'About',
                      style: TextStyle(),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.menu_book_rounded,
                    ),
                    title: Text(
                      'About the publisher',
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
                      key: UniqueKey(),
                      controller: pageController,
                      onPageChanged: (index) {
                        style.setPage(index);
                        setState(() {
                          getBibleVersion();
                          if (amharicBook!.chapters.length - 1 == index) {
                            atEnd = true;
                            print('end');
                          } else if (index == 0) {
                            print('beginning');
                            atBeggining = true;
                          } else {
                            atEnd = false;
                            atBeggining = false;
                          }
                          // title = amharicBook!.title;
                        });
                      },
                      itemCount: amharicBook!.chapters.length,
                      itemBuilder: (BuildContext context, int pageIndex) {
                        var amhbook = amharicBook!.chapters[pageIndex];

                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 8, left: 10, bottom: 0, right: 9),
                          child: ListView.builder(
                              key: UniqueKey(),
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
                                            Highlight.createItem(amhchapters,
                                                '${amharicBook!.title} ${amhbook.chapter}: ${listIndex + 1}');
                                          },
                                          child: RichText(
                                            text: TextSpan(
                                              style:
                                                  DefaultTextStyle.of(context)
                                                      .style,
                                              children: [
                                                TextSpan(
                                                  text: nextAmhChapter == '' &&
                                                          amhchapters != ''
                                                      ? '${listIndex + 1} - ${listIndex + 2}  '
                                                      : amhchapters != ''
                                                          ? '${listIndex + 1}  '
                                                          : '',
                                                  style: TextStyle(
                                                      fontFamily: currentFont,
                                                      fontSize:
                                                          _currentFontSize,
                                                      color: Colors.grey),
                                                ),
                                                TextSpan(
                                                  text: amhchapters,
                                                  style: TextStyle(
                                                      fontFamily: currentFont,
                                                      fontSize:
                                                          _currentFontSize),
                                                ),
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
                      key: UniqueKey(),
                      // physics: NeverScrollableScrollPhysics(),
                      onPageChanged: (index) {
                        style.setPage(index);
                        setState(() {
                          getBibleVersion();

                          if (englishBook!.chapters.length - 1 == index) {
                            atEnd = true;
                            print('end');
                          } else if (index == 0) {
                            print('beginning');
                            atBeggining = true;
                          } else {
                            atEnd = false;
                            atBeggining = false;
                          }
                        });
                      },
                      scrollBehavior: const ScrollBehavior(),
                      itemCount: englishBook!.chapters.length,
                      controller: pageController,
                      itemBuilder: (BuildContext context, int index) {
                        var book = englishBook!.chapters[index];
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: ListView.builder(
                              key: UniqueKey(),
                              itemCount: book.verses.length,
                              shrinkWrap: true,
                              controller: controller,
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
                                                        // Scaffold.of(context)
                                                        //     .showBottomSheet(
                                                        //         (context) =>
                                                        //             Container(
                                                        //               height:
                                                        //                   200,
                                                        //               width: double
                                                        //                   .infinity,
                                                        //             ));

                                                        Highlight.createItem(
                                                            chapter.text,
                                                            '${chapterName} ${chapterNumber}: ${chapter.id}');
                                                      },
                                                      child: RichText(
                                                          text: TextSpan(
                                                              style: DefaultTextStyle
                                                                      .of(context)
                                                                  .style,
                                                              children: [
                                                            TextSpan(
                                                                text: chapter
                                                                    .text,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        currentFont,
                                                                    fontSize:
                                                                        _currentFontSize))
                                                          ])),
                                                    ),
                                                    chapter.comment!.isNotEmpty
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
                                                  EdgeInsets.only(bottom: 50),
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
                              ? !atBeggining
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
                                  : Visibility(visible: false, child: Text(''))
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
                              ? (!atEnd)
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
                              : Visibility(visible: false, child: Text('')),
                        ]),
                  ),
                )
              : Visibility(visible: false, child: Text('')),
          BottomNavigationBar(
            useLegacyColorScheme: true,
            elevation: 0,
            // backgroundColor: Colors.transparent,

            // backgroundColor: const Color.fromARGB(255, 9, 13, 57),
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  currentTheme == Brightness.light
                      ? Icons.wb_sunny_outlined
                      : Icons.nights_stay_outlined,
                  // color: Colors.white,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.menu_book_rounded,
                    // color: Colors.white,
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.bookmark,
                    // color: Colors.white,
                  ),
                  label: ''),
            ],
            currentIndex: _selectedIndex,
            // unselectedItemColor: Colors.white,
            selectedItemColor: const Color.fromARGB(255, 227, 171, 2),
            onTap: _onItemTapped,
          ),
        ]),
      ),
      // bottomSheet: Container(
      //   height: 60,
      //   width: 60,
      //   color: Colors.white,
      // ),
    );
  }
}
