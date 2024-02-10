import 'package:flutter/material.dart';

class Pray extends StatefulWidget {
  const Pray({super.key});

  @override
  State<Pray> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Pray> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.share))],
      ),
      body: Center(
          child: Text(
              ' Wuuö Jwøk acäänö ka Abram, ni kööe, ni «Wec pou ki tuuŋu ki dhi øt wäru, ni ciï yi ŋöömmo nyoodha jïrï.')),
    );
  }
}
