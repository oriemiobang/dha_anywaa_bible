// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dha_anywaa_bible/classes/highlights.dart';
import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  var _highlights = [];

  Future<void> refresher() async {
    final highlight = await Highlight.gethighlight();
    // print(highlight[0]);
    setState(() {
      _highlights = highlight.reversed.toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refresher();
  }

  @override
  Widget build(BuildContext context) {
    Brightness currentTheme = Theme.of(context).brightness;
    return _highlights.isNotEmpty
        ? ListView.builder(
            itemCount: _highlights.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          left: BorderSide(
                              color: Color.fromARGB(255, 184, 141, 3),
                              width: 3))),
                  child: Dismissible(
                    background: Container(
                      color: Colors.red,
                      child: ListTile(
                        // tileColor: Colors.red,
                        leading: Icon(Icons.delete),
                        trailing: Icon(Icons.delete),
                      ),
                    ),
                    key: Key(_highlights[index]['id'].toString()),
                    onDismissed: (direction) {
                      var hold = _highlights[index];

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Color.fromARGB(255, 0, 4, 17),
                          content: ListTile(
                            trailing: TextButton(
                              onPressed: () {
                                Highlight.createItem(
                                    hold['verse'], hold['name']);
                                refresher();
                              },
                              child: Text('undo'),
                            ),
                            title: Text('Bookmark removed'),
                          )));

                      // if (delete) {
                      Highlight.deleteItem(_highlights[index]['id']);
                      refresher();
                      // }
                    },
                    child: ListTile(
                      tileColor: currentTheme == Brightness.dark
                          ? Color.fromARGB(255, 0, 4, 17)
                          : Colors.white,
                      // onTap: () {
                      //   Highlight.deleteItem(_highlights[index]['id']);
                      //   refresher();
                      // },
                      title: Text('${_highlights[index]['verse']}'),
                      subtitle: Text(
                        '${_highlights[index]['name']}',
                        style: TextStyle(
                            color: Colors.grey, fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                ),
              );
            })
        : Center(
            child: Text('You highlight appears here'),
          );
    // appBar: AppBar(
    //   title: Text('demo'),
    // ),
  }
}
