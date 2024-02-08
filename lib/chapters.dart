import 'dart:convert';

import 'package:dha_anywaa_bible/Book.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Chapters extends StatefulWidget {
  static var book;

  const Chapters({super.key});

  @override
  State<Chapters> createState() => _ChaptersState();
}

const myjsonString = 'assets/fonts/chapters/Any/Genesis.json';

class _ChaptersState extends State<Chapters> {
  Future<String> _loadData() async {
    //  String data =
    // final jsonResult = jsonDecode(data);
    return await rootBundle.loadString(myjsonString);
  }

  // List list = [];
  late Book book;
  // final Book book = Book;
  // String demo = " ";

  Future loadData() async {
    try {
      // print('object');
      String jsonString = await _loadData();

      final jsonResponse = json.decode(jsonString);
      // print('object');
      setState(() {
        book = Book.fromJson(jsonResponse);
        // print('object');
        // print(book.name);
        // print(book.intro[0]);
        // print(book.text[0].text[0].text);
        // for (int i = 0; i < book.text[0].text.length; i++) {
        //   print(book.text[0].text[i].text);
        // }

        // print(book.text[0].verses);
        // list.add(book.text[0].text[0].text);
      });
    } catch (e) {
      // print('object');
      // print(e);
    }
  }

  // void fetchdata(book) {}

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    try {
      if (book == null) {
        return CircularProgressIndicator();
      }
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                    '\n\n${book.text[firstIndex].name}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    '${book.text[firstIndex].id}',
                    style: const TextStyle(
                        fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  for (int index = 0;
                      index < book.text[firstIndex].text.length;
                      index++)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          book.text[firstIndex].text[index].title != ""
                              ? Center(
                                  child: Text(
                                    '\n${book.text[firstIndex].text[index].title}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                )
                              : const Visibility(
                                  visible: false, child: Text('')),
                          book.text[firstIndex].text[index].reference != ""
                              ? Center(
                                  child: Text(
                                    '${book.text[firstIndex].text[index].reference}\n',
                                    style: const TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color:
                                            Color.fromARGB(255, 194, 192, 192)),
                                  ),
                                )
                              : const SizedBox(
                                  height: 10,
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
                                child: RichText(
                                  text: TextSpan(
                                      text:
                                          '${book.text[firstIndex].text[index].text}\n'),
                                  selectionRegistrar:
                                      SelectionContainer.maybeOf(context),
                                  selectionColor: const Color(0xAF6694e8),
                                ),
                              ),
                            ],
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


  // @override
  // Widget build(BuildContext context) {
  //   try {
  //     if (book == null) {
  //       // Return a loading indicator or any other widget while data is being loaded.
  //       return CircularProgressIndicator();
  //     }

  //     return SingleChildScrollView(
  //       child: Column(
  //         children: [
  //           Text(
  //             '${book.text[0].name}',
  //             style: TextStyle(
  //               fontSize: 17,
  //             ),
  //           ),
  //           Text(
  //             '${book.text[0].id}',
  //             style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
  //           ),
  //           Text(
  //             '${book.text[0].text[0].title}',
  //             style: TextStyle(fontWeight: FontWeight.bold),
  //           ),
  //           SizedBox(
  //             height: 16,
  //           ),
  //           Text(
  //               '${book.text[0].text[0].text} \n ${book.text[0].text[1].text}\n ${book.text[0].text[2].text}'),
  //         ],
  //       ),
  //     );
  //   } catch (e) {
  //     print(e);
  //     return Text('');
  //   }
  // }