// ignore_for_file: prefer_const_constructors, prefer_final_fields

// import 'package:dha_anywaa_bible/components/numbers.dart';
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

  List<Map<String, String>> chapAbbrev = [
    {'title': 'Genesis', 'number': '50', 'abbrev': 'GEN'},
    {'title': 'Exodus', 'number': '40', 'abbrev': 'EXO'},
    {'title': 'Leviticus', 'number': '27', 'abbrev': 'LEV'},
    {'title': 'Numbers', 'number': '36', 'abbrev': 'NUM'},
    {'title': 'Deuteronomy', 'number': '34', 'abbrev': 'DEU'},
    {'title': 'Joshua', 'number': '24', 'abbrev': 'JOS'},
    {'title': "Judges", 'number': '21', 'abbrev': 'JDG'},
    {'title': "Ruth", 'number': '4', 'abbrev': 'RUT'},
    {'title': "1 Samuel", 'number': '31', 'abbrev': '1SA'},
    {'title': "2 Samuel", 'number': '24', 'abbrev': '2SA'},
    {'title': "1 Kings", 'number': '22', 'abbrev': '1KI'},
    {'title': "2 Kings", 'number': '25', 'abbrev': '2KI'},
    {'title': "1 Chronicles", 'number': '29', 'abbrev': '1CH'},
    {'title': "2 Chronicles", 'number': '36', 'abbrev': '2CH'},
    {'title': "Ezra", 'number': '10', 'abbrev': 'EZR'},
    {'title': "Nehemiah", 'number': '13', 'abbrev': 'NAM'},
    {'title': "Esther", 'number': '10', 'abbrev': 'EST'},
    {'title': "Job", 'number': '42', 'abbrev': 'JOB'},
    {'title': "Psalms", 'number': '150', 'abbrev': 'PSA'},
    {'title': "Proverbs", 'number': '31', 'abbrev': 'PRO'},
    {'title': "Ecclesiastes", 'number': '12', 'abbrev': 'ECC'},
    {'title': "Song of Solomon", 'number': '8', 'abbrev': 'SNG'},
    {'title': 'Isaiah', 'number': '66', 'abbrev': 'ISA'},
    {'title': 'Jeremiah', 'number': '52', 'abbrev': 'JER'},
    {'title': 'Lamentations', 'number': '5', 'abbrev': 'LAM'},
    {'title': 'Ezekiel', 'number': '48', 'abbrev': 'EZK'},
    {'title': 'Daniel', 'number': '12', 'abbrev': 'DAN'},
    {'title': 'Hosea', 'number': '14', 'abbrev': 'HOS'},
    {'title': 'Joel', 'number': '3', 'abbrev': 'JOL'},
    {'title': 'Amos', 'number': '9', 'abbrev': 'AMO'},
    {'title': 'Obadiah', 'number': '1', 'abbrev': 'OBA'},
    {'title': 'Jonah', 'number': '4', 'abbrev': 'JON'},
    {'title': 'Micah', 'number': '7', 'abbrev': 'MIC'},
    {'title': 'Nahum', 'number': '3', 'abbrev': 'NAH'},
    {'title': 'Habakkuk', 'number': '3', 'abbrev': 'HAB'},
    {'title': 'Zephaniah', 'number': '3', 'abbrev': 'ZEP'},
    {'title': 'Haggai', 'number': '2', 'abbrev': 'HAG'},
    {'title': 'Zechariah', 'number': '14', 'abbrev': 'ZEC'},
    {'title': 'Malachi', 'number': '4', 'abbrev': 'MAL'},
    {'title': 'Matthew', 'number': '28', 'abbrev': 'MAT'},
    {'title': 'Mark', 'number': '16', 'abbrev': 'MRK'},
    {'title': 'Luke', 'number': '24', 'abbrev': 'LUK'},
    {'title': 'John', 'number': '21', 'abbrev': 'JHN'},
    {'title': 'Acts', 'number': '28', 'abbrev': 'ACT'},
    {'title': 'Romans', 'number': '16', 'abbrev': 'ROM'},
    {'title': '1 Corinthians', 'number': '16', 'abbrev': '1CO'},
    {'title': '2 Corinthians', 'number': '13', 'abbrev': '2CO'},
    {'title': 'Galatians', 'number': '6', 'abbrev': 'GAL'},
    {'title': 'Ephesians', 'number': '6', 'abbrev': 'EPH'},
    {'title': 'Philippians', 'number': '4', 'abbrev': 'PHP'},
    {'title': 'Colossians', 'number': '4', 'abbrev': 'COL'},
    {'title': '1 Thessalonians', 'number': '5', 'abbrev': '1TH'},
    {'title': '2 Thessalonians', 'number': '3', 'abbrev': '2TH'},
    {'title': '1 Timothy', 'number': '6', 'abbrev': '1TI'},
    {'title': '2 Timothy', 'number': '4', 'abbrev': '2TI'},
    {'title': 'Titus', 'number': '3', 'abbrev': 'TIT'},
    {'title': 'Philemon', 'number': '1', 'abbrev': 'PHM'},
    {'title': 'Hebrews', 'number': '13', 'abbrev': 'HEB'},
    {'title': 'James', 'number': '5', 'abbrev': 'JAS'},
    {'title': '1 Peter', 'number': '5', 'abbrev': '1PE'},
    {'title': '2 Peter', 'number': '3', 'abbrev': '2PE'},
    {'title': '1 John', 'number': '5', 'abbrev': '1JN'},
    {'title': '2 John', 'number': '1', 'abbrev': '2JN'},
    {'title': '3 John', 'number': '1', 'abbrev': '3JN'},
    {'title': 'Jude', 'number': '1', 'abbrev': 'JUD'},
    {'title': 'Revelation', 'number': '22', 'abbrev': 'REV'}
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
        body: ListView.builder(
            itemCount: chapAbbrev.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('${chapAbbrev[index]['title']}'),
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return ListView(
                          children: [
                            Text('${chapAbbrev[index]['title']}'),
                            Divider(),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 10, right: 10, bottom: 40),
                              child: GridView.count(
                                shrinkWrap: true,
                                crossAxisCount: 6,
                                children: List.generate(
                                    int.parse('${chapAbbrev[index]['number']}'),
                                    (index) {
                                  return Card(
                                    // color: Color.fromARGB(136, 67, 65, 58),
                                    child: Center(
                                      child: TextButton(
                                        child: Text('${index + 1}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Color.fromARGB(
                                                    255, 250, 219, 124))),
                                        onPressed: () {},
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ],
                        );
                      });
                },
              );
            }));
  }
}
