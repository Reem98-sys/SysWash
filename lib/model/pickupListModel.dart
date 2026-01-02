
class PickUpListModel {
    int? pickupassgnId;
    List<dynamic>? pickupassgn;
    String? pickupDate;
    String? pickupCustomerId;
    String? pickupCustomerName;
    String? pickupCustomerArea;
    String? pickupCustomerCode;
    int? pickupCustomerPhno;
    int? pickupDriverid;
    String? pickupDrivername;
    String? pickupstatus;
    String? assignedFrom;
    String? pickupOrderId;
    bool? trash;
    String? remarks;
    String? notes;
    String? pickuptime;

    PickUpListModel({this.pickupassgnId, this.pickupassgn, this.pickupDate, this.pickupCustomerId, this.pickupCustomerName, this.pickupCustomerArea, this.pickupCustomerCode, this.pickupCustomerPhno, this.pickupDriverid, this.pickupDrivername, this.pickupstatus, this.assignedFrom, this.pickupOrderId, this.trash, this.remarks, this.notes, this.pickuptime});

    PickUpListModel.fromJson(Map<String, dynamic> json) {
        if(json["pickupassgnId"] is num) {
            pickupassgnId = (json["pickupassgnId"] as num).toInt();
        }
        if(json["pickupassgn"] is List) {
            pickupassgn = json["pickupassgn"] ?? [];
        }
        if(json["pickupDate"] is String) {
            pickupDate = json["pickupDate"];
        }
        if(json["pickupCustomerId"] is String) {
            pickupCustomerId = json["pickupCustomerId"];
        }
        if(json["pickupCustomerName"] is String) {
            pickupCustomerName = json["pickupCustomerName"];
        }
        if(json["pickupCustomerArea"] is String) {
            pickupCustomerArea = json["pickupCustomerArea"];
        }
        if(json["pickupCustomerCode"] is String) {
            pickupCustomerCode = json["pickupCustomerCode"];
        }
        if(json["pickupCustomerPhno"] is num) {
            pickupCustomerPhno = (json["pickupCustomerPhno"] as num).toInt();
        }
        if(json["pickupDriverid"] is num) {
            pickupDriverid = (json["pickupDriverid"] as num).toInt();
        }
        if(json["pickupDrivername"] is String) {
            pickupDrivername = json["pickupDrivername"];
        }
        if(json["pickupstatus"] is String) {
            pickupstatus = json["pickupstatus"];
        }
        if(json["AssignedFrom"] is String) {
            assignedFrom = json["AssignedFrom"];
        }
        if(json["pickupOrderId"] is String) {
            pickupOrderId = json["pickupOrderId"];
        }
        if(json["trash"] is bool) {
            trash = json["trash"];
        }
        if(json["remarks"] is String) {
            remarks = json["remarks"];
        }
        if(json["notes"] is String) {
            notes = json["notes"];
        }
        if(json["pickuptime"] is String) {
            pickuptime = json["pickuptime"];
        }
    }

    static List<PickUpListModel> fromList(List<Map<String, dynamic>> list) {
        return list.map(PickUpListModel.fromJson).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["pickupassgnId"] = pickupassgnId;
        if(pickupassgn != null) {
            _data["pickupassgn"] = pickupassgn;
        }
        _data["pickupDate"] = pickupDate;
        _data["pickupCustomerId"] = pickupCustomerId;
        _data["pickupCustomerName"] = pickupCustomerName;
        _data["pickupCustomerArea"] = pickupCustomerArea;
        _data["pickupCustomerCode"] = pickupCustomerCode;
        _data["pickupCustomerPhno"] = pickupCustomerPhno;
        _data["pickupDriverid"] = pickupDriverid;
        _data["pickupDrivername"] = pickupDrivername;
        _data["pickupstatus"] = pickupstatus;
        _data["AssignedFrom"] = assignedFrom;
        _data["pickupOrderId"] = pickupOrderId;
        _data["trash"] = trash;
        _data["remarks"] = remarks;
        _data["notes"] = notes;
        _data["pickuptime"] = pickuptime;
        return _data;
    }

    PickUpListModel copyWith({
        int? pickupassgnId,
        List<dynamic>? pickupassgn,
        String? pickupDate,
        String? pickupCustomerId,
        String? pickupCustomerName,
        String? pickupCustomerArea,
        String? pickupCustomerCode,
        int? pickupCustomerPhno,
        int? pickupDriverid,
        String? pickupDrivername,
        String? pickupstatus,
        String? assignedFrom,
        String? pickupOrderId,
        bool? trash,
        String? remarks,
        String? notes,
        String? pickuptime,
    }) => PickUpListModel(
        pickupassgnId: pickupassgnId ?? this.pickupassgnId,
        pickupassgn: pickupassgn ?? this.pickupassgn,
        pickupDate: pickupDate ?? this.pickupDate,
        pickupCustomerId: pickupCustomerId ?? this.pickupCustomerId,
        pickupCustomerName: pickupCustomerName ?? this.pickupCustomerName,
        pickupCustomerArea: pickupCustomerArea ?? this.pickupCustomerArea,
        pickupCustomerCode: pickupCustomerCode ?? this.pickupCustomerCode,
        pickupCustomerPhno: pickupCustomerPhno ?? this.pickupCustomerPhno,
        pickupDriverid: pickupDriverid ?? this.pickupDriverid,
        pickupDrivername: pickupDrivername ?? this.pickupDrivername,
        pickupstatus: pickupstatus ?? this.pickupstatus,
        assignedFrom: assignedFrom ?? this.assignedFrom,
        pickupOrderId: pickupOrderId ?? this.pickupOrderId,
        trash: trash ?? this.trash,
        remarks: remarks ?? this.remarks,
        notes: notes ?? this.notes,
        pickuptime: pickuptime ?? this.pickuptime,
    );
}