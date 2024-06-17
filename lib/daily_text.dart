import 'package:dha_anywaa_bible/classes/SQLHelper.dart';
import 'package:dha_anywaa_bible/classes/dailyText.dart';
import 'package:dha_anywaa_bible/classes/font_size.dart';
import 'package:dha_anywaa_bible/classes/font_style.dart';
import 'package:dha_anywaa_bible/theme/theme_provider.dart';
import 'package:flutter/material.dart';

class DailyText extends StatefulWidget {
  const DailyText({super.key});

  @override
  State<DailyText> createState() => _DailyTextState();
}

class _DailyTextState extends State<DailyText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _opacity;

  int myIndex = 3;
  int counter = 0;
  SelectedFontStyle selectedFontStyle = SelectedFontStyle();
  FontSize fontSize = FontSize();

  // CurvedAnimation? _curvedAnimation;

  @override
  void initState() {
    getLang();
    // print('daily');
    super.initState();
    _getItem();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 7));

    _opacity = Tween<double>(begin: 0, end: 1).animate(_controller);
    // TODO: implement initState

    // _opacityLevel = 1;
    _controller.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _controller.dispose();
    super.dispose();
  }

  UiProvider provider = UiProvider();

  DailyVerse dailyText = DailyVerse();

  String currentText = "";
  String currentVerse = "";
  String currentShortText = "";
  String _languages = "";

  // late int currentIndex;
  Future<int> _getItem() async {
    final items = await SQLHelper.getItems();
    if (items.isEmpty) {
      _addItem();
    }

    final item = await SQLHelper.getItem(1);

    return item[0]['counter'];
  }

  Future<void> _addItem() async {
    await SQLHelper.createItem(0);
    // final items = await SQLHelper.getItems();
    // print(' items: $items');
  }

  void getLang() async {
    String languages = await selectedFontStyle.getLanguageVersion();
    setState(() {
      _languages = languages.split(' ')[0];
    });
  }

  void info() async {
    try {
      dailyText = DailyVerse();
      int myIndex = await _getItem();

      currentText = dailyText.dailyVerseList[myIndex]['text']!;

      currentVerse = dailyText.dailyVerseList[myIndex]['verse']!;
      currentShortText = dailyText.dailyVerseList[myIndex]['shortText']!;
    } catch (e) {
      print('error: $e');
    }
  }

  @override
  build(BuildContext context) {
    info();

    // Brightness currentTheme = Theme.of(context).brightness;
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              // color: Colors.amber,
              image: DecorationImage(
                  image: AssetImage('assets/images/bg2.png'),
                  fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 60),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedBuilder(
                        animation: _opacity,
                        builder: (BuildContext context, child) {
                          return Opacity(
                            opacity: _opacity.value,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _opacity.value < 0.5 ? " " : currentVerse,
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 133, 130, 130),
                                      fontSize: 20),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  _opacity.value < 0.5
                                      ? currentShortText
                                      : currentText,
                                  style: TextStyle(
                                      fontSize:
                                          // _languages == 'AMH'
                                          //     ? 25:
                                          currentText.length <= 125
                                              ? _languages == 'AMH'
                                                  ? 25
                                                  : 30
                                              : currentText.length > 310
                                                  ? 18
                                                  : _languages == 'AMH'
                                                      ? 20
                                                      : 25.5),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                // Center(
                //   child: SingleChildScrollView(
                //     scrollDirection: Axis.horizontal,
                //     child: Center(
                //       child: AnimatedBuilder(
                //         animation: _opacity,
                //         builder: (BuildContext context, child) {
                //           return Opacity(
                //             opacity: _opacity.value,
                //             child: _opacity.value < 0.6
                //                 ? Container()
                //                 : Row(
                //                     crossAxisAlignment:
                //                         CrossAxisAlignment.center,
                //                     mainAxisAlignment:
                //                         MainAxisAlignment.spaceBetween,
                //                     //  ø     ö     ï    ë  ä

                //                     children: [
                //                       Card(
                //                         elevation: 3,
                //                         child: Container(
                //                           width: 310,
                //                           height: 170,
                //                           decoration: BoxDecoration(
                //                             borderRadius: BorderRadius.all(
                //                                 Radius.circular(13)),
                //                             color: currentTheme ==
                //                                     Brightness.dark
                //                                 ? Color.fromARGB(255, 1, 10, 34)
                //                                 : Colors.white,
                //                           ),
                //                           child: Column(
                //                             mainAxisAlignment:
                //                                 MainAxisAlignment.center,
                //                             children: [
                //                               Row(
                //                                   crossAxisAlignment:
                //                                       CrossAxisAlignment.center,
                //                                   mainAxisAlignment:
                //                                       MainAxisAlignment.center,
                //                                   // MainAxisAlignment.spaceAround,
                //                                   children: [
                //                                     Icon(
                //                                       Icons.waving_hand,
                //                                       color: Colors.amber,
                //                                       size: 20,
                //                                     ),
                //                                     SizedBox(
                //                                       width: 10,
                //                                     ),
                //                                     Text(
                //                                       _languages == 'AMH'
                //                                           ? 'የዛሬ ፀሎት'
                //                                           : _languages == 'ANY'
                //                                               ? 'Lam mar Dïcängï'
                //                                               : 'Today\'s prayer',
                //                                       style: TextStyle(
                //                                           fontSize: 22),
                //                                     )
                //                                   ]),
                //                               SizedBox(
                //                                 height: 15,
                //                               ),
                //                               Container(
                //                                 width: 120,
                //                                 height: 50,
                //                                 decoration: BoxDecoration(
                //                                   borderRadius:
                //                                       BorderRadius.all(
                //                                           Radius.circular(40)),
                //                                   border: Border.all(
                //                                     width: 1,
                //                                     color: currentTheme ==
                //                                             Brightness.light
                //                                         ? const Color.fromARGB(
                //                                             255, 1, 11, 36)
                //                                         : Color.fromARGB(
                //                                             255, 243, 179, 83),
                //                                   ),
                //                                 ),
                //                                 child: TextButton(
                //                                     onPressed: () {
                //                                       setState(() {
                //                                         Navigator.push(
                //                                           context,
                //                                           MaterialPageRoute(
                //                                               builder:
                //                                                   (context) =>
                //                                                       Pray()),
                //                                         );
                //                                       });
                //                                     },
                //                                     child: Text(
                //                                       _languages == 'AMH'
                //                                           ? 'ፀልይ'
                //                                           : _languages == 'ANY'
                //                                               ? 'Lämï'
                //                                               : 'Pray',
                //                                       style: TextStyle(
                //                                         fontSize: 20.5,
                //                                         color: currentTheme ==
                //                                                 Brightness.light
                //                                             ? const Color
                //                                                 .fromARGB(
                //                                                 255, 1, 11, 36)
                //                                             : Color.fromARGB(
                //                                                 255,
                //                                                 243,
                //                                                 179,
                //                                                 83),
                //                                       ),
                //                                     )),
                //                               )
                //                             ],
                //                           ),
                //                         ),
                //                       ),
                //                       SizedBox(
                //                         width: 20,
                //                       ),
                //                       // Card(
                //                       //   elevation: 3,
                //                       //   child: Container(
                //                       //     width: 270,
                //                       //     height: 130,
                //                       //     decoration: BoxDecoration(
                //                       //       borderRadius: BorderRadius.all(
                //                       //           Radius.circular(10)),
                //                       //       color: currentTheme ==
                //                       //               Brightness.dark
                //                       //           ? Color.fromARGB(255, 1, 10, 34)
                //                       //           : Colors.white,
                //                       //     ),
                //                       //     child: Column(
                //                       //       mainAxisAlignment:
                //                       //           MainAxisAlignment.center,
                //                       //       children: [
                //                       //         Row(
                //                       //             crossAxisAlignment:
                //                       //                 CrossAxisAlignment.center,
                //                       //             mainAxisAlignment:
                //                       //                 MainAxisAlignment.center,
                //                       //             children: [
                //                       //               Icon(
                //                       //                 Icons.menu_book_rounded,
                //                       //                 color: Colors.amber,
                //                       //               ),
                //                       //               SizedBox(
                //                       //                 width: 10,
                //                       //               ),
                //                       //               Text(
                //                       //                 'Maa tier wëëlö wïï',
                //                       //                 style: TextStyle(
                //                       //                     fontSize: 18),
                //                       //               )
                //                       //             ]),
                //                       //         SizedBox(
                //                       //           height: 13,
                //                       //         ),
                //                       //         Container(
                //                       //           width: 120,
                //                       //           decoration: BoxDecoration(
                //                       //             borderRadius:
                //                       //                 BorderRadius.all(
                //                       //                     Radius.circular(40)),
                //                       //             border: Border.all(
                //                       //               width: 1,
                //                       //               color: currentTheme ==
                //                       //                       Brightness.light
                //                       //                   ? const Color.fromARGB(
                //                       //                       255, 1, 11, 36)
                //                       //                   : Color.fromARGB(
                //                       //                       255, 243, 179, 83),
                //                       //             ),
                //                       //           ),
                //                       //           child: TextButton(
                //                       //             onPressed: () {},
                //                       //             child: Text(
                //                       //               'Tägï',
                //                       //               style: TextStyle(
                //                       //                 color: currentTheme ==
                //                       //                         Brightness.light
                //                       //                     ? const Color
                //                       //                         .fromARGB(
                //                       //                         255, 1, 11, 36)
                //                       //                     : Color.fromARGB(255,
                //                       //                         243, 179, 83),
                //                       //               ),
                //                       //             ),
                //                       //           ),
                //                       //         )
                //                       //       ],
                //                       //     ),
                //                       //   ),
                //                       // ),
                //                       // SizedBox(
                //                       // width: 20,
                //                       // ),
                //                       // Card(
                //                       //   elevation: 3,
                //                       //   child: Container(
                //                       //     width: 160,
                //                       //     height: 100,
                //                       //     decoration: BoxDecoration(
                //                       //       borderRadius: BorderRadius.all(
                //                       //           Radius.circular(13)),
                //                       //       color: currentTheme ==
                //                       //               Brightness.dark
                //                       //           ? Color.fromARGB(255, 1, 10, 34)
                //                       //           : Colors.white,
                //                       //     ),
                //                       //     child: Column(
                //                       //       mainAxisAlignment:
                //                       //           MainAxisAlignment.center,
                //                       //       children: [
                //                       //         Row(
                //                       //             mainAxisAlignment:
                //                       //                 MainAxisAlignment.center,
                //                       //             crossAxisAlignment:
                //                       //                 CrossAxisAlignment.center,
                //                       //             children: [
                //                       //               Icon(
                //                       //                 Icons.share,
                //                       //                 color: Colors.amber,
                //                       //                 size: 18,
                //                       //               ),
                //                       //               SizedBox(
                //                       //                 width: 10,
                //                       //               ),
                //                       //               Text(
                //                       //                 _languages == 'AMH'
                //                       //                     ? 'የእግዚአብሔርን ቃል አጋራ'
                //                       //                     : _languages == 'ANY'
                //                       //                         ? 'Kwaac dwør jwøk'
                //                       //                         : 'Share God\'s word',
                //                       //                 style: TextStyle(
                //                       //                     fontSize: 13),
                //                       //               )
                //                       //             ]),
                //                       //         SizedBox(
                //                       //           height: 13,
                //                       //         ),
                //                       //         Container(
                //                       //           width: 90,
                //                       //           height: 40,
                //                       //           decoration: BoxDecoration(
                //                       //             borderRadius:
                //                       //                 BorderRadius.all(
                //                       //                     Radius.circular(40)),
                //                       //             border: Border.all(
                //                       //               width: 1,
                //                       //               color: currentTheme ==
                //                       //                       Brightness.light
                //                       //                   ? const Color.fromARGB(
                //                       //                       255, 1, 11, 36)
                //                       //                   : Color.fromARGB(
                //                       //                       255, 243, 179, 83),
                //                       //             ),
                //                       //           ),
                //                       //           child: TextButton(
                //                       //               onPressed: () {
                //                       //                 Share.share(
                //                       //                     '$currentVerse \n $currentText');
                //                       //               },
                //                       //               child: Text(
                //                       //                 _languages == 'AMH'
                //                       //                     ? 'አጋራ'
                //                       //                     : _languages == 'ANY'
                //                       //                         ? 'Kwaayi'
                //                       //                         : 'Share',
                //                       //                 style: TextStyle(
                //                       //                   fontSize: 16.5,
                //                       //                   color: currentTheme ==
                //                       //                           Brightness.light
                //                       //                       ? const Color
                //                       //                           .fromARGB(
                //                       //                           255, 1, 11, 36)
                //                       //                       : Color.fromARGB(
                //                       //                           255,
                //                       //                           243,
                //                       //                           179,
                //                       //                           83),
                //                       //                 ),
                //                       //               )),
                //                       //         )
                //                       //       ],
                //                       //     ),
                //                       //   ),
                //                       // ),
                //                     ],
                //                   ),
                //           );
                //         },
                //       ),
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        )
      ],
    );
  }
}
