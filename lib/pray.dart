import 'dart:async';

import 'package:flutter/material.dart';

class Pray extends StatefulWidget {
  const Pray({super.key});

  @override
  State<Pray> createState() => _PrayState();
}

class _PrayState extends State<Pray> {
  var prayer = [
    {
      "verse": "Duut pwoc 5: 2-3",
      "text": "2 Ï na nyeya mara ni bee ï Jwøa,"
          "wïny oduuru mara,"
          "kiper a wø kwaaya ïïni.\n"
          "3 Wui Wuuö Jwøk, ka amöölla"
          "dwøra wø wïnynyï wïnynyö,"
          "kany wø läma naa køya man wø"
          "løgï jïra."
    },
    {
      "verse": "Luk 11: 2-4",
      "text": "2 ...Wääwa, nyeŋŋï wøør. Buyï ööe.\n"
          "3 Wëëk wa jïtö ki cam ki yïth nïne bëët.\n"
          "4 Ni weyï moa bacwa, kiper waani"
          "thuwø, jø wø bääö dëëtwa bëët wø"
          "wecwa wiiø. Ni ba bwødhï wa kany"
          "mo wa di päänynyö yie."
    },
    {
      "verse": "Duut Pwoc 16: 7-8",
      "text": "Aani Wuuö Jwøk wø pwøa pwøø,"
          "eni ni wø pwöny aani;"
          "ki wäär thuwø, acaare moe na"
          "näk yaa kan cwïnya wø cäŋa"
          "cïpö ki pwöc jïra.\n"
          "8 Aani a wø bëëdö naa lääŋŋa"
          "Wuuö Jwøk cooth;"
          "a ba pädhi kiper mana bëëde ni"
          "eni nut buuta"
    },
    {
      "verse": "1 Wëël Luup Nyeye 4:10",
      "text": "Gwïëth aani, Wuuö Jwøk, ni mooyï"
          "aani ki ŋøøm mo thööth; gwøk aani,"
          "ni koorï aani ceŋ gïï mo leth, nee bäŋe"
          "gïn mo leth mo pïï dëëra."
    },
    {
      "verse": "Dut Pwøc 143:8",
      "text": "Beerra man wëëgï aani wïny"
          "luum mëër marï ni wø ba jøøl"
          "kany wø pääa ka amöölla,"
          "kiper a bëëdö niï yaa gum cwïnya."
          "Pwöny aani ki jöör bëëtö mana"
          "daa bëëdö ki gø,"
    },
    {
      "verse": "Dut Pwøc 73:26",
      "text": "Løny ki man ö rïŋ dëëra ni"
          "ränynye, ni päth cwïnya,"
          "'ba ï na Jwøk, ï poot bëëdö ni"
          "ïïna teek mara,"
          "ni bëëdï ni ïïna kura na bäre bäre."
    },
    {
      "verse": "Aydheea 54:17",
      "text": "Bäŋ gïr leny mo di thäädhö kiper"
          "ränynyö marï mo thura kare."
          "Jiy bëët moo kïth luup bäätï kar"
          "løøk böötï böötö..."
    },
    // {"verse": "", "text": ""},
    // {"verse": "12", "text": ""},
    // {"verse": "12", "text": ""},
    // {"verse": "12", "text": ""},
  ];

  String currentMessage = '';
  String currentVerse = '';
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _updateMessage();
  }

  _updateMessage() {
    DateTime nowTime = DateTime.now();
    print("Current Hour: ${nowTime.hour}");

    if (nowTime.hour < 6 && nowTime.hour >= 12) {
      setState(() {
        currentMessage = prayer[currentIndex]['text']!;
        currentVerse = prayer[currentIndex]['verse']!;
      });

      // Increment the index for the next message
      currentIndex = (currentIndex + 1) % prayer.length;

      print("Updated Message: $currentMessage");
      print("Updated Verse: $currentVerse");
    } else {
      currentMessage = prayer[currentIndex]['text']!;
      currentVerse = prayer[currentIndex]['verse']!;
      print("Not in the morning hours. Skipping update.");
    }

    // Schedule the next update for the next morning
    Duration timeUntilMorning = Duration(
      hours: 24 - nowTime.hour,
      minutes: 60 - nowTime.minute,
      seconds: 60 - nowTime.second,
    );

    Timer(timeUntilMorning, _updateMessage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.share))],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 18, right: 18),
        child: Column(
          children: [
            Text(
              'Lam mar dïcängï',
              style: TextStyle(fontSize: 28),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 35),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    prayer[3]['verse']!,
                    style: TextStyle(
                        color: Colors.grey, fontStyle: FontStyle.italic),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  SelectableText(
                    prayer[3]['text']!,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
