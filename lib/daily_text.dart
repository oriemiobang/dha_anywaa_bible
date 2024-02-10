import 'package:dha_anywaa_bible/pray.dart';
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
  CurvedAnimation? _curvedAnimation;

  @override
  void initState() {
    super.initState();
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
    super.dispose();
    _controller.dispose();
  }

  UiProvider provider = UiProvider();
  @override
  Widget build(BuildContext context) {
    Brightness currentTheme = Theme.of(context).brightness;
    return Container(
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
                                _opacity.value < 0.5 ? " " : 'Jøøn 1: 1-5',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 133, 130, 130),
                                    fontSize: 18),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                _opacity.value < 0.5
                                    ? "Jwøk mëër ki ïnï"
                                    : " 1. Wïlöölö Dwøl nutö, ni Dwørøgøøni ena"
                                        " kanya ciel ki Jwøk, ni Dwørøgøøni"
                                        " beeye Jwøk.\n 2. Wïlöölö eni ena kanya"
                                        " ciel ki Jwøk. 3 Ni jammi bëët cwääc"
                                        " ka ree, ni bäŋ gïn mo ocwääö ri moa"
                                        " cwääc bëët, ni eni tøør ree.\n 4. Ni kwøw"
                                        " ena ree, ni kwøwøgøøni beeye na cïp"
                                        " tar jï jiy.\n 5. Ni tayøgø meenya muudhö,"
                                        " ni käri ya muudhe nää.",
                                style: TextStyle(fontSize: 18),
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
                                                Text('Lam mar Dïcängï')
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
                                                          builder: (context) =>
                                                              Pray()),
                                                    );
                                                  });
                                                },
                                                child: Text(
                                                  'Lämï',
                                                  style: TextStyle(
                                                    color: currentTheme ==
                                                            Brightness.light
                                                        ? const Color.fromARGB(
                                                            255, 1, 11, 36)
                                                        : Color.fromARGB(
                                                            255, 243, 179, 83),
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
                                                Text('Maa wëëlö wïï')
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
                                                Text('Kwaac dwør jwøk')
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
                                                  'Kwaayi',
                                                  style: TextStyle(
                                                    color: currentTheme ==
                                                            Brightness.light
                                                        ? const Color.fromARGB(
                                                            255, 1, 11, 36)
                                                        : Color.fromARGB(
                                                            255, 243, 179, 83),
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
        ));
  }
}
