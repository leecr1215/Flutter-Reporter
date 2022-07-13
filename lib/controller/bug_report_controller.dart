abstract class BugReportController {
  void saveItems();
}

class BugReportItem {
  String title;
  String author;
  String content;
  String currentTime;
  String image;

  BugReportItem(
      {required this.title,
      required this.author,
      required this.content,
      required this.currentTime,
      required this.image});

  Map<String, dynamic> toJSONEncodable() {
    Map<String, dynamic> map = <String, dynamic>{};

    map['title'] = title;
    map['author'] = author;
    map['content'] = content;
    map['currentTime'] = currentTime;
    map['image'] = image;

    return map;
  }
}

class BugReportList {
  List<BugReportItem> items = [];

  List toJSONEnable() {
    return items.map((item) {
      return item.toJSONEncodable();
    }).toList();
  }
}
