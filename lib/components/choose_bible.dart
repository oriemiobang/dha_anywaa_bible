// ignore_for_file: prefer_const_constructors

import 'package:dha_anywaa_bible/classes/font_style.dart';
import 'package:flutter/material.dart';

class ChooseBible extends StatefulWidget {
  const ChooseBible({super.key});

  @override
  State<ChooseBible> createState() => _ChooseBibleState();
}

class _ChooseBibleState extends State<ChooseBible> {
  List<Map<String, dynamic>> bibleVersons = [
    {
      'name': 'Dha anywaa',
      'abbrev': 'ANY',
      'description': 'The Bible was translated into the Anyua language so that the word of God could reach the Anyua people.'
          '\nThe translation took place in Akobo, Sudan, in 1948. It began with the New Testament.'
          '\n\nIn 1962, the translation was completed in Sudan and published by the Bible Society in America, written in Latin.'
          ' Later, in 1965, it was brought to Ethiopia and written in the Amharic script, making it accessible to the Anyua people in Ethiopia.'
          '\n\nAfter several years, the entire Bible was translated into the Anyua language.',
      'isExpanded': false,
    },
    {
      'name': 'Amharic',
      'abbrev': 'AMH',
      'description': "Christianity entered Ethiopia in the 4th century, and the Bible was translated into Geez (Ethiopic) thereafter. This Bible was revised in the 14th Century. "
          "The first complete Amharic Bible was produced in 1840, and went through several revisions thereafter. "
          "The version of the Bible presented here was the fulfillment of the expressed desire of Haile Selassie, "
          "and was first published in 1962. \n\nIn 1962, a new Amharic translation from Ge'ez was printed with the "
          "patronage of the Emperor Haile Selassie. The preface by Emperor Haile Selassie I is dated '1955' (E.C.), "
          "and the 31st year of his reign (i.e. AD 1962 in the Gregorian Calendar), and states that it was translated by "
          "the Bible Committee he convened between AD 1947 and 1952, realizing that there ought to be a revision from the "
          "original Hebrew and Greek of the existing translation of the Bible \n\nIn 1992-93, with the blessing and support "
          " of the Ethiopian Bible Society and Ato Kebede Mamo, the Director, the Bible was computerized by Hiruye Stige and his wife Genet.",
      'isExpanded': false,
    },
    {
      'name': 'Amplified Bible',
      'abbrev': 'AMP',
      'description':
          "Frances Siewert (1881-1967) was active in Christian education and the widow of a Presbyterian minister who died in 1940. With continuing support from the Lockman Foundation and Zondervan, she then devoted herself to a similar edition of the Old Testament, relying heavily on the 1952 Revised Standard Version. Her two Old Testament volumes were published in 1962 and 1964. \n\nThe Lockman Foundation then employed several scholars to revise the entire work for a one-volume edition, which was published in 1965. In 1987 an expanded edition was published with additional amplifications; that version is now referred to as the Classic Edition (AMPC). In 2015 the Amplified Bible was updated again for readability and clarity, with refreshed English and improved amplifications.\n\nThe Amplified Bible largely offers a word-for-word translation. It is unique among Bible versions in that it provides 'amplifications' — synonyms and explanations in brackets and parentheses within the text. The strength of this version is that it acknowledges that no single English word or phrase can capture precisely the meaning of the Hebrew or Greek.",
      'isExpanded': false,
    },
    {
      'name': 'American Standard Version',
      'abbrev': 'ASV',
      'description':
          "The American Standard Version, which was also known as The American Revision of 1901, is a word-for-word translation rooted in the work begun in 1870 to revise the King James Bible of 1611. This project eventually produced the Revised Version (RV) in the UK. An invitation was extended to American religious leaders for scholars to work on the RV project. \n\nIn 1871, thirty scholars were chosen by Philip Schaff. These scholars began work in 1872. The Revised Version New Testament was published in 1881, the Old Testament in 1885, and the Apocrypha in 1894, after which the British team disbanded.\n\nThe divine name of the Almighty (the Tetragrammaton) is consistently rendered Jehovah in 6,823 places of the ASV Old Testament, rather than LORD as it appears mostly in the King James Bible and Revised Version of 1881-85. The reason for this change, as the Committee explained in the preface, was that 'the American Revisers were brought to the unanimous conviction that a Jewish superstition, which regarded the Divine Name as too sacred to be uttered, ought no longer to dominate in the English or any other version of the Old Testament.",
      'isExpanded': false,
    },
    {
      'name': 'Catholic Public Domain Version',
      'abbrev': 'CPDV',
      'description':
          "The Catholic Public Domain Version (CPDV), is a fairly word-for-word Modern English translation of the Bible from the Latin Vulgate, prepared and edited by Catholic writer Ronald L. Conte Jr. The translator used the Challoner Douay-Rheims version as a guide in translating the Latin Vulgate edition of Popes Sixtus V and Clement VIII. This translation is published together with the Latin Vulgate text, translation notes, and commentary. \n\nThe CPDV is specifically a Roman Catholic translation, which translates both the Old and the New Testaments in the light of Roman Catholic doctrine, in order to make the text more accessible to the Catholic reader. The CPDV carefully avoids inclusive language, instead translating each noun that refers to human persons in accordance with the gender and number of the source text. \n\nThe word meaning 'sons' is translated as 'sons', the word meaning 'brothers' is translated as 'brothers', and so on. The Vatican norms for Bible translation reject the use of inclusive or gender-neutral language. And yet many modern translations have thoroughly integrated this type of language into the text of the Bible to make it politically-correct.",
      'isExpanded': false,
    },
    {
      'name': 'Easy-to-Read Version',
      'abbrev': 'ERV',
      'description':
          "The Easy-to-Read translation of The Bible is a thought-for-thought translation whose history originated because some deaf readers struggled with reading English because sign language is their first language. The World Bible Translation Center (WBTC) decided to do a translation that would make reading the Bible easier for them. The EVD uses simpler vocabulary and shorter sentences to make it more simple to understand. \n\nThe English Version for the Deaf (EVD), and its second cover, the Easy to Read Version (ERV) were translated by Ervin Bishop (Greek Language Translator), David Stringham (Hebrew Language Translator) and Benton L Dibrell (Deaf Language Specialist, Interpreter, and Translator). \n\nThe translators used a functional equivalence method of translation. It was found to be useful for others who struggle with reading and is often used in prisons and literacy programs.",
      'isExpanded': false,
    },
    {
      'name': 'English Standard Version',
      'abbrev': 'ESV',
      'description':
          "The English Standard Version (ESV) is a word-for-word translation of the Bible in contemporary English. Published in 2001 by Crossway, the ESV was created by a team of more than 100 leading evangelical scholars and pastors. It relies on recently published critical editions of the original Hebrew, Aramaic, and Greek texts.\n\nDuring the early 1990s, Crossway president Lane T. Dennis engaged in discussions with various Christian scholars and pastors regarding the need for a new literal translation of the Bible. In 1997, Dennis contacted the National Council of Churches (NCC) and proceeded to enter negotiations, alongside Trinity Evangelical Divinity School professor Wayne Grudem, to obtain rights to use the 1971 text edition of the Revised Standard Version (RSV) as the starting point for a new translation.\n\nIn September 1998, an agreement was reached. Crossway moved forward from this position by forming a translation committee and initiating work on the English Standard Version.",
      'isExpanded': false,
    },
    {
      'name': 'King James Version',
      'abbrev': 'KJV',
      'description':
          "The King James Version (KJV), King James Bible (KJB), Authorized Version (AV), or originally 1611 King Iames Version (the letter J was not added until the 1629 Cambridge Revised Version) is a word-for-word Early Modern English translation of the Christian Bible for the Church of England, which was commissioned in 1604 and published in 1611, by sponsorship of King James VI and I.\n\nThe KJV was first printed by John Norton and Robert Barker, who both held the post of the King's Printer, and was the third translation into English language approved by the English Church authorities. Noted for its 'majesty of style', the King James Version has been described as one of the most important books in English culture and a driving force in the shaping of the English-speaking world.",
      'isExpanded': false,
    },
    {
      'name': 'New American Standard Bible',
      'abbrev': 'NASB',
      'description':
          "The New American Standard Bible (NASB) is a word-for-word translation of the Bible in contemporary English. Published by the Lockman Foundation, the complete NASB was released in 1971. The NASB relies on recently published critical editions of the original Hebrew, Aramaic, and Greek texts. The Lockman Foundation claims that the NASB 'has been widely embraced as a literal and accurate English translation because it consistently uses the formal equivalence translation philosophy.\n\nAccording to the NASB's preface, the translators had a 'Fourfold Aim' in this work:\n\t1. These publications shall be true to the original Hebrew, Aramaic, and Greek.\n\t2.They shall be grammatically correct.\n\t3.They shall be understandable.\n\t4.They shall give the Lord Jesus Christ His proper place, the place which the Word gives Him; therefore, no work will ever be personalized.\n\nThe New American Standard Bible is considered by some sources as the most literally translated of major 20th-century English Bible translations. ",
      'isExpanded': false,
    },
    {
      'name': 'World English Bible',
      'abbrev': 'WEB',
      'description':
          "The World English Bible (WEB) is an English translation of the Bible freely shared online. The translation work began in 1994 and was deemed complete in 2020. Created by volunteers with oversight by Michael Paul Johnson, the WEB is an updated revision of the American Standard Version from 1901.\n\nIn 1994, Michael Paul Johnson felt commissioned by God 'to create a new modern English translation of the Holy Bible that would be forever free to use, publish, and distribute.' Since he did not have formal training in this regard, he started to study Greek and Hebrew and how to use scholarly works. His first translated books were the gospel and letters of John, which he shared drafts of on Usenet and a mailing list, receiving some suggestions and incorporating them. \n\nEstimating he would be 150 years old by the time this style of work would be finished, Johnson prayed for guidance. The answer was to use the American Standard Version (ASV) of 1901 because it is regarded as an accurate and reliable translation that is fully in the public domain. \n\nJohnson's main goal became modernizing the language of ASV, and he made custom computer programs to organize the process. This resulted in an initial draft of 1997 that 'was not quite modern English, in that it still lacked quotation marks and still had some word ordering that sounded more like Elizabethan English or maybe Yoda than modern English.' \n\nThis draft was soon named World English Bible (WEB), since Johnson intended it for any English speaker, and the acronym indicates that the Web is the means of distribution. Over the years, a number of volunteers assisted Johnson. The entire translation effort was deemed complete in 2020, and the only subsequent changes have been fixing a few typos.",
      'isExpanded': false,
    },
  ];

  void getLanguageVersion() async {
    String currentLanguageVersion =
        await selectedFontStyle.getLanguageVersion();
    currentLanguageVersion = currentLanguageVersion.split(' ')[0];

    setState(() {
      _currentLanguageVersion = currentLanguageVersion;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLanguageVersion();
  }

  SelectedFontStyle selectedFontStyle = SelectedFontStyle();
  String _currentLanguageVersion = '';
  String currentAbbrev = '';

  _updateVersion(value) async {
    try {
      final currentVersion = await selectedFontStyle.getBibleVersion();

      var splitVersion = currentVersion.split('/');

      if (value == 'AMH') {
        for (var chapIndex = 0; chapIndex < chapAbbrev.length; chapIndex++) {
          if (splitVersion[0] == 'ANY') {
            if (chapAbbrev[chapIndex]['abbrev'] ==
                splitVersion[2].split('.')[0].toString()) {
              selectedFontStyle
                  .setBibleVersion('${chapAbbrev[chapIndex]['amharic']}');
            }
          } else {
            if (chapAbbrev[chapIndex]['abbrev'] == splitVersion[1].toString()) {
              selectedFontStyle
                  .setBibleVersion('${chapAbbrev[chapIndex]['amharic']}');
            }
          }
        }
      } else if (value == 'ANY') {
        if (currentVersion.contains('_')) {
          for (var chapIndex = 0; chapIndex < chapAbbrev.length; chapIndex++) {
            if (chapAbbrev[chapIndex]['amharic'] == currentVersion &&
                chapIndex < 39) {
              selectedFontStyle.setBibleVersion(
                  'ANY/OT/${chapAbbrev[chapIndex]['abbrev']}.json');
              print('ANY/OT/${chapAbbrev[chapIndex]['abbrev']}.json jkj');
            } else if (chapAbbrev[chapIndex]['amharic'] == currentVersion &&
                chapIndex >= 39) {
              selectedFontStyle.setBibleVersion(
                  'ANY/NT/${chapAbbrev[chapIndex]['abbrev']}.json');
            }
          }
        } else {
          for (var chapIndex = 0; chapIndex < chapAbbrev.length; chapIndex++) {
            if (chapAbbrev[chapIndex]['abbrev'] == splitVersion[1] &&
                chapIndex < 39) {
              selectedFontStyle.setBibleVersion(
                  'ANY/${splitVersion[0]}/${splitVersion[1]}.json');
            } else if (chapAbbrev[chapIndex]['abbrev'] == splitVersion[1] &&
                chapIndex >= 39) {
              selectedFontStyle.setBibleVersion(
                  'ANY/${splitVersion[0]}/${splitVersion[1]}.json');
              print('ANY/${splitVersion[0]}/${splitVersion[1]}.json blah balh');
            }
          }
        }
      } else {
        if (currentVersion.contains('_')) {
          for (var chapIndex = 0; chapIndex < chapAbbrev.length; chapIndex++) {
            if (chapAbbrev[chapIndex]['amharic'] == currentVersion &&
                chapIndex < 39) {
              selectedFontStyle.setBibleVersion(
                  'OT/${chapAbbrev[chapIndex]['abbrev']}/$value.json');
            } else if (chapAbbrev[chapIndex]['amharic'] == currentVersion &&
                chapIndex >= 39) {
              selectedFontStyle.setBibleVersion(
                  'NT/${chapAbbrev[chapIndex]['abbrev']}/$value.json');
            }
          }
        } else if (splitVersion[0] == 'ANY') {
          selectedFontStyle.setBibleVersion(
              '${splitVersion[1]}/${splitVersion[2].split('.')[0]}/$value.json');
        } else {
          selectedFontStyle.setBibleVersion(
              '${splitVersion[0]}/${splitVersion[1]}/$value.json');
        }
      }
    } catch (e) {
      print('Error $e');
    }
  }

  List<Map<String, String>> chapAbbrev = [
    {
      'title': 'Genesis',
      'amharic': "01_ኦሪት ዘፍጥረት.json",
      'anywaa': '',
      'number': '50',
      'abbrev': 'GEN'
    },
    {
      'title': 'Exodus',
      'amharic': '02_ኦሪት ዘጸአት.json',
      'anywaa': '',
      'number': '40',
      'abbrev': 'EXO'
    },
    {
      'title': 'Leviticus',
      'amharic': "03_ኦሪት ዘሌዋውያን.json",
      'anywaa': '',
      'number': '27',
      'abbrev': 'LEV'
    },
    {
      'title': 'Numbers',
      'amharic': "04_ኦሪት ዘኍልቍ.json",
      'anywaa': '',
      'number': '36',
      'abbrev': 'NUM'
    },
    {
      'title': 'Deuteronomy',
      'amharic': "05_ኦሪት ዘዳግም.json",
      'anywaa': '',
      'number': '34',
      'abbrev': 'DEU'
    },
    {
      'title': 'Joshua',
      'amharic': "06_መጽሐፈ ኢያሱ ወልደ ነዌ.json",
      'anywaa': '',
      'number': '24',
      'abbrev': 'JOS'
    },
    {
      'title': "Judges",
      'amharic': "07_መጽሐፈ መሣፍንት.json",
      'anywaa': '',
      'number': '21',
      'abbrev': 'JDG'
    },
    {
      'title': "Ruth",
      'amharic': "08_መጽሐፈ ሩት.json",
      'anywaa': '',
      'number': '4',
      'abbrev': 'RUT'
    },
    {
      'title': "1 Samuel",
      'amharic': "09_መጽሐፈ ሳሙኤል ቀዳማዊ.json",
      'anywaa': '',
      'number': '31',
      'abbrev': '1SA'
    },
    {
      'title': "2 Samuel",
      'amharic': "10_መጽሐፈ ሳሙኤል ካል.json",
      'anywaa': '',
      'number': '24',
      'abbrev': '2SA'
    },
    {
      'title': "1 Kings",
      'amharic': '11_መጽሐፈ ነገሥት ቀዳማዊ.json',
      'anywaa': '',
      'number': '22',
      'abbrev': '1KI'
    },
    {
      'title': "2 Kings",
      'amharic': '12_መጽሐፈ ነገሥት ካልዕ.json',
      'anywaa': '',
      'number': '25',
      'abbrev': '2KI'
    },
    {
      'title': "1 Chronicles",
      'amharic': '13_መጽሐፈ ዜና መዋዕል ቀዳማዊ.json',
      'anywaa': '',
      'number': '29',
      'abbrev': '1CH'
    },
    {
      'title': "2 Chronicles",
      'amharic': '14_መጽሐፈ ዜና መዋዕል ካልዕ.json',
      'anywaa': '',
      'number': '36',
      'abbrev': '2CH'
    },
    {
      'title': "Ezra",
      'amharic': '15_መጽሐፈ ዕዝራ.json',
      'anywaa': '',
      'number': '10',
      'abbrev': 'EZR'
    },
    {
      'title': "Nehemiah",
      'amharic': '16_መጽሐፈ ነህምያ.json',
      'anywaa': '',
      'number': '13',
      'abbrev': 'NEH'
    },
    {
      'title': "Esther",
      'amharic': '17_መጽሐፈ አስቴር.json',
      'anywaa': '',
      'number': '10',
      'abbrev': 'EST'
    },
    {
      'title': "Job",
      'amharic': '18_መጽሐፈ ኢዮብ.json',
      'anywaa': '',
      'number': '42',
      'abbrev': 'JOB'
    },
    {
      'title': "Psalms",
      'amharic': '19_መዝሙረ ዳዊት.json',
      'anywaa': '',
      'number': '150',
      'abbrev': 'PSA'
    },
    {
      'title': "Proverbs",
      'amharic': '20_መጽሐፈ ምሳሌ.json',
      'anywaa': '',
      'number': '31',
      'abbrev': 'PRO'
    },
    {
      'title': "Ecclesiastes",
      'amharic': '21_መጽሐፈ መክብብ.json',
      'anywaa': '',
      'number': '12',
      'abbrev': 'ECC'
    },
    {
      'title': "Song of Solomon",
      'amharic': '22_መኃልየ መኃልይ ዘሰሎሞን.json',
      'anywaa': '',
      'number': '8',
      'abbrev': 'SNG'
    },
    {
      'title': 'Isaiah',
      'amharic': '23_ትንቢተ ኢሳይያስ.json',
      'anywaa': '',
      'number': '66',
      'abbrev': 'ISA'
    },
    {
      'title': 'Jeremiah',
      'amharic': '24_ትንቢተ ኤርምያስ.json',
      'anywaa': '',
      'number': '52',
      'abbrev': 'JER'
    },
    {
      'title': 'Lamentations',
      'amharic': '25_ሰቆቃው ኤርምያስ.json',
      'anywaa': '',
      'number': '5',
      'abbrev': 'LAM'
    },
    {
      'title': 'Ezekiel',
      'amharic': '26_ትንቢተ ሕዝቅኤል.json',
      'anywaa': '',
      'number': '48',
      'abbrev': 'EZK'
    },
    {
      'title': 'Daniel',
      'amharic': '27_ትንቢተ ዳንኤል.json',
      'anywaa': '',
      'number': '12',
      'abbrev': 'DAN'
    },
    {
      'title': 'Hosea',
      'amharic': '28_ትንቢተ ሆሴዕ.json',
      'anywaa': '',
      'number': '14',
      'abbrev': 'HOS'
    },
    {
      'title': 'Joel',
      'amharic': '29_ትንቢተ ኢዮኤል.json',
      'anywaa': '',
      'number': '3',
      'abbrev': 'JOL'
    },
    {
      'title': 'Amos',
      'amharic': '30_ትንቢተ አሞጽ.json',
      'anywaa': '',
      'number': '9',
      'abbrev': 'AMO'
    },
    {
      'title': 'Obadiah',
      'amharic': '31_ትንቢተ አብድዩ.json',
      'anywaa': '',
      'number': '1',
      'abbrev': 'OBA'
    },
    {
      'title': 'Jonah',
      'amharic': '32_ትንቢተ ዮናስ.json',
      'anywaa': '',
      'number': '4',
      'abbrev': 'JON'
    },
    {
      'title': 'Micah',
      'amharic': '33_ትንቢተ ሚክያስ.json',
      'anywaa': '',
      'number': '7',
      'abbrev': 'MIC'
    },
    {
      'title': 'Nahum',
      'amharic': '34_ትንቢተ ናሆም.json',
      'anywaa': '',
      'number': '3',
      'abbrev': 'NAH'
    },
    {
      'title': 'Habakkuk',
      'amharic': '35_ትንቢተ ዕንባቆም.json',
      'anywaa': '',
      'number': '3',
      'abbrev': 'HAB'
    },
    {
      'title': 'Zephaniah',
      'amharic': '36_ትንቢተ ሶፎንያስ.json',
      'anywaa': '',
      'number': '3',
      'abbrev': 'ZEP'
    },
    {
      'title': 'Haggai',
      'amharic': '37_ትንቢተ ሐጌ.json',
      'anywaa': '',
      'number': '2',
      'abbrev': 'HAG'
    },
    {
      'title': 'Zechariah',
      'amharic': '38_ትንቢተ ዘካርያስ.json',
      'anywaa': '',
      'number': '14',
      'abbrev': 'ZEC'
    },
    {
      'title': 'Malachi',
      'amharic': '39_ትንቢተ ሚልክያ.json',
      'anywaa': '',
      'number': '4',
      'abbrev': 'MAL'
    },
    {
      'title': 'Matthew',
      'amharic': '40_የማቴዎስ ወንጌል.json',
      'anywaa': '',
      'number': '28',
      'abbrev': 'MAT'
    },
    {
      'title': 'Mark',
      'amharic': '41_የማርቆስ ወንጌል.json',
      'anywaa': '',
      'number': '16',
      'abbrev': 'MRK'
    },
    {
      'title': 'Luke',
      'amharic': '42_የሉቃስ ወንጌል.json',
      'anywaa': '',
      'number': '24',
      'abbrev': 'LUK'
    },
    {
      'title': 'John',
      'amharic': '43_የዮሐንስ ወንጌል.json',
      'anywaa': '',
      'number': '21',
      'abbrev': 'JHN'
    },
    {
      'title': 'Acts',
      'amharic': '44_የሐዋርያት ሥራ.json',
      'anywaa': '',
      'number': '28',
      'abbrev': 'ACT'
    },
    {
      'title': 'Romans',
      'amharic': '45_ወደ ሮሜ ሰዎች.json',
      'anywaa': '',
      'number': '16',
      'abbrev': 'ROM'
    },
    {
      'title': '1 Corinthians',
      'amharic': '46_1ኛ ወደ ቆሮንቶስ ሰዎች.json',
      'anywaa': '',
      'number': '16',
      'abbrev': '1CO'
    },
    {
      'title': '2 Corinthians',
      'amharic': '47_2ኛ ወደ ቆሮንቶስ ሰዎች.json',
      'anywaa': '',
      'number': '13',
      'abbrev': '2CO'
    },
    {
      'title': 'Galatians',
      'amharic': '48_ወደ ገላትያ ሰዎች.json',
      'anywaa': '',
      'number': '6',
      'abbrev': 'GAL'
    },
    {
      'title': 'Ephesians',
      'amharic': '49_ወደ ኤፌሶን ሰዎች.json',
      'anywaa': '',
      'number': '6',
      'abbrev': 'EPH'
    },
    {
      'title': 'Philippians',
      'amharic': '50_ወደ ፊልጵስዩስ ሰዎች.json',
      'anywaa': '',
      'number': '4',
      'abbrev': 'PHP'
    },
    {
      'title': 'Colossians',
      'amharic': '51_ወደ ቆላስይስ ሰዎች.json',
      'anywaa': '',
      'number': '4',
      'abbrev': 'COL'
    },
    {
      'title': '1 Thessalonians',
      'amharic': '52_1ኛ ወደ ተሰሎንቄ ሰዎች.json',
      'anywaa': '',
      'number': '5',
      'abbrev': '1TH'
    },
    {
      'title': '2 Thessalonians',
      'amharic': '53_2ኛ ወደ ተሰሎንቄ ሰዎች.json',
      'anywaa': '',
      'number': '3',
      'abbrev': '2TH'
    },
    {
      'title': '1 Timothy',
      'amharic': '54_1ኛ ወደ ጢሞቴዎስ.json',
      'anywaa': '',
      'number': '6',
      'abbrev': '1TI'
    },
    {
      'title': '2 Timothy',
      'amharic': '55_2ኛ ወደ ጢሞቴዎስ.json',
      'anywaa': '',
      'number': '4',
      'abbrev': '2TI'
    },
    {
      'title': 'Titus',
      'amharic': '56_ወደ ቲቶ.json',
      'anywaa': '',
      'number': '3',
      'abbrev': 'TIT'
    },
    {
      'title': 'Philemon',
      'amharic': '57_ወደ ፊልሞና.json',
      'anywaa': '',
      'number': '1',
      'abbrev': 'PHM'
    },
    {
      'title': 'Hebrews',
      'amharic': '58_ወደ ዕብራውያን.json',
      'anywaa': '',
      'number': '13',
      'abbrev': 'HEB'
    },
    {
      'title': 'James',
      'amharic': '59_የያዕቆብ መልእክት.json',
      'anywaa': '',
      'number': '5',
      'abbrev': 'JAS'
    },
    {
      'title': '1 Peter',
      'amharic': '60_1ኛ የጴጥሮስ መልእክት.json',
      'anywaa': '',
      'number': '5',
      'abbrev': '1PE'
    },
    {
      'title': '2 Peter',
      'amharic': '61_2ኛ የጴጥሮስ መልእክት.json',
      'anywaa': '',
      'number': '3',
      'abbrev': '2PE'
    },
    {
      'title': '1 John',
      'amharic': '62_1ኛ የዮሐንስ መልእክት.json',
      'anywaa': '',
      'number': '5',
      'abbrev': '1JN'
    },
    {
      'title': '2 John',
      'amharic': '63_2ኛ የዮሐንስ መልእክት.json',
      'anywaa': '',
      'number': '1',
      'abbrev': '2JN'
    },
    {
      'title': '3 John',
      'amharic': '64_3ኛ የዮሐንስ መልእክት.json',
      'anywaa': '',
      'number': '1',
      'abbrev': '3JN'
    },
    {
      'title': 'Jude',
      'amharic': '65_የይሁዳ መልእክት.json',
      'anywaa': '',
      'number': '1',
      'abbrev': 'JUD'
    },
    {
      'title': 'Revelation',
      'amharic': '66_የዮሐንስ ራእይ.json',
      'anywaa': '',
      'number': '22',
      'abbrev': 'REV'
    }
  ];

  @override
  Widget build(BuildContext context) {
    Brightness currentTheme = Theme.of(context).brightness;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Languages And Versions'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('    Choose your bible version'),
            ExpansionPanelList(
              dividerColor: Colors.transparent,
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  setState(() {
                    bibleVersons[index]['isExpanded'] =
                        !bibleVersons[index]['isExpanded'];
                  });
                });
              },
              children: bibleVersons.map<ExpansionPanel>((item) {
                return ExpansionPanel(
                  backgroundColor: currentTheme == Brightness.dark
                      ? Color.fromARGB(255, 0, 4, 17)
                      : Colors.white,
                  headerBuilder: (BuildContext context, bool isExpanded) =>
                      ListTile(
                    leading: _currentLanguageVersion == item['abbrev']
                        ? Icon(
                            Icons.check,
                            color: Colors.amber,
                          )
                        : Icon(null),
                    title: Text(
                      '${item['abbrev']}',
                      style: TextStyle(
                          color: _currentLanguageVersion == item['abbrev']
                              ? Colors.amber
                              : null),
                    ),
                    subtitle: Text(
                      '${item['name']}',
                      style: TextStyle(
                          color: _currentLanguageVersion == item['abbrev']
                              ? Colors.amber
                              : Colors.grey),
                    ),
                    onTap: () {
                      selectedFontStyle.setLanguageVersion(
                          '${item['abbrev']} ${item['name']}');
                      setState(() {
                        currentAbbrev = item['abbrev'];
                        _updateVersion(currentAbbrev);
                        _currentLanguageVersion = item['abbrev'];
                      });

                      Navigator.pop(context);
                    },
                  ),
                  body: ListTile(
                    title: Text('${item['description']}'),
                  ),
                  isExpanded: item['isExpanded'],
                );
              }).toList(),
            ),
          ]),
        ),
      ),
    );
  }
}
