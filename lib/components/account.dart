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
                              color: const Color.fromARGB(255, 4, 74, 131),
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
                          backgroundColor: currentTheme == Brightness.dark
                              ? Color.fromARGB(255, 0, 4, 17)
                              : Colors.white,
                          content: ListTile(
                            trailing: TextButton(
                              onPressed: () {
                                Highlight.createItem(
                                    hold['verse'],
                                    hold['name'],
                                    hold['date'],
                                    hold['version']);
                                refresher();
                              },
                              child: Text('undo'),
                            ),
                            title: Text('Bookmark removed'),
                          )));
                      Highlight.deleteItem(_highlights[index]['id']);
                      refresher();
                      // }
                    },
                    child: ListTile(
                      tileColor: currentTheme == Brightness.dark
                          ? Color.fromARGB(255, 0, 4, 17)
                          : Colors.white,
                      title: Text('${_highlights[index]['verse']}'),
                      subtitle: Text(
                        '${_highlights[index]['name']}  |   ${_highlights[index]['date']}   |  ${_highlights[index]['version']}',
                        style: TextStyle(
                            color: Colors.grey, fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                ),
              );
            })
        : Center(
            child: Text('Your bookmarks appear here'),
          );
  }
}
