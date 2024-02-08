import 'package:flutter/material.dart';

class DailyText extends StatefulWidget {
  const DailyText({super.key});

  @override
  State<DailyText> createState() => _DailyTextState();
}

class _DailyTextState extends State<DailyText> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            color: Colors.amber,
            image: DecorationImage(
                image: AssetImage('assets/bg.jpg'), fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 60),
                child: Text(
                    "Køøre Wuuö Jwøk aköö, «Ennø dhaanhø atïmö ni caala øøni, ni gïna beer ki gïna raac ŋääe. 'Ba ennø, kany mør eni cäŋa lwötö thuwø ri jaadha näk jaath kwøw, ni cam gø, ni kwøe ni bëëde na bäre bäre.»"),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //  ø     ö     ï    ë  ä
                    children: [
                      Container(
                        width: 270,
                        height: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color.fromARGB(108, 0, 0, 0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                // MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(Icons.waving_hand),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('Lam mar Dïcänyï')
                                ]),
                            Container(
                              child: TextButton(
                                  onPressed: () {}, child: Text('Lämï')),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: 270,
                        height: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color.fromARGB(108, 0, 0, 0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.menu_book_rounded),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('Maa wëëlö wïï')
                                ]),
                            Container(
                              child: TextButton(
                                  onPressed: () {}, child: Text('Tägï')),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: 270,
                        height: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color.fromARGB(108, 0, 0, 0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.share),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('Kwaac dwør jwøk')
                                ]),
                            Container(
                              child: TextButton(
                                  onPressed: () {}, child: Text('Kwaayi')),
                            )
                          ],
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
