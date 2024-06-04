// import 'dart:async';

import 'package:dha_anywaa_bible/classes/SQLHelper.dart';
import 'package:dha_anywaa_bible/classes/font_style.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Pray extends StatefulWidget {
  const Pray({super.key});

  @override
  State<Pray> createState() => _PrayState();
}

class _PrayState extends State<Pray> {
  SelectedFontStyle style = SelectedFontStyle()..init();
  int index = 0;
  String selectedVerse = '';
  String selectedText = '';
  static String _language = '';
  List<Map<String, dynamic>> prayer = [];

  int currentIndex = 0;
  void getItem() async {
    final item = await SQLHelper.getItem(1);
    getLang();
    setState(() {
      currentIndex = item[0]['counter'];
    });
  }

  @override
  void initState() {
    getLang();
    super.initState();
  }

  void getLang() async {
    String language = await style.getLanguageVersion();

    setState(() {
      _language = language.split(' ')[0];
    });

    prayer = [
      {
        "verse": _language == 'AMH'
            ? 'መዝሙረ ዳዊት 5: 2-3'
            : _language == 'ANY'
                ? "Duut pwoc 5: 2-3"
                : 'Psalm 5: 2-3',
        "text": _language == 'AMH'
            ? 'የልመናዬን ቃል አድምጥ፥ ንጉሤና አምላኬ ሆይ፥ አቤቱ፥ ወደ አንተ እጸልያለሁና። '
                'በማለዳ ድምፄን ትሰማለህ፥ በማለዳ በፊትህ እቆማለሁ፥ እጠብቃለሁም።'
            : _language == 'ANY'
                ? "Ï na nyeya mara ni bee ï Jwøa, "
                    "wïny oduuru mara, "
                    "kiper a wø kwaaya ïïni.\n"
                    "Wui Wuuö Jwøk, ka amöölla "
                    "dwøra wø wïnynyï wïnynyö, "
                    "kany wø läma naa køya man wø "
                    "løgï jïra."
                : 'Hear my cry for help,c'
                    'my King and my God, '
                    'for to you I pray. '
                    'In the morning, Lord, you hear my voice; '
                    'in the morning I lay my requests before you '
                    'and wait expectantly.'
      },
      {
        "verse": _language == 'AMH'
            ? 'የሉቃስ ወንጌል 11:2-4'
            : _language == 'ANY'
                ? "Luk 11: 2-4"
                : 'Luke 11: 2 - 4',
        "text": _language == 'AMH'
            ? '... በሰማያት የምትኖር አባታችን ሆይ፤ ስምህ ይቀደስ፤ መንግሥትህ ትምጣ፤ ፈቃድህ በሰማይ እንደ ሆነች እንዲሁ በምድር ትሁን፤ '
                'የዕለት እንጀራችንን ዕለት ዕለት ስጠን፤ '
                'ኃጢአታችንንም ይቅር በለን፥ እኛ ደግሞ የበደሉንን ሁሉ ይቅር ብለናልና፤ ከክፉ አድነን እንጂ ወደ ፈተና አታግባን።'
            : _language == 'ANY'
                ? "2 ...Wääwa, nyeŋŋï wøør. Buyï ööe.\n"
                    "3 Wëëk wa jïtö ki cam ki yïth nïne bëët.\n"
                    "4 Ni weyï moa bacwa, kiper waani "
                    "thuwø, jø wø bääö dëëtwa bëët wø "
                    "wecwa wiiø. Ni ba bwødhï wa kany "
                    "mo wa di päänynyö yie."
                : '“‘Father, '
                    'hallowed be your name, '
                    'your kingdom come. '
                    '3 Give us each day our daily bread. '
                    '4 Forgive us our sins, '
                    'for we also forgive everyone who sins against us. '
                    'And lead us not into temptation.[d]’” '
      },
      {
        "verse": _language == 'AMH'
            ? ''
            : _language == 'ANY'
                ? "Duut Pwoc 16: 7-8"
                : 'Psalm 16 : 7-8',
        "text": _language == 'AMH'
            ? ' የመከረኝን እግዚአብሔርን እባርካለሁ፤ ደግሞም በሌሊት ኵላሊቶቼ ይገሥጹኛል። '
                'ሁልጊዜ እግዚአብሔርን በፊቴ አየዋለሁ፤ በቀኜ ነውና አልታወክም።'
            : _language == 'ANY'
                ? "Aani Wuuö Jwøk wø pwøa pwøø, "
                    "eni ni wø pwöny aani; "
                    "ki wäär thuwø, acaare moe na "
                    "näk yaa kan cwïnya wø cäŋa "
                    "cïpö ki pwöc jïra.\n"
                    "Aani a wø bëëdö naa lääŋŋa "
                    "Wuuö Jwøk cooth; "
                    "a ba pädhi kiper mana bëëde ni "
                    "eni nut buuta"
                : 'I will praise the Lord, who counsels me; '
                    'even at night my heart instructs me. '
                    'I keep my eyes always on the Lord. '
                    'With him at my right hand, I will not be shaken.'
      },
      {
        "verse": _language == 'AMH'
            ? 'መጽሐፈ ዜና መዋዕል ቀዳማዊ። 4:10'
            : _language == 'ANY'
                ? "1 Wëël Luup Nyeye 4:10"
                : '',
        "text": _language == 'AMH'
            ? 'ያቤጽም። እባክህ፥ መባረክን ባርከኝ፥ አገሬንም አስፋው፤ እጅህም ከእኔ ጋር ትሁን፤ እንዳያሳዝነኝም ከክፋት ጠብቀኝ ብሎ የእስራኤልን አምላክ ጠራ፤ እግዚአብሔርም የለመነውን ሰጠው።'
            : _language == 'ANY'
                ? "Gwïëth aani, Wuuö Jwøk, ni mooyï "
                    "aani ki ŋøøm mo thööth; gwøk aani, "
                    "ni koorï aani ceŋ gïï mo leth, nee bäŋe "
                    "gïn mo leth mo pïï dëëra."
                : ' “Oh, that you would bless me and enlarge my '
                    ' territory! Let your hand be with me, and keep me '
                    ' from harm so that I will be free from pain.” '
      },
      {
        "verse": _language == 'AMH'
            ? 'መዝሙረ ዳዊት 148:8'
            : _language == 'ANY'
                ? "Dut Pwøc 143:8"
                : 'Psalm 143:8',
        "text": _language == 'AMH'
            ? ' አንተን ታምኛለሁና በማለዳ ምሕረትህን አሰማኝ፤ አቤቱ፥ ነፍሴን ወደ አንተ አንሥቻለሁና የምሄድበትን መንገድ አስታውቀኝ።'
            : _language == 'ANY'
                ? "Beerra man wëëgï aani wïny "
                    "luum mëër marï ni wø ba jøøl "
                    "kany wø pääa ka amöölla, "
                    "kiper a bëëdö niï yaa gum cwïnya. "
                    "Pwöny aani ki jöör bëëtö mana "
                    "daa bëëdö ki gø, "
                : 'Let the morning bring me word of your unfailing love, '
                    'for I have put my trust in you. '
                    'Show me the way I should go, '
                    'for to you I entrust my life.'
      },
      {
        "verse": _language == 'AMH'
            ? 'መዝሙረ ዳዊት 73:26'
            : _language == 'ANY'
                ? "Dut Pwøc 73:26"
                : 'Psalm 73:26',
        "text": _language == 'AMH'
            ? 'የልቤ አምላክ ሆይ፥ ልቤና ሥጋዬ አለቀ፤ እግዚአብሔር ግን ለዘላለም እድል ፈንታዬ ነው።'
            : _language == 'ANY'
                ? "Løny ki man ö rïŋ dëëra ni "
                    "ränynye, ni päth cwïnya, "
                    "'ba ï na Jwøk, ï poot bëëdö ni "
                    "ïïna teek mara, "
                    "ni bëëdï ni ïïna kura na bäre bäre."
                : 'Maybe my mind and body will become weak, '
                    ' but God is my source of strength. '
                    ' He is mine forever!'
      },
      {
        "verse": _language == 'AMH'
            ? 'ትንቢተ ኢሳይያስ 54:17'
            : _language == 'ANY'
                ? "Aydheea 54:17"
                : 'Isaiah 54:17',
        "text": _language == 'AMH'
            ? ' በአንቺ ላይ የተሠራ መሣሪያ ሁሉ አይከናወንም፤ በፍርድም በሚነሣብሽ ምላስ ሁሉ ትፈርጂበታለሽ።...'
            : _language == 'ANY'
                ? "Bäŋ gïr leny mo di thäädhö kiper "
                    "ränynyö marï mo thura kare. "
                    "Jiy bëët moo kïth luup bäätï kar "
                    "løøk böötï böötö..."
                : 'No weapon that is formed against thee shall prosper; '
                    'and every tongue that shall rise against thee in judgment '
                    'thou shalt condemn'
      },
      // {"verse": "", "text": ""},
      // {"verse": "12", "text": ""},
      // {"verse": "12", "text": ""},
      // {"verse": "12", "text": ""},
    ];
  }

  late SharedPreferences myStorage;

  @override
  Widget build(BuildContext context) {
    getItem();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                await Share.share(
                    '${prayer[currentIndex]['verse']!}\n ${prayer[currentIndex]['text']!}');
              },
              icon: const Icon(Icons.share))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 18, right: 18),
        child: Column(
          children: [
            Text(
              _language == 'AMH'
                  ? 'የዛሬ ፀሎት'
                  : _language == 'ANY'
                      ? 'Lam mar dïcängï'
                      : 'Today\'s prayer',
              style: const TextStyle(fontSize: 28),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 35),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    prayer[currentIndex]['verse']!,
                    style: const TextStyle(
                        color: Colors.grey, fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  SelectableText(
                    prayer[currentIndex]['text']!,
                    style: const TextStyle(fontSize: 18),
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
