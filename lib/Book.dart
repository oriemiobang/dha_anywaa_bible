// class Bible {
//   String? id;
//   String? name;
//   String? version;
//   List? intro;
//   List<Text1>? text1;

//   Bible({this.id, this.name, this.version, this.intro, this.text1});
// }

// class Text1 {
//   int? id;
//   String? name;
//   List<Text2>? text2;
//   Text1({this.id, this.name, this.text2});
// }

// class Text2 {
//   int? id;
//   String? title;
//   String? reference;
//   String? text;

//   Text2({this.id, this.title, this.reference, this.text});
// }
class Book {
  // final String name;
  // final List<Chapter> chapters;

  // Book({required this.name, required this.chapters});

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
  // final List<Verse> verses;

  // Chapter({required this.verses});

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

  // get text => null;
}

class Verse {
  // final String title;
  // final String reference;
  // final String content;

  // Verse({required this.title, required this.reference, required this.content});

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