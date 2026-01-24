
class ExpenseReport {
    int? expenseId;
    String? date;
    int? amount;
    String? mainCategory;
    String? subCategory;
    String? expenseUser;
    String? paymentMode;
    String? remarks;
    bool? trash;
    String? invoiceImage;

    ExpenseReport({this.expenseId, this.date, this.amount, this.mainCategory, this.subCategory, this.expenseUser, this.paymentMode, this.remarks, this.trash, this.invoiceImage});

    ExpenseReport.fromJson(Map<String, dynamic> json) {
        if(json["expenseId"] is num) {
            expenseId = (json["expenseId"] as num).toInt();
        }
        if(json["date"] is String) {
            date = json["date"];
        }
        if(json["amount"] is num) {
            amount = (json["amount"] as num).toInt();
        }
        if(json["mainCategory"] is String) {
            mainCategory = json["mainCategory"];
        }
        if(json["subCategory"] is String) {
            subCategory = json["subCategory"];
        }
        if(json["expenseUser"] is String) {
            expenseUser = json["expenseUser"];
        }
        if(json["paymentMode"] is String) {
            paymentMode = json["paymentMode"];
        }
        if(json["remarks"] is String) {
            remarks = json["remarks"];
        }
        if(json["trash"] is bool) {
            trash = json["trash"];
        }
        if(json["invoiceImage"] is String) {
            invoiceImage = json["invoiceImage"];
        }
    }

    static List<ExpenseReport> fromList(List<Map<String, dynamic>> list) {
        return list.map(ExpenseReport.fromJson).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["expenseId"] = expenseId;
        _data["date"] = date;
        _data["amount"] = amount;
        _data["mainCategory"] = mainCategory;
        _data["subCategory"] = subCategory;
        _data["expenseUser"] = expenseUser;
        _data["paymentMode"] = paymentMode;
        _data["remarks"] = remarks;
        _data["trash"] = trash;
        _data["invoiceImage"] = invoiceImage;
        return _data;
    }

    ExpenseReport copyWith({
        int? expenseId,
        String? date,
        int? amount,
        String? mainCategory,
        String? subCategory,
        String? expenseUser,
        String? paymentMode,
        String? remarks,
        bool? trash,
        String? invoiceImage,
    }) => ExpenseReport(
        expenseId: expenseId ?? this.expenseId,
        date: date ?? this.date,
        amount: amount ?? this.amount,
        mainCategory: mainCategory ?? this.mainCategory,
        subCategory: subCategory ?? this.subCategory,
        expenseUser: expenseUser ?? this.expenseUser,
        paymentMode: paymentMode ?? this.paymentMode,
        remarks: remarks ?? this.remarks,
        trash: trash ?? this.trash,
        invoiceImage: invoiceImage ?? this.invoiceImage,
    );
}