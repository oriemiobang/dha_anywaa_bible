import 'package:dha_anywaa_bible/theme/theme_provider.dart';
import 'package:flutter/material.dart';

class DailyText extends StatefulWidget {
  const DailyText({super.key});

  @override
  State<DailyText> createState() => _DailyTextState();
}

class _DailyTextState extends State<DailyText> {
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
                padding: const EdgeInsets.only(top: 10, bottom: 60),
                child: Text(
                  "Køøre Wuuö Jwøk aköö, «Ennø dhaanhø atïmö ni caala øøni, ni gïna beer ki gïna raac ŋääe. 'Ba ennø, kany mør eni cäŋa lwötö thuwø ri jaadha näk jaath kwøw, ni cam gø, ni kwøe ni bëëde na bäre bäre.»",
                  style: TextStyle(fontSize: 23),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //  ø     ö     ï    ë  ä
                    children: [
                      Card(
                        elevation: 3,
                        child: Container(
                          width: 270,
                          height: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: currentTheme == Brightness.dark
                                ? Color.fromARGB(255, 1, 17, 57)
                                : Colors.white,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  // MainAxisAlignment.spaceAround,
                                  children: [
                                    Icon(
                                      Icons.waving_hand,
                                      color: Colors.amber,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('Lam mar Dïcänyï')
                                  ]),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                width: 120,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40)),
                                  border: Border.all(
                                    width: 1,
                                    color: currentTheme == Brightness.light
                                        ? const Color.fromARGB(255, 1, 11, 36)
                                        : Color.fromARGB(255, 243, 179, 83),
                                  ),
                                ),
                                child: TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      'Lämï',
                                      style: TextStyle(
                                        color: currentTheme == Brightness.light
                                            ? const Color.fromARGB(
                                                255, 1, 11, 36)
                                            : Color.fromARGB(255, 243, 179, 83),
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
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: currentTheme == Brightness.dark
                                ? Color.fromARGB(255, 1, 17, 57)
                                : Colors.white,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40)),
                                  border: Border.all(
                                    width: 1,
                                    color: currentTheme == Brightness.light
                                        ? const Color.fromARGB(255, 1, 11, 36)
                                        : Color.fromARGB(255, 243, 179, 83),
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Tägï',
                                    style: TextStyle(
                                      color: currentTheme == Brightness.light
                                          ? const Color.fromARGB(255, 1, 11, 36)
                                          : Color.fromARGB(255, 243, 179, 83),
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
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: currentTheme == Brightness.dark
                                ? Color.fromARGB(255, 1, 17, 57)
                                : Colors.white,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.share, color: Colors.amber),
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40)),
                                  border: Border.all(
                                    width: 1,
                                    color: currentTheme == Brightness.light
                                        ? const Color.fromARGB(255, 1, 11, 36)
                                        : Color.fromARGB(255, 243, 179, 83),
                                  ),
                                ),
                                child: TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      'Kwaayi',
                                      style: TextStyle(
                                        color: currentTheme == Brightness.light
                                            ? const Color.fromARGB(
                                                255, 1, 11, 36)
                                            : Color.fromARGB(255, 243, 179, 83),
                                      ),
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
