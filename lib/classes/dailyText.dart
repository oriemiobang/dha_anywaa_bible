// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ffi';

// import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DailyVerse {
  late int _currentIndex = 0;
  late SharedPreferences indexStorage;

  // init() {
  //   // indexStorage = await SharedPreferences.getInstance();
  //   _currentIndex = indexStorage.getInt('getIndex') ?? 0;
  //   print('say someting $_currentIndex');
  // }

  // Future<void> _loadCurrentIndex() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   _currentIndex = prefs.getInt('daily_text_index') ?? 0;
  // }

  // DailyVerse(
  //   this._dailyVerseIndex,
  // );

  incrementIndex() async {
    indexStorage = await SharedPreferences.getInstance();
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    _currentIndex = indexStorage.getInt('getIndex') ?? 0;
    _currentIndex = (_currentIndex + 1) % dailyVerseList.length;
    print('insider class index: $_currentIndex');
    indexStorage.setInt('getIndex', _currentIndex);
  }

  int get getIndex => _currentIndex;
  // void setIndex(index) => _dailyVerseIndex = index;
  var dailyVerseList = [
    //  ø     ö     ï    ë  ä
    {
      "shortText": "Yïnu cwøl jwøki",
      "verse": "Mana Nyooth 3:20",
      "text": "'Ba neenï, a cuŋŋa dhi øtø, "
          "naa dööŋö. 'Ba ni näk da ŋat mo wïnynya "
          "dwøra, ni jap dhi øtø, a cøøa baŋe, ni "
          "cäma ki eni, ni ö eni ni cäme ki aani"
    },
    {
      "shortText": "Jwøk mëër ki ïnï",
      "verse": "Mana Nyooth 3:21",
      "text": "'Ba ŋato böödö, owëëga pïïn piny "
          "bäät wälla, keda mara na bööda, ni pïïa "
          "kanya ciel ki Wära bäät wälle."
    },
    //  ø     ö     ï    ë  ä
    {
      "shortText": "Jwøk mëër ki ïnï",
      "verse": 'Jøøn 1: 1-5',
      "text": " 1. Wïlöölö Dwøl nutö, ni Dwørøgøøni ena"
          " kanya ciel ki Jwøk, ni Dwørøgøøni"
          " beeye Jwøk.\n 2. Wïlöölö eni ena kanya"
          " ciel ki Jwøk. 3 Ni jammi bëët cwääc"
          " ka ree, ni bäŋ gïn mo ocwääö ri moa"
          " cwääc bëët, ni eni tøør ree.\n 4. Ni kwøw"
          " ena ree, ni kwøwøgøøni beeye na cïp"
          " tar jï jiy.\n 5. Ni tayøgø meenya muudhö,"
          " ni käri ya muudhe nää.",
    },
    {
      "shortText": "Yïnu cwøl jwøki",
      "verse": "Aydheea 41:10",
      "text": "Kärï lwäyö, kiper a nut buutï, "
          "ni ba bwøk cwïnyï, kiper aana "
          "Jwøk marï. "
          "Ï tïïa tïïö niï teek, ni kønya ïïni, "
          "ni jøla ïïni ki cer"
    },
    {
      "shortText": "Jwøk mëër ki ïnï",
      "verse": "Jøøn 16:33",
      "text": "Man en a caana jïïu, nee bëët-mëër nee "
          "jootu baŋa. Uuni, gïï mo leth ojwørru "
          "yi pinyi en. 'Ba magu cwïnynyu, kiper "
          "piny yaa nø böötö."
    },
    {
      "shortText": "Yïnu cwøl jwøki",
      "verse": "Pilipay 4:6-7",
      "text": "6 Kär dee gïn lääŋŋu ki cwïnynyu, 'ba "
          "ki yïth jammi bëët, gïn wäro manynyu "
          "wäru pëënynyu ki Jwøk nou lämö, nou "
          "kwaya eni, nou dwøga met ec baŋe.\n"
          "7 'Ba leec cwïny man wø cïp Jwøki, na "
          "näk ba løny ki par, cwïnynyu ogwøe "
          "ka acaayu ki ri Krictø Jecu."
    },
    {
      "shortText": "Jwøk mëër ki ïnï",
      "verse": "Mana Nyooth 21:4",
      "text": "Ba Jwøk ki dëëre obëëdö ki geni,\n 4 ni "
          "pooc pï nyeŋge bëët, ni ö thøøe ni bäŋe "
          "gø këët. Ni bäŋ kïmmö, wala oduuru "
          "mo di gøø, wala rääm këët. Kiper japa "
          "dïkwøŋ oaay.»"
    },
    // {
    //   "shortText": "Yïnu cwøl jwøki",
    //   "verse": "1 Piter 5:6-7",
    //   "text": "6 Kiper manøgønø, døøyu dëëtu mo"
    //       "mwöl nou ena cer Jwøk na teek, kiper"
    //       "nee u røønye kanya näk kare.\n 7 Cïbu"
    //       "gïï wø pär cwïnynyu ki geni cere,"
    //       "kiper eni lääŋŋa uuni"
    // },
    // {
    //   "shortText": "Jwøk mëër ki ïnï",
    //   "verse": "Pilipay 2:3-4",
    //   "text": "atöör, 'ba beerra man caarru"
    //       "gïr jiy møga, ni beyø geni ki uuni, nou"
    //       "mwöl.\n 4 'Ba kär dee ŋat ŋäc dëëre keere."
    //       "'Ba uuni, beerra man ŋäyu jiy møga"
    //       "thuwø."
    // },
    // {
    //   "shortText": "Yïnu cwøl jwøki",
    //   "verse": "Röm 8:28",
    //   "text": "'Ba ŋääø ni Jwøk tïïö ri jammi bëët"
    //       "nee bëënyge jï jøw wø mëër ki eni, jøøa"
    //       "näk ee cwølø keda mana manynye."
    // },
    // {
    //   "shortText": "Jwøk mëër ki ïnï",
    //   "verse": "Jøcua 1:9",
    //   "text": "9 Ennø, a köömma"
    //       "ïïni. Mak riï ni bëëdï niï teek; ni ba"
    //       "bwøk cwïnyï ni ba lwäyï, kiper a na"
    //       "Wuuö Jwøk na näk Jwøk marï, a ena"
    //       "buutï kany wø ciï yie jaak."
    // },
    // {
    //   "shortText": "Yïnu cwøl jwøki",
    //   "verse": "Mathiew 6:31-34",
    //   "text": "31 Kiper manøgønø, kär"
    //       "dee gïn lääŋŋu, nou köö, na ‹?Agïnaŋø"
    //       "noo camø?› Nou köö, na ‹?Agïnaŋø noo"
    //       "maadhø?› Nou köö, na ‹?Agïnaŋø noo"
    //       "røø dëëtø?›\n 32 Kiper gïïögø bëët cac"
    //       "juurre cayø. 'Ba Wääu ni en maal ŋääe"
    //       "nou can ki gïïögø bëët.\n 33 'Ba kwøŋu buc"
    //       "Jwøk ki beeny Jwøk cayø. Køøre nø,"
    //       "gïïögø bëët owëëk uuni thuwø.\n"
    //       "34 «Kiper manøgønø, kär dee gïn"
    //       "lääŋŋu kiper diøø. Kiper diøø dëëre"
    //       "olääŋŋe keere. Cäŋ man nø da moe."
    // },

    // {
    //   "shortText": "Jwøk mëër ki ïnï",
    //   "verse": "Röm 15:13",
    //   "text": "13 'Ba Jwøk ni wø cïp ŋäädhe, cwïnynyu"
    //       "opääŋe ki met ec mo päl ki mëër ki"
    //       "køør mana jïëyu, kiper nee ŋäädhe"
    //       "maru pälle ki køør teek Jwïëc Jwøk"
    //       "na en kur keere"
    // },
  ];
}
