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

class EnglishBook {
  List<EnglishChapter> text;

  EnglishBook({required this.text});

  factory EnglishBook.fromJson(Map<String, dynamic> json) {
    var list = json['text'] as List;
    List<EnglishChapter> chaptersList = list
        .map<EnglishChapter>((chapters) => EnglishChapter.fromJson(chapters))
        .toList();
    return EnglishBook(text: chaptersList);
  }
}

class EnglishChapter {
  String id;
  String name;
  List<EnglishVerse> text;
  EnglishChapter({required this.id, required this.name, required this.text});

  factory EnglishChapter.fromJson(Map<String, dynamic> json) {
    var myVerse = json['text'] as List;
    List<EnglishVerse> verseList =
        myVerse.map((verses) => EnglishVerse.fromJson(verses)).toList();
    return EnglishChapter(
      id: json["id"] as String,
      name: json["name"] as String,
      text: verseList,
    );
  }
}

class EnglishVerse {
  String id;
  String text;

  EnglishVerse({required this.id, required this.text});

  factory EnglishVerse.fromJson(Map<String, dynamic> json) {
    return EnglishVerse(
      id: json["id"] as String,
      text: json['text'] as String,
    );
  }
}
