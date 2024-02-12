import 'dart:convert';

import 'package:dha_anywaa_bible/Book.dart';
import 'package:dha_anywaa_bible/components/reference.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Chapters extends StatefulWidget {
  // static var book;
  // static var englishBook;

  const Chapters({super.key});

  @override
  State<Chapters> createState() => _ChaptersState();
}

const myjsonString = 'assets/fonts/chapters/Any/Genesis.json';
const englishJsonString = 'assets/holybooks/Bible_KJV.json';

class _ChaptersState extends State<Chapters> {
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
      // print('object');
      String engJsonString = await _engLoadData();
      final engJsonResponse = json.decode(engJsonString);
      print('object');
      setState(() {
        print('no error here');
        englishBook = EnglishBook.fromJson(engJsonResponse);
        print('OOPS');
        // print('object');
        // print(book.name);
        // print(book.intro[0]);
        // print(book.text[0].text[0].text);
        for (int i = 0; i < englishBook.text[0].text.length; i++) {
          print(book.text[0].text[i].text);
          print(englishBook.text[0].text[i].text);
        }
      });
    } catch (e) {
      print('objefjhfffffffhct');
      print(e);
    }
  }

  // void fetchdata(book) {}

  @override
  void initState() {
    super.initState();
    loadData();
    engLoadData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // loadData().dispose();
    super.dispose();
  }

  Color selectedColor = Colors.blue;
  @override
  Widget build(BuildContext context) {
    try {
      if (book == null) {
        return CircularProgressIndicator();
      }
      return SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (int firstIndex = 0;
                firstIndex < book.text.length;
                firstIndex++)
              Column(
                children: [
                  // Text(
                  //   book.name,
                  //   style: TextStyle(
                  //       color: Colors.grey,
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 30),
                  // ),
                  // Text(
                  //   '\n\n${book.intro[0]}\n',
                  //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  // ),
                  // Text(
                  //   '${book.intro[1]}',
                  //   style: TextStyle(letterSpacing: 1),
                  // ),
                  Text(
                    '\n\n\n${book.text[firstIndex].name}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 27,
                    ),
                  ),
                  Text(
                    '${book.text[firstIndex].id}',
                    style: const TextStyle(
                        fontSize: 76, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  for (int index = 0;
                      index < book.text[firstIndex].text.length;
                      index++)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(2, 0, 4, 2),
                      child: Column(
                        // fit: StackFit.values[1],
                        // mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          book.text[firstIndex].text[index].title != ""
                              ? Center(
                                  child: Text(
                                    '\n${book.text[firstIndex].text[index].title}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                )
                              : const Visibility(
                                  visible: false, child: Text('')),
                          SizedBox(
                            height: 3,
                          ),
                          book.text[firstIndex].text[index].reference != ""
                              ? ListTile(
                                  onTap: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Reference();
                                        });
                                  },
                                  title: Center(
                                    child: Text(
                                      '${book.text[firstIndex].text[index].reference}\n',
                                      style: const TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: Color.fromARGB(
                                              255, 194, 192, 192)),
                                    ),
                                  ),
                                )
                              : const SizedBox(
                                  height: 3,
                                ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${book.text[firstIndex].text[index].id}',
                                style: const TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: SelectableText(
                                  '${book.text[firstIndex].text[index].text}',
                                  style: TextStyle(fontSize: 16.0),
                                  // selectioncolo,
                                  onTap: () {
                                    setState(() {
                                      selectedColor = Colors.red;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 0,
                          )
                        ],
                      ),
                    ),
                ],
              ),
          ],
        ),
      );
    } catch (e) {
      return const Text('');
    }
  }
}
