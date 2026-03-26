
class ExpenseCategoryModel {
    ExpenseCategoryTotals? expenseCategoryTotals;
    String? from;
    String? to;
    int? status;

    ExpenseCategoryModel({this.expenseCategoryTotals, this.from, this.to, this.status});

    ExpenseCategoryModel.fromJson(Map<String, dynamic> json) {
        if(json["ExpenseCategoryTotals"] is Map) {
            expenseCategoryTotals = json["ExpenseCategoryTotals"] == null ? null : ExpenseCategoryTotals.fromJson(json["ExpenseCategoryTotals"]);
        }
        if(json["from"] is String) {
            from = json["from"];
        }
        if(json["to"] is String) {
            to = json["to"];
        }
        if(json["status"] is num) {
            status = (json["status"] as num).toInt();
        }
    }

    static List<ExpenseCategoryModel> fromList(List<Map<String, dynamic>> list) {
        return list.map(ExpenseCategoryModel.fromJson).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        if(expenseCategoryTotals != null) {
            _data["ExpenseCategoryTotals"] = expenseCategoryTotals;
        }
        _data["from"] = from;
        _data["to"] = to;
        _data["status"] = status;
        return _data;
    }

    ExpenseCategoryModel copyWith({
        ExpenseCategoryTotals? expenseCategoryTotals,
        String? from,
        String? to,
        int? status,
    }) => ExpenseCategoryModel(
        expenseCategoryTotals: expenseCategoryTotals ?? this.expenseCategoryTotals,
        from: from ?? this.from,
        to: to ?? this.to,
        status: status ?? this.status,
    );
}

class ExpenseCategoryTotals {
  Map<String, double> categories;

  ExpenseCategoryTotals({required this.categories});

  factory ExpenseCategoryTotals.fromJson(Map<String, dynamic> json) {
    final Map<String, double> temp = {};

    json.forEach((key, value) {
      if (value is num) {
        temp[key] = value.toDouble();
      }
    });

    return ExpenseCategoryTotals(categories: temp);
  }
}