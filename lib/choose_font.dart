import 'package:flutter/material.dart';

class ChooseFont extends StatefulWidget {
  const ChooseFont({super.key});

  @override
  State<ChooseFont> createState() => _ChooseBibleState();
}

class _ChooseBibleState extends State<ChooseFont> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select font type'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Text('Choose a language'),
          ListTile(
            title: Text('Untitled Serif'),
          ),
          ListTile(
            title: Text('Gentuim Plus'),
          ),
          ListTile(
            title: Text('Roboto Serif'),
          ),
          ListTile(
            title: Text('Robobto Sans'),
          ),
          ListTile(
            title: Text('Robobto Sans Mono'),
          ),
        ]),
      ),
    );
  }
}
