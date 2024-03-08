import 'package:dha_anywaa_bible/classes/SQLHelper.dart';
import 'package:dha_anywaa_bible/classes/dailyText.dart';
import 'package:dha_anywaa_bible/classes/font_style.dart';
// import 'package:dha_anywaa_bible/main.dart';
import 'package:dha_anywaa_bible/pray.dart';
import 'package:dha_anywaa_bible/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:once/once.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:workmanager/workmanager.dart';

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

  // CurvedAnimation? _curvedAnimation;

  @override
  void initState() {
    Once.runOnce('key', callback: () {
      selectedFontStyle.setBibleVersion('OT/GEN/KJV.json');
      selectedFontStyle.setFontStyle('UntitledSerif');
      selectedFontStyle.setPage(15);
      selectedFontStyle.setLanguageVersion('KJV');
    });
    // styleReferesh();
    // _addItem();
    // _referesher();
    // print('db length ${_items.length}');
    // myManager();
    super.initState();
    _getItem();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 7));

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

  // late int currentIndex;
  Future<int> _getItem() async {
    final items = await SQLHelper.getItems();
    if (items.isEmpty) {
      _addItem();
      print('there is an issue');
    }

    final item = await SQLHelper.getItem(1);

    print('inner index: $item');
    return item[0]['counter'];
  }

  Future<void> _addItem() async {
    await SQLHelper.createItem(0);
    final items = await SQLHelper.getItems();
    print(' items: $items');
  }

  // void _referesher() async {
  //   final item = await SQLHelper.getItem(2);
  //   final items = await SQLHelper.getItems();
  //   print('$items');
  //   print(' the item ${item[0]['counter']}');

  //   myIndex = item[0]['counter'];
  //   SQLHelper.updateItem(1, 3);
  // }

  void info() async {
    try {
      // print('object');
      // await SQLHelper.updateItem(1, 0);
      // print('anoher obeject');

      int myIndex = await _getItem();
      // print('third object');

      print('my index: $myIndex');
      currentText = dailyText.dailyVerseList[myIndex]['text']!;
      // print(' blala ${currentText}');
      currentVerse = dailyText.dailyVerseList[myIndex]['verse']!;
      currentShortText = dailyText.dailyVerseList[myIndex]['shortText']!;
    } catch (e) {
      print('error: $e');
    }
  }

  @override
  build(BuildContext context) {
    info();

    Brightness currentTheme = Theme.of(context).brightness;
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              // color: Colors.amber,
              image: DecorationImage(
                  image: AssetImage('assets/bg2.png'), fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 60),
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
                                  _opacity.value < 0.5 ? " " : '$currentVerse',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 133, 130, 130),
                                      fontSize: 20),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  _opacity.value < 0.5
                                      ? currentShortText
                                      : currentText,
                                  style: TextStyle(
                                      fontSize:
                                          currentText.length <= 125 ? 30 : 20),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Center(
                    child: AnimatedBuilder(
                      animation: _opacity,
                      builder: (BuildContext context, child) {
                        return Opacity(
                          opacity: _opacity.value,
                          child: _opacity.value < 0.6
                              ? Container()
                              : Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  //  ø     ö     ï    ë  ä

                                  children: [
                                    Card(
                                      elevation: 3,
                                      child: Container(
                                        width: 270,
                                        height: 130,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          color: currentTheme == Brightness.dark
                                              ? Color.fromARGB(255, 1, 10, 34)
                                              : Colors.white,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                // MainAxisAlignment.spaceAround,
                                                children: [
                                                  Icon(
                                                    Icons.waving_hand,
                                                    color: Colors.amber,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    'Lam mar Dïcängï',
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  )
                                                ]),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Container(
                                              width: 120,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(40)),
                                                border: Border.all(
                                                  width: 1,
                                                  color: currentTheme ==
                                                          Brightness.light
                                                      ? const Color.fromARGB(
                                                          255, 1, 11, 36)
                                                      : Color.fromARGB(
                                                          255, 243, 179, 83),
                                                ),
                                              ),
                                              child: TextButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    Pray()),
                                                      );
                                                    });
                                                  },
                                                  child: Text(
                                                    'Lämï',
                                                    style: TextStyle(
                                                      color: currentTheme ==
                                                              Brightness.light
                                                          ? const Color
                                                              .fromARGB(
                                                              255, 1, 11, 36)
                                                          : Color.fromARGB(255,
                                                              243, 179, 83),
                                                    ),
                                                  )),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Card(
                                      elevation: 3,
                                      child: Container(
                                        width: 270,
                                        height: 130,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          color: currentTheme == Brightness.dark
                                              ? Color.fromARGB(255, 1, 10, 34)
                                              : Colors.white,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.menu_book_rounded,
                                                    color: Colors.amber,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    'Maa tier wëëlö wïï',
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  )
                                                ]),
                                            SizedBox(
                                              height: 13,
                                            ),
                                            Container(
                                              width: 120,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(40)),
                                                border: Border.all(
                                                  width: 1,
                                                  color: currentTheme ==
                                                          Brightness.light
                                                      ? const Color.fromARGB(
                                                          255, 1, 11, 36)
                                                      : Color.fromARGB(
                                                          255, 243, 179, 83),
                                                ),
                                              ),
                                              child: TextButton(
                                                onPressed: () {},
                                                child: Text(
                                                  'Tägï',
                                                  style: TextStyle(
                                                    color: currentTheme ==
                                                            Brightness.light
                                                        ? const Color.fromARGB(
                                                            255, 1, 11, 36)
                                                        : Color.fromARGB(
                                                            255, 243, 179, 83),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Card(
                                      elevation: 3,
                                      child: Container(
                                        width: 270,
                                        height: 130,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          color: currentTheme == Brightness.dark
                                              ? Color.fromARGB(255, 1, 10, 34)
                                              : Colors.white,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.share,
                                                      color: Colors.amber),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    'Kwaac dwør jwøk',
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  )
                                                ]),
                                            SizedBox(
                                              height: 13,
                                            ),
                                            Container(
                                              width: 120,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(40)),
                                                border: Border.all(
                                                  width: 1,
                                                  color: currentTheme ==
                                                          Brightness.light
                                                      ? const Color.fromARGB(
                                                          255, 1, 11, 36)
                                                      : Color.fromARGB(
                                                          255, 243, 179, 83),
                                                ),
                                              ),
                                              child: TextButton(
                                                  onPressed: () {
                                                    Share.share(
                                                        '$currentVerse \n $currentText');
                                                  },
                                                  child: Text(
                                                    'Kwaayi',
                                                    style: TextStyle(
                                                      color: currentTheme ==
                                                              Brightness.light
                                                          ? const Color
                                                              .fromARGB(
                                                              255, 1, 11, 36)
                                                          : Color.fromARGB(255,
                                                              243, 179, 83),
                                                    ),
                                                  )),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
