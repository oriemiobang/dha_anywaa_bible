// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

// import 'package:dha_anywaa_bible/main.dart';
import 'package:dha_anywaa_bible/account.dart';
import 'package:dha_anywaa_bible/chapter_list.dart';
import 'package:dha_anywaa_bible/chapters.dart';
import 'package:dha_anywaa_bible/daily_text.dart';
import 'package:dha_anywaa_bible/setting.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:flutter/rendering.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = [DailyText(), Chapters(), Account()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  ScrollController controller = ScrollController();
  bool isVisible = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(listen);
  }

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
      show();
    } else if (direction == ScrollDirection.reverse) {
      hide();
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
                decoration: BoxDecoration(
                    color: currentTheme == Brightness.light
                        ? Color.fromARGB(255, 231, 235, 254)
                        : Color.fromARGB(162, 95, 90, 74),
                    borderRadius: BorderRadius.circular(50)),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.share,
                    color: currentTheme == Brightness.light
                        ? Color.fromARGB(255, 1, 17, 57)
                        : Colors.amber,
                  ),
                ),
              )
            ],
            // backgroundColor: Colors.transparent,
            title: Text(
              'Dïcänyï',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            forceMaterialTransparency: true,
          );
        case 1:
          return AppBar(
              forceMaterialTransparency: true,
              title: SizedBox(
                width: 150,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChapterList()),
                      );
                    });
                  },
                  child: Center(
                    child: Container(
                      width: 150,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(0, 75, 75, 75),
                          borderRadius: BorderRadius.circular(15)),
                      child: Text(
                        'Wiloolo',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                    ),
                  ),
                ),
              ),
              actions: [
                TextButton(onPressed: () {}, child: Text('ANY')),
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
              'My profile',
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
      // backgroundColor: Theme.of(context).colorScheme.background,
      drawer: _selectedIndex == 2
          ? Drawer(
              // backgroundColor: Color.fromARGB(255, 25, 31, 44),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    // decoration: BoxDecoration(color: Colors.white),
                    child: Text(''),
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    onTap: () {
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Setting()),
                        );
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

      // backgroundColor: const Color.fromARGB(255, 9, 13, 57),
      appBar: buildAppBar(),
      body: ListView(
          controller: controller,
          // constrain
          children: [
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: _widgetOptions.elementAt(_selectedIndex)),
          ]),
      bottomNavigationBar: AnimatedContainer(
        height: isVisible ? 50 : 0,
        duration: Duration(milliseconds: 200),
        child: Wrap(children: [
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
                    Icons.person,
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
    );
  }
}
