class AdminEditHistory {
  int? id;
  String? invoiceNo;
  String? editedDate;
  String? editedBy;
  List<EditedDetails>? editedDetails;
  String? editedTime;
  bool? trash;

  AdminEditHistory({
    this.id,
    this.invoiceNo,
    this.editedDate,
    this.editedBy,
    this.editedDetails,
    this.editedTime,
    this.trash,
  });

  AdminEditHistory.fromJson(Map<String, dynamic> json) {
    if (json["id"] is num) {
      id = (json["id"] as num).toInt();
    }
    if (json["invoice_no"] is String) {
      invoiceNo = json["invoice_no"];
    }
    if (json["edited_date"] is String) {
      editedDate = json["edited_date"];
    }
    if (json["edited_by"] is String) {
      editedBy = json["edited_by"];
    }
    if (json["edited_details"] is List) {
      editedDetails =
          (json["edited_details"] as List)
              .map((e) => EditedDetails.fromJson(e))
              .toList();
    } else if (json["edited_details"] is Map) {
      editedDetails = [
        EditedDetails.fromJson(json["edited_details"] as Map<String, dynamic>),
      ];
    }
    if (json["edited_time"] is String) {
      editedTime = json["edited_time"];
    }
    if (json["trash"] is bool) {
      trash = json["trash"];
    }
  }

  static List<AdminEditHistory> fromList(List<Map<String, dynamic>> list) {
    return list.map(AdminEditHistory.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["invoice_no"] = invoiceNo;
    _data["edited_date"] = editedDate;
    _data["edited_by"] = editedBy;
    if (editedDetails != null) {
      _data["edited_details"] = editedDetails?.map((e) => e.toJson()).toList();
    }
    _data["edited_time"] = editedTime;
    _data["trash"] = trash;
    return _data;
  }

  AdminEditHistory copyWith({
    int? id,
    String? invoiceNo,
    String? editedDate,
    String? editedBy,
    List<EditedDetails>? editedDetails,
    String? editedTime,
    bool? trash,
  }) => AdminEditHistory(
    id: id ?? this.id,
    invoiceNo: invoiceNo ?? this.invoiceNo,
    editedDate: editedDate ?? this.editedDate,
    editedBy: editedBy ?? this.editedBy,
    editedDetails: editedDetails ?? this.editedDetails,
    editedTime: editedTime ?? this.editedTime,
    trash: trash ?? this.trash,
  );
}

class EditedDetails {
  final String title;
  final dynamic value;

  EditedDetails({required this.title, required this.value});

  factory EditedDetails.fromJson(Map<String, dynamic> json) {
    final entry = json.entries.first;
    return EditedDetails(title: entry.key, value: entry.value);
  }
  Map<String, dynamic> toJson() {
    return {title: value};
  }
}

class CustomerCurrencyCodeEdited {
  String? newValue;
  String? oldValue;

  CustomerCurrencyCodeEdited({this.newValue, this.oldValue});

  CustomerCurrencyCodeEdited.fromJson(Map<String, dynamic> json) {
    if (json["new_value"] is String) {
      newValue = json["new_value"];
    }
    if (json["old_value"] is String) {
      oldValue = json["old_value"];
    }
  }

  static List<CustomerCurrencyCodeEdited> fromList(
    List<Map<String, dynamic>> list,
  ) {
    return list.map(CustomerCurrencyCodeEdited.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["new_value"] = newValue;
    _data["old_value"] = oldValue;
    return _data;
  }

  CustomerCurrencyCodeEdited copyWith({String? newValue, String? oldValue}) =>
      CustomerCurrencyCodeEdited(
        newValue: newValue ?? this.newValue,
        oldValue: oldValue ?? this.oldValue,
      );
}
