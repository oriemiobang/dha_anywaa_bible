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
    return
        // appBar: AppBar(
        //   title: Text('demo'),
        // ),
        Text(
      'Your Text here',
      style: TextStyle(color: Colors.white),
    );
  }
}
