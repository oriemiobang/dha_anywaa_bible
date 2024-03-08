class Book {
  String id;
  String name;
  String version;
  List intro;
  List<Chapter> text;

  Book(
      {required this.id,
      required this.name,
      required this.version,
      required this.intro,
      required this.text});

  factory Book.fromJson(Map<String, dynamic> json) {
    var list = json['text'] as List;
    List<Chapter> chaptersList =
        list.map((chapters) => Chapter.fromJson(chapters)).toList();
    return Book(
        name: json['name'] as String,
        id: json['id'] as String,
        version: json['version'] as String,
        intro: json['intro'] as List,
        text: chaptersList);
  }
}

class Chapter {
  int id;
  String name;
  List<Verse> text;
  Chapter({required this.id, required this.name, required this.text});

  factory Chapter.fromJson(Map<String, dynamic> json) {
    var myVerse = json['text'] as List;
    List<Verse> verseList =
        myVerse.map((verses) => Verse.fromJson(verses)).toList();
    return Chapter(
      id: json["id"] as int,
      name: json["name"] as String,
      text: verseList,
    );
  }
}

class Verse {
  int id;
  String? title;
  String? reference;
  String text;

  Verse({required this.id, this.title, this.reference, required this.text});

  factory Verse.fromJson(Map<String, dynamic> json) {
    return Verse(
      id: json["id"] as int,
      title: json['title'] as String,
      reference: json['reference'] as String,
      text: json['text'] as String,
    );
  }
}

// =====================english book ========================

class EnglishVerses {
  String text;
  String id;
  List? comment;
  EnglishVerses(this.text, this.id, this.comment);
  factory EnglishVerses.fromJson(Map<String, dynamic> json) {
    return EnglishVerses(
        json['text'] ?? '', json['ID'] ?? '', json['comments'] ?? []);
  }
}

class EnglishChapter {
  List<EnglishVerses> verses;
  String id;
  String name;
  String? title;

  EnglishChapter(
      {required this.verses, required this.id, required this.name, this.title});

  factory EnglishChapter.fromJson(Map<String, dynamic> json) {
    var list = json['text'] as List;
    List<EnglishVerses> chaptersList =
        list.map((verses) => EnglishVerses.fromJson(verses)).toList();
    return EnglishChapter(
      name: json['name'] ?? '',
      id: json['ID'] ?? '',
      verses: chaptersList,
      title: json['title'] ?? '',
    );
  }
}

class EnglishBook {
  List<EnglishChapter> chapters;
  String id;
  String version;
  String name;

  EnglishBook({
    required this.chapters,
    required this.id,
    required this.version,
    required this.name,
  });

  factory EnglishBook.fromJson(Map<String, dynamic> json) {
    var list = json['text'] as List;
    List<EnglishChapter> chaptersList =
        list.map((chapters) => EnglishChapter.fromJson(chapters)).toList();
    return EnglishBook(
        name: json['name'] ?? '',
        id: json['ID'] ?? '',
        version: json['version'] ?? '',
        chapters: chaptersList);
  }
}

// =================amharic bible ==================

class AmharicVerses {
  String chapter;
  String title;
  List verses;
  AmharicVerses(this.chapter, this.title, this.verses);
  factory AmharicVerses.fromJson(Map<String, dynamic> json) {
    return AmharicVerses(
        json['chapter'] ?? '', json['title'] ?? '', json['verses'] ?? []);
  }
}

class AmharicChapters {
  List<AmharicVerses> chapters;
  String abbv;
  String title;

  AmharicChapters(
      {required this.chapters, required this.abbv, required this.title});

  factory AmharicChapters.fromJson(Map<String, dynamic> json) {
    var list = json['chapters'] as List;
    List<AmharicVerses> chaptersList =
        list.map((verses) => AmharicVerses.fromJson(verses)).toList();
    return AmharicChapters(
      title: json['title'] ?? '',
      abbv: json['abbv'] ?? '',
      chapters: chaptersList,
    );
  }
}




// class EnglishBible {
//   List<EnglishBook> books;
//   EnglishBible({required this.books});
//   factory EnglishBible.fromJson(List<dynamic> json) {
//     var books = json.map((book) => EnglishBook.fromJson(book)).toList();
//     return EnglishBible(books: books);
//   }
// }

// class BibleEnglish {
//   EnglishBible? englishBible;
//   BibleEnglish({this.englishBible});
// }
