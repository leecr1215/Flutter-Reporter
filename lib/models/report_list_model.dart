import 'report_item_model.dart';

class BugReportList {
  List<BugReportItem> items = [];

  List toJSONEnable() {
    return items.map((item) {
      return item.toJSONEncodable();
    }).toList();
  }
}
