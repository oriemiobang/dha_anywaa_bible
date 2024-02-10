import 'package:flutter/material.dart';

class ChooseBible extends StatefulWidget {
  const ChooseBible({super.key});

  @override
  State<ChooseBible> createState() => _ChooseBibleState();
}

class _ChooseBibleState extends State<ChooseBible> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Languages'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Choose a language'),
          ListTile(
            title: Text('Dha Anywaa'),
            subtitle: Text('Weel jwok'),
          ),
          ListTile(
            title: Text('English'),
            subtitle: Text('King james'),
          ),
          ListTile(
            title: Text('Amharic'),
            subtitle: Text('Mesaf Kidus'),
          ),
        ]),
      ),
    );
  }
}
