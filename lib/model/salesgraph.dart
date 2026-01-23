class SalesGraph {
  String? month;
  double? totalSale;
  List<Weeks>? weeks;

  SalesGraph({this.month, this.totalSale, this.weeks});

  SalesGraph.fromJson(Map<String, dynamic> json) {
    month = json["month"];
    totalSale = (json["total_sale"] as num?)?.toDouble();
    weeks = (json["weeks"] as List?)
        ?.map((e) => Weeks.fromJson(e))
        .toList();
  }

  static List<SalesGraph> fromList(List<dynamic> list) {
    return list.map((e) => SalesGraph.fromJson(e)).toList();
  }
}
class Weeks {
  int? week;
  double? totalSale;

  Weeks({this.week, this.totalSale});

  Weeks.fromJson(Map<String, dynamic> json) {
    week = (json["week"] as num?)?.toInt();
    totalSale = (json["total_sale"] as num?)?.toDouble();
  }
}
