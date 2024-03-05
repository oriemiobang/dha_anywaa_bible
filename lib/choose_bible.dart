// ignore_for_file: prefer_const_constructors

import 'package:dha_anywaa_bible/classes/font_style.dart';
import 'package:flutter/material.dart';

class ChooseBible extends StatefulWidget {
  const ChooseBible({super.key});

  @override
  State<ChooseBible> createState() => _ChooseBibleState();
}

class _ChooseBibleState extends State<ChooseBible> {
  List<Map<String, dynamic>> bibleVersons = [
    {
      'name': 'Dha anywaa',
      'abbrev': 'ANY',
      'description': 'The Bible was translated into the Anyua language so that the word of God could reach the Anyua people.'
          '\nThe translation took place in Akobo, Sudan, in 1948. It began with the New Testament.'
          '\n\nIn 1962, the translation was completed in Sudan and published by the Bible Society in America, written in Latin.'
          ' Later, in 1965, it was brought to Ethiopia and written in the Amharic script, making it accessible to the Anyua people in Ethiopia.'
          '\n\nAfter several years, the entire Bible was translated into the Anyua language.',
      'isExpanded': false,
    },
    {
      'name': 'Amharic',
      'abbrev': 'AMH',
      'description': '',
      'isExpanded': false,
    },
    {
      'name': 'Amplified Bible',
      'abbrev': 'AMP',
      'description': '',
      'isExpanded': false,
    },
    {
      'name': 'American Standard Version',
      'abbrev': 'ASV',
      'description': '',
      'isExpanded': false,
    },
    {
      'name': 'Catholic Public Domain Version',
      'abbrev': 'CPDV',
      'description': '',
      'isExpanded': false,
    },
    {
      'name': 'Easy-to-Read Version',
      'abbrev': 'ERV',
      'description': '',
      'isExpanded': false,
    },
    {
      'name': 'English Standard Version',
      'abbrev': 'ESV',
      'description': '',
      'isExpanded': false,
    },
    {
      'name': 'King James Version',
      'abbrev': 'KJV',
      'description': '',
      'isExpanded': false,
    },
    {
      'name': 'New American Standard Bible',
      'abbrev': 'NASB',
      'description': '',
      'isExpanded': false,
    },
    {
      'name': 'World English Bible',
      'abbrev': 'WEB',
      'description': '',
      'isExpanded': false,
    },
  ];

  void getLanguageVersion() async {
    String currentLanguageVersion =
        await selectedFontStyle.getLanguageVersion();
    currentLanguageVersion = currentLanguageVersion.split(' ')[0];

    setState(() {
      _currentLanguageVersion = currentLanguageVersion;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLanguageVersion();
  }

  SelectedFontStyle selectedFontStyle = SelectedFontStyle();
  String _currentLanguageVersion = '';
  String currentAbbrev = '';

  _updateVersion(value) async {
    final currentVersion = await selectedFontStyle.getBibleVersion();
    // String v = currentVersion
    var splitVersion = currentVersion.split('/');
    selectedFontStyle
        .setBibleVersion('${splitVersion[0]}/${splitVersion[1]}/$value.json');
    print(currentVersion);
    print('${splitVersion[0]}/${splitVersion[1]}/$value.json');
  }

  @override
  Widget build(BuildContext context) {
    Brightness currentTheme = Theme.of(context).brightness;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Languages'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Choose a language'),
            ExpansionPanelList(
              // expandIconColor: _currentLanguageVersion == currentAbbrev
              //     ? Colors.amber
              //     : null,
              dividerColor: Colors.transparent,
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  setState(() {
                    bibleVersons[index]['isExpanded'] =
                        !bibleVersons[index]['isExpanded'];
                  });
                });
              },
              children: bibleVersons.map<ExpansionPanel>((item) {
                return ExpansionPanel(
                  backgroundColor: currentTheme == Brightness.dark
                      ? Color.fromARGB(255, 0, 4, 17)
                      : Colors.white,
                  headerBuilder: (BuildContext context, bool isExpanded) =>
                      ListTile(
                    leading: _currentLanguageVersion == item['abbrev']
                        ? Icon(
                            Icons.check,
                            color: Colors.amber,
                          )
                        : Icon(null),
                    title: Text(
                      '${item['abbrev']}',
                      style: TextStyle(
                          color: _currentLanguageVersion == item['abbrev']
                              ? Colors.amber
                              : null),
                    ),
                    subtitle: Text(
                      '${item['name']}',
                      style: TextStyle(
                          color: _currentLanguageVersion == item['abbrev']
                              ? Colors.amber
                              : Colors.grey),
                    ),
                    onTap: () {
                      selectedFontStyle.setLanguageVersion(
                          '${item['abbrev']} ${item['name']}');
                      setState(() {
                        currentAbbrev = item['abbrev'];
                        _updateVersion(currentAbbrev);
                        _currentLanguageVersion = item['abbrev'];
                      });
                    },
                  ),
                  body: ListTile(
                    title: Text('${item['description']}'),
                  ),
                  isExpanded: item['isExpanded'],
                );
              }).toList(),
            ),
          ]),
        ),
      ),
    );
  }
}
