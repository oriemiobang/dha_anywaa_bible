// import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Reference extends StatelessWidget {
  const Reference({super.key});

  @override
  Widget build(BuildContext context) {
    Brightness currentTheme = Theme.of(context).brightness;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentTheme == Brightness.dark
            ? Color.fromARGB(255, 0, 4, 17)
            : Colors.white,
      ),
      padding: EdgeInsets.only(top: 35, right: 20, left: 20, bottom: 30),
      // color: Colors.amber,
      child: SingleChildScrollView(
        child: Text(
          " 1. Wïlöölö Dwøl nutö, ni Dwørøgøøni ena"
          " kanya ciel ki Jwøk, ni Dwørøgøøni"
          " beeye Jwøk.\n 2. Wïlöölö eni ena kanya"
          " ciel ki Jwøk. 3 Ni jammi bëët cwääc"
          " ka ree, ni bäŋ gïn mo ocwääö ri moa"
          " cwääc bëët, ni eni tøør ree.\n 4. Ni kwøw"
          " ena ree, ni kwøwøgøøni beeye na cïp"
          " tar jï jiy.\n 5. Ni tayøgø meenya muudhö,"
          " ni käri ya muudhe nää."
          " 1. Wïlöölö Dwøl nutö, ni Dwørøgøøni ena"
          " kanya ciel ki Jwøk, ni Dwørøgøøni"
          " beeye Jwøk.\n 2. Wïlöölö eni ena kanya"
          " ciel ki Jwøk. 3 Ni jammi bëët cwääc"
          " ka ree, ni bäŋ gïn mo ocwääö ri moa"
          " cwääc bëët, ni eni tøør ree.\n 4. Ni kwøw"
          " ena ree, ni kwøwøgøøni beeye na cïp"
          " tar jï jiy.\n 5. Ni tayøgø meenya muudhö,"
          " ni käri ya muudhe nää."
          " 1. Wïlöölö Dwøl nutö, ni Dwørøgøøni ena"
          " kanya ciel ki Jwøk, ni Dwørøgøøni"
          " beeye Jwøk.\n 2. Wïlöölö eni ena kanya"
          " ciel ki Jwøk. 3 Ni jammi bëët cwääc"
          " ka ree, ni bäŋ gïn mo ocwääö ri moa"
          " cwääc bëët, ni eni tøør ree.\n 4. Ni kwøw"
          " ena ree, ni kwøwøgøøni beeye na cïp"
          " tar jï jiy.\n 5. Ni tayøgø meenya muudhö,"
          " ni käri ya muudhe nää."
          " 1. Wïlöölö Dwøl nutö, ni Dwørøgøøni ena"
          " kanya ciel ki Jwøk, ni Dwørøgøøni"
          " beeye Jwøk.\n 2. Wïlöölö eni ena kanya"
          " ciel ki Jwøk. 3 Ni jammi bëët cwääc"
          " ka ree, ni bäŋ gïn mo ocwääö ri moa"
          " cwääc bëët, ni eni tøør ree.\n 4. Ni kwøw"
          " ena ree, ni kwøwøgøøni beeye na cïp"
          " tar jï jiy.\n 5. Ni tayøgø meenya muudhö,"
          " ni käri ya muudhe nää.",
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
