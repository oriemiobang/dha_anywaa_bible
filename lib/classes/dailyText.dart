// ignore_for_file: public_member_api_docs, sort_constructors_first

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
          ? 'አትጨነቁ።'
          : _language == 'ANY'
              ? "Ki yïth jammi bëët dwøk met ec baŋ Jwøk."
              : 'Always give thanks to God',
      "verse": _language == 'AMH'
          ? 'ወደ ፊልጵስዩስ ሰዎች 4:6-7'
          : _language == 'ANY'
              ? "Pilipay 4:6-7"
              : 'Philippians 4:6-7',
      "text": _language == 'AMH'
          ? 'ጌታ ቅርብ ነው። በነገር ሁሉ በጸሎትና በምልጃ ከምስጋና ጋር በእግዚአብሔር ዘንድ ልመናችሁን አስታውቁ እንጂ በአንዳች አትጨነቁ። '
              'አእምሮንም ሁሉ የሚያልፍ የእግዚአብሔር ሰላም ልባችሁንና አሳባችሁን በክርስቶስ ኢየሱስ ይጠብቃል።'
          : _language == 'ANY'
              ? "Kär dee gïn lääŋŋu ki cwïnynyu, 'ba "
                  "ki yïth jammi bëët, gïn wäro manynyu "
                  "wäru pëënynyu ki Jwøk nou lämö, nou "
                  "kwaya eni, nou dwøga met ec baŋe. "
                  "'Ba leec cwïny man wø cïp Jwøki, na "
                  "näk ba løny ki par, cwïnynyu ogwøe "
                  "ka acaayu ki ri Krictø Jecu."
              : 'Do not be anxious about anything, '
                  'but in every situation, by prayer and petition, '
                  'with thanksgiving, present your requests to God. '
                  'And the peace of God, which transcends all understanding, '
                  'will guard your hearts and your minds in Christ Jesus.'
    },

    {
      "shortText": _language == 'AMH'
          ? 'እግዚአብሔር ዓለምን አሸንፌዋል'
          : _language == 'ANY'
              ? "Jecu peny ee böötö"
              : 'God have overcome the world',
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
          ? 'ሁልጊዜ በጌታ ደስ ይበላችሁ'
          : _language == 'ANY'
              ? "Yïthu mïnge ki ri Wuuö cooth"
              : 'Rejoice in the Lord alway',
      "verse": _language == 'AMH'
          ? 'ወደ ፊልጵስዩስ ሰዎች 4:4, 6, 7'
          : _language == 'ANY'
              ? "Pilipay 4:4, 6, 7"
              : 'Philippians 4 : 4, 6, 7',
      "text": _language == 'AMH'
          ? "ሁልጊዜ በጌታ ደስ ይበላችሁ፤ ደግሜ እላለሁ፥ ደስ ይበላችሁ። "
              "ጌታ ቅርብ ነው። በነገር ሁሉ በጸሎትና በምልጃ ከምስጋና ጋር በእግዚአብሔር ዘንድ ልመናችሁን አስታውቁ እንጂ በአንዳች አትጨነቁ። "
              "አእምሮንም ሁሉ የሚያልፍ የእግዚአብሔር ሰላም ልባችሁንና አሳባችሁን በክርስቶስ ኢየሱስ ይጠብቃል።"
          : _language == 'ANY'
              ? "Yïthu mïnge ki ri Wuuö cooth, naa cäŋa gø caannø jïïu, ni yïthu mïnge. "
                  "Kär dee gïn lääŋŋu ki cwïnynyu, 'ba ki yïth jammi bëët, gïn wäro manynyu wäru pëënynyu ki Jwøk nou lämö, nou kwaya eni, nou dwøga met ec baŋe. "
                  "'Ba leec cwïny man wø cïp Jwøki, na näk ba løny ki par, cwïnynyu ogwøe ka acaayu ki ri Krictø Jecu."
              : "Rejoice in the Lord alway: and again I say, Rejoice. "
                  "Let your moderation be known unto all men. The Lord is at hand. "
                  "Be careful for nothing; but in every thing by prayer and supplication with thanksgiving let your requests be made known unto God."
    },
    {
      "shortText": _language == 'AMH'
          ? 'እነሆ በደጅ ቆሜ አንኳኳለሁ'
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
          ? 'ድል ለነሣው ከእኔ ጋር በዙፋኔ ላይ ይቀመጥ ዘንድ እሰጠዋለሁ'
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
          ? 'ሁሉ በእርሱ ሆነ'
          : _language == 'ANY'
              ? "jammi bëët cwääc"
                  "ki ri jecu"
              : 'Through him '
                  'all things were made;',
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
              ? " Wïlöölö Dwøl nutö, ni Dwørøgøøni ena"
                  " kanya ciel ki Jwøk, ni Dwørøgøøni"
                  " beeye Jwøk. Wïlöölö eni ena kanya"
                  " ciel ki Jwøk. Ni jammi bëët cwääc"
                  " ka ree, ni bäŋ gïn mo ocwääö ri moa"
                  " cwääc bëët, ni eni tøør ree. Ni kwøw"
                  " ena ree, ni kwøwøgøøni beeye na cïp"
                  " tar jï jiy. Ni tayøgø meenya muudhö,"
                  " ni käri ya muudhe nää."
              : ' In the beginning was the Word, '
                  'and the Word was with God, and the Word was God. '
                  'He was with God in the beginning. Through him '
                  'all things were made; without him nothing was made '
                  'that has been made. In him was life, and that life '
                  'was the light of all mankind. The light shines in the darkness, '
                  'and the darkness has not overcome it.',
    },
    {
      "shortText": _language == 'AMH'
          ? 'እግዚአብሔር ከአንተ ጋር ነው።'
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
              ? "Kärï lwäyö, kiper a nut buutï, ni ba bwøk cwïnyï, kiper aana Jwøk marï. Ï tïïa tïïö niï teek, ni kønya ïïni, ni jøla ïïni ki cer cwïïa ni wø tïïya adïëri."
              : 'So do not fear, for I am with you; '
                  'do not be dismayed, for I am your God. '
                  'I will strengthen you and help you; '
                  'I will uphold you with my righteous right hand.'
    },

    {
      "shortText": _language == 'AMH'
          ? 'እግዚአብሔርም እርሱ ራሱ ከእነርሱ ጋር ሆኖ አምላካቸው ይሆናል፤'
          : _language == 'ANY'
              ? "Jwøk bëëdö ki uni"
              : 'God will be with you',
      "verse": _language == 'AMH'
          ? 'የዮሐንስ ራእይ 21:4'
          : _language == 'ANY'
              ? "Mana Nyooth 21:4"
              : 'Revelation 21 : 4',
      "text": _language == 'AMH'
          ? 'እግዚአብሔርም እርሱ ራሱ ከእነርሱ ጋር ሆኖ አምላካቸው ይሆናል፤ እንባዎችንም ሁሉ ከዓይኖቻቸው ያብሳል፥ ሞትም ከእንግዲህ ወዲህ አይሆንም፥ ኀዘንም ቢሆን ወይም ጩኸት ወይም ሥቃይ ከእንግዲህ ወዲህ አይሆንም፥ የቀደመው ሥርዓት አልፎአልና ብሎ ሲናገር ሰማሁ።'
          : _language == 'ANY'
              ? "Ba Jwøk ki dëëre obëëdö ki geni, ni "
                  "pooc pï nyeŋge bëët, ni ö thøøe ni bäŋe "
                  "gø këët. Ni bäŋ kïmmö, wala oduuru "
                  "mo di gøø, wala rääm këët. Kiper japa "
                  "dïkwøŋ oaay.»"
              : 'God himself will be with them and be their God...'
                  '‘He will wipe every tear from their eyes. '
                  'There will be no more death’ or mourning or '
                  'crying or pain, for the old order of things has passed away.”'
    },
    {
      "shortText": _language == 'ANY'
          ? "Jwøk lääŋŋa uuni"
          : _language == 'AMH'
              ? 'ከእግዚአብሔር ስለ እናንተ ያስባል'
              : 'God cares for you',
      "verse": _language == 'ANY'
          ? "1 Piter 5:6-7"
          : _language == 'AMH'
              ? '1ኛ የጴጥሮስ መልእክት 5:6-7'
              : '1 Peter 5:6-7',
      "text": _language == 'ANY'
          ? "Kiper manøgønø, døøyu dëëtu mo "
              "mwöl nou ena cer Jwøk na teek, kiper "
              "nee u røønye kanya näk kare. Cïbu "
              "gïï wø pär cwïnynyu ki geni cere, "
              "kiper eni lääŋŋa uuni"
          : _language == 'AMH'
              ? "እንግዲህ በጊዜው ከፍ እንዲያደርጋችሁ ከኃይለኛው ከእግዚአብሔር እጅ በታች ራሳችሁን አዋርዱ፤"
                  "እርሱ ስለ እናንተ ያስባልና የሚያስጨንቃችሁን ሁሉ በእርሱ ላይ ጣሉት።"
              : "So be humble under God’s powerful hand. Then he will lift you up when the right time comes."
                  "Give all your worries to him, because he cares for you."
    },
    {
      "shortText": _language == 'ANY'
          ? "Kär dee ŋat ŋäc dëëre keere"
          : _language == 'AMH'
              ? 'እያንዳንዱ ለራሱ የሚጠቅመውን አይመልከት'
              : 'Don’t be interested only in your own life',
      "verse": _language == 'ANY'
          ? "Pilipay 2:3-4"
          : _language == 'AMH'
              ? 'ወደ ፊልጵስዩስ ሰዎች 2: 3-4'
              : 'Philippians 2:3-4',
      "text": _language == 'ANY'
          ? "Ni bäŋe gïn mo tïïyu ki cøl cwïny wala atöör, 'ba beerra man caarru gïr jiy møga, ni beyø geni ki uuni, nou mwöl. "
              "'Ba kär dee ŋat ŋäc dëëre keere. 'Ba uuni, beerra man ŋäyu jiy møga thuwø."
          : _language == 'AMH'
              ? "ለወገኔ ይጠቅማል በማለት ወይም በከንቱ ውዳሴ ምክንያት አንድ እንኳ አታድርጉ፥ ነገር ግን እያንዳንዱ ባልንጀራው ከራሱ ይልቅ እንዲሻል በትሕትና ይቍጠር፤"
                  "እያንዳንዱ ለራሱ የሚጠቅመውን አይመልከት፥ ለባልንጀራው ደግሞ እንጂ።"
              : "In whatever you do, don’t let selfishness or pride be your guide. Be humble, and honor others more than yourselves."
                  "Don’t be interested only in your own life, but care about the lives of others too."
    },
    {
      "shortText": _language == 'ANY'
          ? "Jwøk tïïö ri jammi bëët nee bëënyge"
          : _language == 'AMH'
              ? 'እግዚአብሔርንም ነገር ሁሉ ለበጎ እንዲደረግ እናውቃለን።'
              : 'In everything God works for the good',
      "verse": _language == 'ANY'
          ? "Röm 8:28"
          : _language == 'AMH'
              ? 'ወደ ሮሜ ሰዎች 8:28'
              : 'Romans 8:28',
      "text": _language == 'ANY'
          ? "'Ba ŋääø ni Jwøk tïïö ri jammi bëët "
              "nee bëënyge jï jøw wø mëër ki eni, jøøa "
              "näk ee cwølø keda mana manynye."
          : _language == 'AMH'
              ? "እግዚአብሔርንም ለሚወዱት እንደ አሳቡም ለተጠሩት ነገር ሁሉ ለበጎ እንዲደረግ እናውቃለን።"
              : "We know that in everything God works for the good of those who love him. These are the people God chose, because that was his plan."
    },
    {
      "shortText": _language == 'ANY'
          ? "Jwøk ena buutï"
          : _language == 'AMH'
              ? 'እግዚአብሔር ከአንተ ጋር ነው'
              : 'The lord is with you.',
      "verse": _language == 'ANY'
          ? "Jøcua 1:9"
          : _language == "AMH"
              ? 'መጽሐፈ ኢያሱ ወልደ ነዌ 1:9'
              : 'Joshua 1:9',
      "text": _language == 'ANY'
          ? "Ennø, a köömma"
              "ïïni. Mak riï ni bëëdï niï teek; ni ba "
              "bwøk cwïnyï ni ba lwäyï, kiper a na "
              "Wuuö Jwøk na näk Jwøk marï, a ena "
              "buutï kany wø ciï yie jaak."
          : _language == 'AMH'
              ? "በምትሄድበት ሁሉ አምላክህ እግዚአብሔር ከአንተ ጋር ነውና ጽና፥ አይዞህ፤ አትፍራ፥ አትደንግጥ ብዬ አላዘዝሁህምን?"
              : "Remember, I commanded you to be strong and brave. Don’t be afraid, because the Lord your God will be with you wherever you go.”"
    },
    {
      "shortText": _language == 'ANY'
          ? "kär dee gïn "
              "lääŋŋu kiper diøø"
          : _language == 'AMH'
              ? 'ለነገ አትጨነቁ'
              : 'Don’t worry about tomorrow.',
      "verse": _language == 'ANY'
          ? "Mathiew 6:31-34"
          : _language == 'AMH'
              ? 'የማቴዎስ ወንጌል 6:31-34'
              : "Mathew 6:31-34",
      "text": _language == 'ANY'
          ? "Kiper manøgønø, kär "
              "dee gïn lääŋŋu, nou köö, na ‹?Agïnaŋø "
              "noo camø?› Nou köö, na ‹?Agïnaŋø noo "
              "maadhø?› Nou köö, na ‹?Agïnaŋø noo "
              "røø dëëtø?› Kiper gïïögø bëët cac "
              "juurre cayø. 'Ba Wääu ni en maal ŋääe "
              "nou can ki gïïögø bëët.'Ba kwøŋu buc "
              "Jwøk ki beeny Jwøk cayø. Køøre nø, "
              "gïïögø bëët owëëk uuni thuwø. "
              " «Kiper manøgønø, kär dee gïn "
              "lääŋŋu kiper diøø. Kiper diøø dëëre "
              "olääŋŋe keere. Cäŋ man nø da moe."
          : _language == 'AMH'
              ? "እንግዲህ። ምን እንበላለን? ምንስ እንጠጣለን? ምንስ እንለብሳለን? ብላችሁ አትጨነቁ፤"
                  " ይህንስ ሁሉ አሕዛብ ይፈልጋሉ፤ ይህ ሁሉ እንዲያስፈልጋችሁ የሰማዩ አባታችሁ ያውቃልና።"
                  " ነገር ግን አስቀድማችሁ የእግዚአብሔርን መንግሥት ጽድቁንም ፈልጉ፥ ይህም ሁሉ ይጨመርላችኋል።"
                  " ነገ ለራሱ ይጨነቃልና ለነገ አትጨነቁ፤ ለቀኑ ክፋቱ ይበቃዋል።"
              : "“Don’t worry and say, ‘What will we eat?’ or ‘What will we drink?’ or ‘What will we wear?’"
                  "That’s what those people who don’t know God are always thinking about. Don’t worry, because your Father in heaven knows that you need all these things."
                  "What you should want most is God’s kingdom and doing what he wants you to do. Then he will give you all these other things you need."
                  "So don’t worry about tomorrow. Each day has enough trouble of its own. Tomorrow will have its own worries."
    },
    {
      "shortText": _language == 'ANY'
          ? "Cwïnynyu opääŋ Jwøki ki mëër"
          : _language == 'AMH'
              ? 'የተስፋ አምላክም ደስታንና ሰላምን ሁሉ ይሙላባችሁ'
              : 'God will fill you with joy and peace',
      "verse": _language == "ANY"
          ? "Röm 15:13"
          : _language == "AMH"
              ? 'ወደ ሮሜ ሰዎች 15:13'
              : "Romans 15:13",
      "text": _language == "ANY"
          ? "'Ba Jwøk ni wø cïp ŋäädhe, cwïnynyu "
              "opääŋe ki met ec mo päl ki mëër ki "
              "køør mana jïëyu, kiper nee ŋäädhe "
              "maru pälle ki køør teek Jwïëc Jwøk "
              "na en kur keere"
          : _language == 'AMH'
              ? "የተስፋ አምላክም በመንፈስ ቅዱስ ኃይል በተስፋ እንድትበዙ በማመናችሁ ደስታንና ሰላምን ሁሉ ይሙላባችሁ።"
              : "I pray that the God who gives hope will fill you with much joy and peace as you trust in him. Then you will have more and more hope, and it will flow out of you by the power of the Holy Spirit."
    },
  ];
}
