import 'dart:convert';

import 'package:dha_anywaa_bible/Book.dart';
import 'package:dha_anywaa_bible/chapter_list.dart';
import 'package:dha_anywaa_bible/chapter_name.dart';
import 'package:dha_anywaa_bible/classes/font_size.dart';
import 'package:dha_anywaa_bible/classes/font_style.dart';
// import 'package:dha_anywaa_bible/components/reference.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Chapters extends StatefulWidget {
  // static var book;
  // static var englishBook;

  const Chapters({super.key});

  @override
  State<Chapters> createState() => _ChaptersState();
}

class _ChaptersState extends State<Chapters> {
  String myjsonString = 'assets/fonts/chapters/Any/Genesis.json';
  String englishJsonString = 'assets/holybooks/$bibleVersion';
  Future<String> _loadData() async {
    return await rootBundle.loadString(myjsonString);
  }

  Future<String> _engLoadData() async {
    return await rootBundle.loadString(englishJsonString);
  }

  late Book book;
  late EnglishBook englishBook;

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
      });
    } catch (e) {
      print('objefjhfffffffhct');
      print(e);
    }
  }

  FontSize fontSize = FontSize();
  SelectedFontStyle style = SelectedFontStyle()..init();
  double _currentFontSize = 0;
  String currentFont = '';
  static String bibleVersion = '';
  static int page = 0;
  void getFontSize() async {
    _currentFontSize = await fontSize.getFontSize();
    currentFont = await style.getFontStyle();
    // style.setBibleVersion('NT/1CO/KJV.json');

    // bibleVersion = style.bibleVersion;
    print('font in chapter: $currentFont');

    // print('bible version in chapter: $bibleVersion');
  }

  void getBibleVersion() async {
    // print('no wahala here');
    bibleVersion = await style.getBibleVersion();
    // print('bible version in chapter: $bibleVersion');
    int currentPage = await style.getPage();
    print('object');
    // String currentBook = style.bibleVersion;
    print('2');
    setState(() {
      // bibleVersion = currentBook;
      englishJsonString = 'assets/holybooks/$bibleVersion';
      loadData();
      engLoadData();
      page = currentPage;
      print('currentPage: $currentPage');
      pageController = PageController(initialPage: page);

      // print('currentPage: $currentPage');
    });
    // pageController.jumpToPage(page);

    // print('bible version in chapter: $currentBook');
  }
  // void fetchdata(book) {}

  @override
  void initState() {
    super.initState();
    getBibleVersion();
    getFontSize();
    // print('we are back');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // loadData().dispose();
    super.dispose();
  }

  Color selectedColor = Colors.blue;
  late PageController pageController;
  // MyPageController myPageController = MyPageController();

  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    getFontSize();
    // pageController.jumpToPage(page);

    try {
      // if (book == null) {
      //   return CircularProgressIndicator();
      // }
      return SizedBox(
        // color: Colors.black,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: PageView.builder(
            // physics: NeverScrollableScrollPhysics(),
            onPageChanged: (index) {
              style.setPage(index);
              setState(() {
                getBibleVersion();
              });
            },
            scrollBehavior: const ScrollBehavior(),
            // scrollBehavior: const ScrollBehavior(),
            itemCount: englishBook.chapters.length,
            controller: pageController,
            itemBuilder: (BuildContext context, int index) {
              var book = englishBook.chapters[index];
              return ListView.builder(
                  shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  controller: _scrollController,
                  itemCount: book.verses.length,
                  itemBuilder: (BuildContext context, int listindex) {
                    var chapter = book.verses[listindex];
                    var chapterNumber =
                        book.name.split(' ')[book.name.split(' ').length - 1];
                    String first = book.name.split(' ').length > 2
                        ? book.name.split(' ')[0]
                        : '';
                    print(book.name.split(' '));
                    var chapterName =
                        '$first ${book.name.split(' ')[book.name.split(' ').length - 2]}';
                    return Container(
                      // color: listindex == 4 ? Colors.green : Colors.transparent,
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
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              chapter.text != ''
                                  ? Text(
                                      chapter.id,
                                      style: TextStyle(color: Colors.grey),
                                    )
                                  : const Visibility(
                                      visible: false, child: Text('')),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Text(
                                chapter.text,
                                style: TextStyle(
                                    fontSize: _currentFontSize,
                                    fontFamily: currentFont),
                              ))
                            ],
                          ),
                          listindex == (book.verses.length - 1)
                              ? Padding(
                                  padding: EdgeInsets.only(bottom: 200),
                                  child: TextButton(
                                    onPressed: () async {
                                      int refresh = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ChapterList()));

                                      if (refresh == refresh) {
                                        setState(() {
                                          page = refresh;
                                          getBibleVersion();
                                          pageController.jumpToPage(refresh);
                                        });
                                      }
                                    },
                                    child: const Text('data'),
                                  ),
                                )
                              : Visibility(visible: false, child: Text(''))
                        ],
                      ),
                    );
                  });
            }),
      );
      // return ListView.builder(
      //     controller: _scrollController,
      //     shrinkWrap: true,
      //     itemCount: englishBook.books.length,
      //     itemBuilder: (context, bookIndex) {
      //       var engBook = englishBook.books[bookIndex];
      //       return ListView(
      //         controller: _scrollController,
      //         shrinkWrap: true,
      //         children: [
      //           Text(
      //             engBook.name,
      //           ),
      //           ListView.builder(
      //               controller: _scrollController,
      //               shrinkWrap: true,
      //               physics: NeverScrollableScrollPhysics(),
      //               itemCount: engBook.chapters.length,
      //               itemBuilder: (context, chaperIndex) {
      //                 var chapter = engBook.chapters[chaperIndex];

      //                 return ListTile(
      //                   title: Text(chapter.name),
      //                   subtitle: ListView.builder(
      //                       shrinkWrap: true,
      //                       physics: NeverScrollableScrollPhysics(),
      //                       itemCount: chapter.verses.length,
      //                       itemBuilder: (context, verseIndex) {
      //                         var verse = chapter.verses[verseIndex];
      //                         return ListTile(
      //                           title: Text(verse.text),
      //                         );
      //                       }),
      //                 );
      //               }),
      //         ],
      //       );
      //     });
      // SingleChildScrollView(
      //   child: Column(
      //     // crossAxisAlignment: CrossAxisAlignment.stretch,
      //     children: [
      //       for (int firstIndex = 0;
      //           firstIndex < book.text.length;
      //           firstIndex++)
      //         Column(
      //           children: [
      //             // Text(
      //             //   book.name,
      //             //   style: TextStyle(
      //             //       color: Colors.grey,
      //             //       fontWeight: FontWeight.bold,
      //             //       fontSize: 30),
      //             // ),
      //             // Text(
      //             //   '\n\n${book.intro[0]}\n',
      //             //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      //             // ),
      //             // Text(
      //             //   '${book.intro[1]}',
      //             //   style: TextStyle(letterSpacing: 1),
      //             // ),
      //             Text(
      //               '\n\n\n${book.text[firstIndex].name}',
      //               style: const TextStyle(
      //                 color: Colors.grey,
      //                 fontSize: 27,
      //               ),
      //             ),
      //             Text(
      //               '${book.text[firstIndex].id}',
      //               style: const TextStyle(
      //                   fontSize: 76, fontWeight: FontWeight.bold),
      //             ),
      //             SizedBox(
      //               height: 6,
      //             ),
      //             for (int index = 0;
      //                 index < book.text[firstIndex].text.length;
      //                 index++)
      //               Padding(
      //                 padding: const EdgeInsets.fromLTRB(2, 0, 4, 2),
      //                 child: Column(
      //                   // fit: StackFit.values[1],
      //                   // mainAxisAlignment: MainAxisAlignment.start,
      //                   // crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     book.text[firstIndex].text[index].title != ""
      //                         ? Center(
      //                             child: Text(
      //                               '\n${book.text[firstIndex].text[index].title}',
      //                               style: const TextStyle(
      //                                   fontWeight: FontWeight.bold,
      //                                   fontSize: 18),
      //                             ),
      //                           )
      //                         : const Visibility(
      //                             visible: false, child: Text('')),
      //                     SizedBox(
      //                       height: 3,
      //                     ),
      //                     book.text[firstIndex].text[index].reference != ""
      //                         ? ListTile(
      //                             onTap: () {
      //                               showModalBottomSheet(
      //                                   context: context,
      //                                   builder: (BuildContext context) {
      //                                     return Reference();
      //                                   });
      //                             },
      //                             title: Center(
      //                               child: Text(
      //                                 '${book.text[firstIndex].text[index].reference}\n',
      //                                 style: const TextStyle(
      //                                     fontStyle: FontStyle.italic,
      //                                     color: Color.fromARGB(
      //                                         255, 194, 192, 192)),
      //                               ),
      //                             ),
      //                           )
      //                         : const SizedBox(
      //                             height: 3,
      //                           ),
      //                     Row(
      //                       mainAxisAlignment: MainAxisAlignment.start,
      //                       crossAxisAlignment: CrossAxisAlignment.start,
      //                       children: [
      //                         Text(
      //                           '${book.text[firstIndex].text[index].id}',
      //                           style: const TextStyle(color: Colors.grey),
      //                         ),
      //                         const SizedBox(
      //                           width: 10,
      //                         ),
      //                         Expanded(
      //                           child: SelectableText(
      //                             '${book.text[firstIndex].text[index].text}',
      //                             style: TextStyle(
      //                                 fontSize: _currentFontSize,
      //                                 fontFamily: currentFont),
      //                             // selectioncolo,
      //                             onTap: () {
      //                               setState(() {
      //                                 selectedColor = Colors.red;
      //                               });
      //                             },
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                     SizedBox(
      //                       height: 0,
      //                     )
      //                   ],
      //                 ),
      //               ),
      //           ],
      //         ),
      //     ],
      //   ),
      // );
    } catch (e) {
      return const Text('');
    }
  }
}
