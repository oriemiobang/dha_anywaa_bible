import 'package:flutter/material.dart';

class DailyText extends StatefulWidget {
  const DailyText({super.key});

  @override
  State<DailyText> createState() => _DailyTextState();
}

class _DailyTextState extends State<DailyText> {
  @override
  Widget build(BuildContext context) {
    return Text('Read your bible today', style: TextStyle(color: Colors.white));
  }
}
