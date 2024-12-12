import 'package:dha_anywaa_bible/classes/font_style.dart';
import 'package:flutter/material.dart';

class ChooseFont extends StatefulWidget {
  const ChooseFont({super.key});

  @override
  State<ChooseFont> createState() => _ChooseBibleState();
}

class _ChooseBibleState extends State<ChooseFont> {
  String selectedFont = 'Untitled Serif';
  SelectedFontStyle selectedFontStyle = SelectedFontStyle();

  void setSelectedFont() async {
    final fontstyle = await selectedFontStyle.getFontStyle();
    setState(() {
      selectedFont = fontstyle;
    });
  }

  void setFontStyle(String font) async {
    await selectedFontStyle.setFontStyle(font);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setSelectedFont();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select font type'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ListTile(
            onTap: () {
              setState(() {
                selectedFont = 'UntitledSerif';
                setFontStyle('UntitledSerif');
              });
            },
            leading: selectedFont == 'UntitledSerif'
                ? const Icon(Icons.check)
                : const Icon(null),
            title: const Text(
              'Untitled Serif',
              style: TextStyle(fontFamily: 'UntitledSerif', fontSize: 17),
            ),
          ),
          ListTile(
            onTap: () {
              setState(() {
                selectedFont = 'Garamond';
                setFontStyle('Garamond');
              });
            },
            leading: selectedFont == 'Garamond'
                ? const Icon(Icons.check)
                : const Icon(null),
            title: const Text(
              'Garamond',
              style: TextStyle(fontFamily: 'Garamond', fontSize: 17),
            ),
          ),
          ListTile(
            onTap: () {
              setState(() {
                selectedFont = 'RobotoSerif';
                setFontStyle('RobotoSerif');
              });
            },
            leading: selectedFont == 'RobotoSerif'
                ? const Icon(Icons.check)
                : const Icon(null),
            title: const Text(
              'Roboto Serif',
              style: TextStyle(fontFamily: 'RobotoSerif', fontSize: 17),
            ),
          ),
          ListTile(
            onTap: () {
              setState(() {
                selectedFont = 'RobotoRegular';
                setFontStyle('RobotoRegular');
              });
            },
            leading: selectedFont == 'RobotoRegular'
                ? const Icon(Icons.check)
                : const Icon(null),
            title: const Text(
              'Roboto Sans',
              style: TextStyle(fontFamily: 'RobotoRegular', fontSize: 17),
            ),
          ),
          ListTile(
            onTap: () {
              setState(() {
                selectedFont = 'RobotoMono';
                setFontStyle('RobotoMono');
              });
            },
            leading: selectedFont == 'RobotoMono'
                ? const Icon(Icons.check)
                : const Icon(null),
            title: const Text(
              'Roboto Sans Mono',
              style: TextStyle(fontFamily: 'RobotoMono', fontSize: 17),
            ),
          ),
        ]),
      ),
    );
  }
}
