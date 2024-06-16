// =====================english book ========================

class EnglishVerses {
  String text;
  String id;
  String? reference;
  List? comment;
  String? title;
  EnglishVerses(this.text, this.id, this.comment, this.reference, this.title);
  factory EnglishVerses.fromJson(Map<String, dynamic> json) {
    return EnglishVerses(json['text'] ?? '', json['ID'] ?? '',
        json['comments'] ?? [], json['reference'] ?? "", json['title'] ?? "");
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

// ================= anywaa =====================
class AnywaaVerse {
  String text;
  String id;
  String? reference;
  String? comment;
  String? title;
  AnywaaVerse(this.text, this.id, this.comment, this.reference, this.title);
  factory AnywaaVerse.fromJson(Map<String, dynamic> json) {
    return AnywaaVerse(json['text'] ?? '', json['ID'] ?? '',
        json['comment'] ?? '', json['reference'] ?? "", json['title'] ?? "");
  }
}

class AnywaaChapter {
  List<AnywaaVerse> verses;
  String id;
  String name;
  String? title;
  String? author;

  AnywaaChapter(
      {required this.verses,
      required this.id,
      required this.name,
      this.title,
      this.author});
  factory AnywaaChapter.fromJson(Map<String, dynamic> json) {
    var list = json['text'] as List;
    List<AnywaaVerse> chaptersList =
        list.map((verses) => AnywaaVerse.fromJson(verses)).toList();
    return AnywaaChapter(
      name: json['name'] ?? '',
      id: json['ID'] ?? '',
      verses: chaptersList,
      title: json['title'] ?? '',
      author: json['author'] ?? '',
    );
  }
}

class AnywaaBook {
  List<AnywaaChapter> chapters;
  String id;
  String version;
  String name;

  AnywaaBook({
    required this.chapters,
    required this.id,
    required this.version,
    required this.name,
  });

  factory AnywaaBook.fromJson(Map<String, dynamic> json) {
    var list = json['text'] as List;
    List<AnywaaChapter> chaptersList =
        list.map((chapters) => AnywaaChapter.fromJson(chapters)).toList();
    return AnywaaBook(
        name: json['name'] ?? '',
        id: json['ID'] ?? '',
        version: json['version'] ?? '',
        chapters: chaptersList);
  }
}
