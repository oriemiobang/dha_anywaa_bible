// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Chapter {
  final String title;
  bool isExpanded;
  final int number;

  //  ø     ö     ï    ë  ä

  Chapter(
      {required this.title, required this.number, required this.isExpanded});
}

class ChapterList extends StatefulWidget {
  @override
  _ChapterListState createState() => _ChapterListState();
}

class _ChapterListState extends State<ChapterList> {
  List<Chapter> _chapters = [
    Chapter(title: 'Wïlöölö', number: 51, isExpanded: false),
    Chapter(title: 'Bwøth Wøk', number: 41, isExpanded: false),
    Chapter(title: 'Ciik kiper dilämmë', number: 28, isExpanded: false),
    Chapter(title: 'Kwaan jey', number: 37, isExpanded: false),
    Chapter(title: 'Tiet ciik', number: 35, isExpanded: false),
    Chapter(title: 'Jøcua', number: 35, isExpanded: false),
    Chapter(title: 'Pïëmme', number: 35, isExpanded: false),
    Chapter(title: 'Ruuth', number: 35, isExpanded: false),
    Chapter(title: '1 Camiel', number: 35, isExpanded: false),
    Chapter(title: '2 Camiel', number: 35, isExpanded: false),
    Chapter(title: '1 Nyeye', number: 35, isExpanded: false),
    Chapter(title: '2 Nyeye', number: 35, isExpanded: false),
    Chapter(title: '1 Luup Nyeye', number: 35, isExpanded: false),
    Chapter(title: '2 Luup Nyeye', number: 35, isExpanded: false),
    Chapter(title: 'Edhera', number: 35, isExpanded: false),
    Chapter(title: 'Neemiya', number: 35, isExpanded: false),
    Chapter(title: 'Acther', number: 35, isExpanded: false),
    Chapter(title: 'Jööp', number: 35, isExpanded: false),
    Chapter(title: 'Dut Pwøc', number: 35, isExpanded: false),
  ];

  int currentOpenedPanelIndex = -1;
  // bool previousOpenedPanel = false;

  // List<bool> _isExpanded = [false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // leading: IconButton(

        //     onPressed: () {
        //       setState(() {
        //         Navigator.pop(context);
        //       });
        //     },
        //     icon: Icon(
        //       Icons.arrow_back_rounded,
        //       color: Colors.white,
        //     )),
        toolbarHeight: 100,
        forceMaterialTransparency: true,
        title: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        Navigator.pop(context);
                      });
                    },
                    icon: Icon(
                      Icons.arrow_back_rounded,
                    )),
                Text('weeli',
                    style: TextStyle(
                      fontSize: 19,
                    )),
              ],
            ),
            Row(
              children: [
                Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(155, 75, 75, 75),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            topLeft: Radius.circular(20))),
                    child: Center(
                      child: Icon(
                        Icons.search,
                        size: 30,
                      ),
                    )),
                Expanded(
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20))),
                        // labelText: 'Search',
                        filled: true,
                        // enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        fillColor: Color.fromARGB(155, 75, 75, 75),
                        label: Text(
                          'Määnyï',
                          style: TextStyle(
                              // color: Color.fromARGB(217, 193, 190, 190)
                              ),
                        ),
                        // icon: Container(
                        //     height: 50,
                        //     width: 30,
                        //     decoration: BoxDecoration(
                        //         color: Color.fromARGB(155, 75, 75, 75),
                        //         borderRadius: BorderRadius.only(
                        //             bottomLeft: Radius.circular(20),
                        //             topLeft: Radius.circular(20))),
                        //     child: Icon(Icons.search))

                        // icon: Icon(Icons.search),
                        // label: Icon(Icons.search)

                        // icon: Icon(Icons.search)
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: ExpansionPanelList(
          expandIconColor: Colors.transparent,
          elevation: 0,
          dividerColor: Colors.transparent,
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              if (currentOpenedPanelIndex != -1) {
                _chapters[currentOpenedPanelIndex].isExpanded =
                    !_chapters[currentOpenedPanelIndex].isExpanded;
              }
              if (_chapters[index].isExpanded) {
                currentOpenedPanelIndex = -1;

                // _chapters[index].isExpanded = false;
              } else {
                _chapters[index].isExpanded = true;

                currentOpenedPanelIndex = index;
              }
            });
          },
          children: _chapters.map((chapter) {
            int index = _chapters.indexOf(chapter);
            return ExpansionPanel(
              backgroundColor: Colors.transparent,
              canTapOnHeader: true,
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ListTile(
                  title: Text(chapter.title),
                  // tileColor: const Color.fromARGB(255, 9, 13, 57),
                  // textColor: Colors.white,
                  // iconColor: Colors.white,
                  // splashColor: const Color.fromARGB(255, 9, 13, 57),
                );
              },
              body: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 6,
                children: List.generate(chapter.number, (index) {
                  return Card(
                    // color: Color.fromARGB(136, 67, 65, 58),
                    child: Center(
                      child: TextButton(
                        child: index == 0
                            ? Text(
                                'Bwödhï',
                                style: TextStyle(fontSize: 15),
                              )
                            : Text('${index}',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 250, 219, 124))),
                        onPressed: () {},
                      ),
                    ),
                  );
                }),
              ),
              isExpanded: _chapters[index].isExpanded,
            );
          }).toList(),
        ),
      ),
    );
  }
}
