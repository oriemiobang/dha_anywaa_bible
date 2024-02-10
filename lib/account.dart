// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    Brightness currentTheme = Theme.of(context).brightness;
    return
        // appBar: AppBar(
        //   title: Text('demo'),
        // ),
        Column(
      children: [
        Card(
          color: currentTheme == Brightness.light
              ? Colors.white
              : const Color.fromARGB(255, 1, 11, 36),
          child: ListTile(
            title: Text(
              'Køør kanya ö Eberri na nywøl wääde ma Pelek, '
              ' ena cäŋ bëëtö ki cwiiri ma dïpe aŋween ki pïëradäk, '
              ' ni nyööde ki wääte ki nyïïe møøk.',
              style: TextStyle(),
            ),
          ),
        ),
        Card(
          color: currentTheme == Brightness.light
              ? Colors.white
              : const Color.fromARGB(255, 1, 11, 36),
          child: ListTile(
            title: Text(
              'Køør kanya ö Eberri na nywøl wääde ma Pelek, '
              ' ena cäŋ bëëtö ki cwiiri ma dïpe aŋween ki pïëradäk, '
              ' ni nyööde ki wääte ki nyïïe møøk.',
              style: TextStyle(),
            ),
          ),
        ),
        Card(
          color: currentTheme == Brightness.light
              ? Colors.white
              : const Color.fromARGB(255, 1, 11, 36),
          child: ListTile(
            title: Text(
              'Køør kanya ö Eberri na nywøl wääde ma Pelek, '
              ' ena cäŋ bëëtö ki cwiiri ma dïpe aŋween ki pïëradäk, '
              ' ni nyööde ki wääte ki nyïïe møøk.',
              style: TextStyle(),
            ),
          ),
        ),
      ],
    );
  }
}
