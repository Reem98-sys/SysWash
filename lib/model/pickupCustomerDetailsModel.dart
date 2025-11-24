
class PickUpCustomerDetailsModel {
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
    dynamic remarks;
    dynamic notes;
    bool? trash;

    PickUpCustomerDetailsModel({this.pickupassgnId, this.pickupassgn, this.pickupDate, this.pickupCustomerId, this.pickupCustomerName, this.pickupCustomerArea, this.pickupCustomerCode, this.pickupCustomerPhno, this.pickupDriverid, this.pickupDrivername, this.pickupstatus, this.assignedFrom, this.pickupOrderId, this.remarks, this.notes, this.trash});

    PickUpCustomerDetailsModel.fromJson(Map<String, dynamic> json) {
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
        remarks = json["remarks"];
        notes = json["notes"];
        if(json["trash"] is bool) {
            trash = json["trash"];
        }
    }

    static List<PickUpCustomerDetailsModel> fromList(List<Map<String, dynamic>> list) {
        return list.map(PickUpCustomerDetailsModel.fromJson).toList();
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
        _data["remarks"] = remarks;
        _data["notes"] = notes;
        _data["trash"] = trash;
        return _data;
    }

    PickUpCustomerDetailsModel copyWith({
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
        dynamic remarks,
        dynamic notes,
        bool? trash,
    }) => PickUpCustomerDetailsModel(
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
        remarks: remarks ?? this.remarks,
        notes: notes ?? this.notes,
        trash: trash ?? this.trash,
    );
}