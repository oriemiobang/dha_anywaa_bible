import 'dart:async';

import 'package:dha_anywaa_bible/HomePage.dart';
import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const HomePage(),
        ),
      );
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar: AppBar(),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 180,
            ),
            Center(
              child: Image(
                image: AssetImage("assets/images/weel_jwok_icon.png"),
                height: 230,
              ),
            ),
            SizedBox(
              height: 180,
            ),
            Text(
              'June 25 2024',
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: 'UntitledSerif'),
            ),
            Text(
              'Bella Tech',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontFamily: 'UntitledSerif'),
            )
          ]),
    );
  }
}
