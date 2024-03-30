// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ffi';

// import 'package:
//
// flutter/material.dart';
import 'package:dha_anywaa_bible/classes/font_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DailyVerse {
  //  SelectedFontStyle style = SelectedFontStyle()..init();
  DailyVerse() {
    getLang();
  }

  void getLang() async {
    _language = await style.getLanguageVersion();
    print(_language.split(' ')[0]);
    _language = _language.split(' ')[0];
  }

  SelectedFontStyle style = SelectedFontStyle()..init();
  static String _language = '';
  late int _currentIndex = 0;
  late SharedPreferences indexStorage;

  incrementIndex() async {
    indexStorage = await SharedPreferences.getInstance();
    _currentIndex = indexStorage.getInt('getIndex') ?? 0;
    _currentIndex = (_currentIndex + 1) % dailyVerseList.length;
    print('insider class index: $_currentIndex');
    indexStorage.setInt('getIndex', _currentIndex);
  }

  int get getIndex => _currentIndex;
  var dailyVerseList = [
    //  ø     ö     ï    ë  ä
    {
      "shortText": _language == 'AMH'
          ? ''
          : _language == 'ANY'
              ? "Yïnu cwøl jwøki"
              : 'God wants you!',
      "verse": _language == 'AMH'
          ? 'የዮሐንስ ራእይ 3:20'
          : _language == 'ANY'
              ? "Mana Nyooth 3:20"
              : 'Revelation 3 : 20',
      "text": _language == 'AMH'
          ? 'እነሆ በደጅ ቆሜ አንኳኳለሁ፤ ማንም ድምፄን ቢሰማ ደጁንም '
              ' ቢከፍትልኝ፥ ወደ እርሱ እገባለሁ ከእርሱም ጋር እራት እበላለሁ እርሱም ከእኔ ጋር ይበላል።'
          : _language == 'ANY'
              ? "'Ba neenï, a cuŋŋa dhi øtø, "
                  "naa dööŋö. 'Ba ni näk da ŋat mo wïnynya "
                  "dwøra, ni jap dhi øtø, a cøøa baŋe, ni "
                  "cäma ki eni, ni ö eni ni cäme ki aani"
              : 'Here I am! I stand at the door and knock. '
                  'If anyone hears my voice and opens the door, '
                  'I will come in and eat with that person, and they with me.'
    },
    {
      "shortText": _language == 'AMH'
          ? ''
          : _language == 'ANY'
              ? "Ciri kir cïppï"
              : 'Never give up!',
      "verse": _language == 'AMH'
          ? 'የዮሐንስ ራእይ 3:20'
          : _language == 'ANY'
              ? "Mana Nyooth 3:21"
              : 'Revelation 3 : 21',
      "text": _language == 'AMH'
          ? 'እኔ ደግሞ ድል እንደ ነሣሁ ከአባቴም ጋር በዙፋኑ ላይ እንደተቀመጥሁ፥ ድል ለነሣው ከእኔ ጋር በዙፋኔ ላይ ይቀመጥ ዘንድ እሰጠዋለሁ።'
          : _language == 'ANY'
              ? "'Ba ŋato böödö, owëëga pïïn piny "
                  "bäät wälla, keda mara na bööda, ni pïïa "
                  "kanya ciel ki Wära bäät wälle."
              : 'To the one who is victorious, '
                  'I will give the right to sit with me on my throne, just as I was '
                  'victorious and sat down with my Father on his throne.'
    },
    //  ø     ö     ï    ë  ä
    {
      "shortText": _language == 'AMH'
          ? ''
          : _language == 'ANY'
              ? "Jwøk nut piny bärë!"
              : 'God is everywhere!',
      "verse": _language == 'AMH'
          ? 'የዮሐንስ ወንጌል 1: 1-5'
          : _language == 'ANY'
              ? 'Jøøn 1: 1-5'
              : 'John 1: 1-5',
      "text": _language == 'AMH'
          ? 'መጀመሪያው ቃል ነበረ፥ ቃልም በእግዚአብሔር ዘንድ ነበረ፥ ቃልም እግዚአብሔር ነበረ። '
              'ይህ በመጀመሪያው በእግዚአብሔር ዘንድ ነበረ። '
              'ሁሉ በእርሱ ሆነ፥ ከሆነውም አንዳች ስንኳ ያለ እርሱ አልሆነም። '
              'በእርሱ ሕይወት ነበረች፥ ሕይወትም የሰው ብርሃን ነበረች። '
              'ብርሃንም በጨለማ ይበራል፥ ጨለማም አላሸነፈውም።'
          : _language == 'ANY'
              ? " 1. Wïlöölö Dwøl nutö, ni Dwørøgøøni ena"
                  " kanya ciel ki Jwøk, ni Dwørøgøøni"
                  " beeye Jwøk.\n 2. Wïlöölö eni ena kanya"
                  " ciel ki Jwøk. 3 Ni jammi bëët cwääc"
                  " ka ree, ni bäŋ gïn mo ocwääö ri moa"
                  " cwääc bëët, ni eni tøør ree.\n 4. Ni kwøw"
                  " ena ree, ni kwøwøgøøni beeye na cïp"
                  " tar jï jiy.\n 5. Ni tayøgø meenya muudhö,"
                  " ni käri ya muudhe nää."
              : ' In the beginning was the Word, '
                  'and the Word was with God, and the Word was God. '
                  '2 He was with God in the beginning. 3 Through him '
                  'all things were made; without him nothing was made '
                  'that has been made. 4 In him was life, and that life '
                  'was the light of all mankind. 5 The light shines in the darkness, '
                  'and the darkness has not overcome it.',
    },
    {
      "shortText": _language == 'AMH'
          ? ''
          : _language == 'ANY'
              ? "jwøk nuttö ki ïnï cooth"
              : 'God is always with you!',
      "verse": _language == 'AMH'
          ? 'ትንቢተ ኢሳይያስ 41:10'
          : _language == 'ANY'
              ? "Aydheea 41:10"
              : 'Isaiah 41:10',
      "text": _language == 'AMH'
          ? ' እኔ ከአንተ ጋር ነኝና አትፍራ፤ እኔ አምላክህ ነኝና አትደንግጥ፤ አበረታሃለሁ፥ እረዳህማለሁ፥ በጽድቄም ቀኝ ደግፌ እይዝሃለሁ።'
          : _language == 'ANY'
              ? "Kärï lwäyö, kiper a nut buutï, "
                  "ni ba bwøk cwïnyï, kiper aana "
                  "Jwøk marï. "
                  "Ï tïïa tïïö niï teek, ni kønya ïïni, "
                  "ni jøla ïïni ki cer"
              : 'So do not fear, for I am with you; '
                  'do not be dismayed, for I am your God. '
                  'I will strengthen you and help you; '
                  'I will uphold you with my righteous right hand.'
    },
    {
      "shortText": _language == 'AMH'
          ? ''
          : _language == 'ANY'
              ? "Jwøk amëër."
              : 'God is love.',
      "verse": _language == 'AMH'
          ? 'የዮሐንስ ወንጌል 16:33'
          : _language == 'ANY'
              ? "Jøøn 16:33"
              : 'John 16:33',
      "text": _language == 'AMH'
          ? 'በእኔ ሳላችሁ ሰላም እንዲሆንላችሁ ይህን ተናግሬአችኋለሁ። በዓለም ሳላችሁ መከራ አለባችሁ፤ ነገር ግን አይዞአችሁ፤ እኔ ዓለምን አሸንፌዋለሁ።'
          : _language == 'ANY'
              ? "Man en a caana jïïu, nee bëët-mëër nee "
                  "jootu baŋa. Uuni, gïï mo leth ojwørru "
                  "yi pinyi en. 'Ba magu cwïnynyu, kiper "
                  "piny yaa nø böötö."
              : '“I have told you these things, so that in me '
                  'you may have peace. In this world you will have trouble. '
                  'But take heart! I have overcome the world.”'
    },
    {
      "shortText": _language == 'AMH'
          ? ''
          : _language == 'ANY'
              ? "Yïnu cwøl jwøki"
              : 'God wants you',
      "verse": _language == 'AMH'
          ? 'ወደ ፊልጵስዩስ ሰዎች 4:6-7'
          : _language == 'ANY'
              ? "Pilipay 4:6-7"
              : 'Philippians 4:6-7',
      "text": _language == 'AMH'
          ? 'ጌታ ቅርብ ነው። በነገር ሁሉ በጸሎትና በምልጃ ከምስጋና ጋር በእግዚአብሔር ዘንድ ልመናችሁን አስታውቁ እንጂ በአንዳች አትጨነቁ። '
              'አእምሮንም ሁሉ የሚያልፍ የእግዚአብሔር ሰላም ልባችሁንና አሳባችሁን በክርስቶስ ኢየሱስ ይጠብቃል።'
          : _language == 'ANY'
              ? "6 Kär dee gïn lääŋŋu ki cwïnynyu, 'ba "
                  "ki yïth jammi bëët, gïn wäro manynyu "
                  "wäru pëënynyu ki Jwøk nou lämö, nou "
                  "kwaya eni, nou dwøga met ec baŋe.\n"
                  "7 'Ba leec cwïny man wø cïp Jwøki, na "
                  "näk ba løny ki par, cwïnynyu ogwøe "
                  "ka acaayu ki ri Krictø Jecu."
              : '6 Do not be anxious about anything, '
                  'but in every situation, by prayer and petition, '
                  'with thanksgiving, present your requests to God. '
                  '7 And the peace of God, which transcends all understanding, '
                  'will guard your hearts and your minds in Christ Jesus.'
    },
    {
      "shortText": _language == 'AMH'
          ? ''
          : _language == 'ANY'
              ? "Jwøk mëër ki ïnï"
              : 'God loves you',
      "verse": _language == 'AMH'
          ? 'የዮሐንስ ራእይ 21:4'
          : _language == 'ANY'
              ? "Mana Nyooth 21:4"
              : 'Revelation 21 : 4',
      "text": _language == 'AMH'
          ? 'እንባዎችንም ሁሉ ከዓይኖቻቸው ያብሳል፥ ሞትም ከእንግዲህ ወዲህ አይሆንም፥ ኀዘንም ቢሆን ወይም ጩኸት ወይም ሥቃይ ከእንግዲህ ወዲህ አይሆንም፥ የቀደመው ሥርዓት አልፎአልና ብሎ ሲናገር ሰማሁ።'
          : _language == 'ANY'
              ? "Ba Jwøk ki dëëre obëëdö ki geni,\n 4 ni "
                  "pooc pï nyeŋge bëët, ni ö thøøe ni bäŋe "
                  "gø këët. Ni bäŋ kïmmö, wala oduuru "
                  "mo di gøø, wala rääm këët. Kiper japa "
                  "dïkwøŋ oaay.»"
              : 'God himself will be with them and be their God...'
                  '‘He will wipe every tear from their eyes. '
                  'There will be no more death’ or mourning or '
                  'crying or pain, for the old order of things has passed away.”'
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
