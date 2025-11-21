
class DeliveryListModel {
    int? deliveryassgnId;
    String? deliveryDate;
    String? deliveryTime;
    String? deliveryCustomerId;
    String? deliveryCustomerName;
    String? deliveryCustomerArea;
    String? deliveryCustomerCode;
    int? deliveryCustomerPhno;
    int? deliveryDriverid;
    String? deliveryDrivername;
    String? status;
    String? paymentstatus;
    String? paymentMode;
    bool? trash;
    int? deliveryInvoiceNo;

    DeliveryListModel({this.deliveryassgnId, this.deliveryDate, this.deliveryTime, this.deliveryCustomerId, this.deliveryCustomerName, this.deliveryCustomerArea, this.deliveryCustomerCode, this.deliveryCustomerPhno, this.deliveryDriverid, this.deliveryDrivername, this.status, this.paymentstatus, this.paymentMode, this.trash, this.deliveryInvoiceNo});

    DeliveryListModel.fromJson(Map<String, dynamic> json) {
        if(json["deliveryassgnId"] is num) {
            deliveryassgnId = (json["deliveryassgnId"] as num).toInt();
        }
        if(json["deliveryDate"] is String) {
            deliveryDate = json["deliveryDate"];
        }
        if(json["deliveryTime"] is String) {
            deliveryTime = json["deliveryTime"];
        }
        if(json["deliveryCustomerId"] is String) {
            deliveryCustomerId = json["deliveryCustomerId"];
        }
        if(json["deliveryCustomerName"] is String) {
            deliveryCustomerName = json["deliveryCustomerName"];
        }
        if(json["deliveryCustomerArea"] is String) {
            deliveryCustomerArea = json["deliveryCustomerArea"];
        }
        if(json["deliveryCustomerCode"] is String) {
            deliveryCustomerCode = json["deliveryCustomerCode"];
        }
        if(json["deliveryCustomerPhno"] is num) {
            deliveryCustomerPhno = (json["deliveryCustomerPhno"] as num).toInt();
        }
        if(json["deliveryDriverid"] is num) {
            deliveryDriverid = (json["deliveryDriverid"] as num).toInt();
        }
        if(json["deliveryDrivername"] is String) {
            deliveryDrivername = json["deliveryDrivername"];
        }
        if(json["status"] is String) {
            status = json["status"];
        }
        if(json["paymentstatus"] is String) {
            paymentstatus = json["paymentstatus"];
        }
        if(json["paymentMode"] is String) {
            paymentMode = json["paymentMode"];
        }
        if(json["trash"] is bool) {
            trash = json["trash"];
        }
        if(json["deliveryInvoiceNo"] is num) {
            deliveryInvoiceNo = (json["deliveryInvoiceNo"] as num).toInt();
        }
    }

    static List<DeliveryListModel> fromList(List<Map<String, dynamic>> list) {
        return list.map(DeliveryListModel.fromJson).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["deliveryassgnId"] = deliveryassgnId;
        _data["deliveryDate"] = deliveryDate;
        _data["deliveryTime"] = deliveryTime;
        _data["deliveryCustomerId"] = deliveryCustomerId;
        _data["deliveryCustomerName"] = deliveryCustomerName;
        _data["deliveryCustomerArea"] = deliveryCustomerArea;
        _data["deliveryCustomerCode"] = deliveryCustomerCode;
        _data["deliveryCustomerPhno"] = deliveryCustomerPhno;
        _data["deliveryDriverid"] = deliveryDriverid;
        _data["deliveryDrivername"] = deliveryDrivername;
        _data["status"] = status;
        _data["paymentstatus"] = paymentstatus;
        _data["paymentMode"] = paymentMode;
        _data["trash"] = trash;
        _data["deliveryInvoiceNo"] = deliveryInvoiceNo;
        return _data;
    }

    DeliveryListModel copyWith({
        int? deliveryassgnId,
        String? deliveryDate,
        String? deliveryTime,
        String? deliveryCustomerId,
        String? deliveryCustomerName,
        String? deliveryCustomerArea,
        String? deliveryCustomerCode,
        int? deliveryCustomerPhno,
        int? deliveryDriverid,
        String? deliveryDrivername,
        String? status,
        String? paymentstatus,
        String? paymentMode,
        bool? trash,
        int? deliveryInvoiceNo,
    }) => DeliveryListModel(
        deliveryassgnId: deliveryassgnId ?? this.deliveryassgnId,
        deliveryDate: deliveryDate ?? this.deliveryDate,
        deliveryTime: deliveryTime ?? this.deliveryTime,
        deliveryCustomerId: deliveryCustomerId ?? this.deliveryCustomerId,
        deliveryCustomerName: deliveryCustomerName ?? this.deliveryCustomerName,
        deliveryCustomerArea: deliveryCustomerArea ?? this.deliveryCustomerArea,
        deliveryCustomerCode: deliveryCustomerCode ?? this.deliveryCustomerCode,
        deliveryCustomerPhno: deliveryCustomerPhno ?? this.deliveryCustomerPhno,
        deliveryDriverid: deliveryDriverid ?? this.deliveryDriverid,
        deliveryDrivername: deliveryDrivername ?? this.deliveryDrivername,
        status: status ?? this.status,
        paymentstatus: paymentstatus ?? this.paymentstatus,
        paymentMode: paymentMode ?? this.paymentMode,
        trash: trash ?? this.trash,
        deliveryInvoiceNo: deliveryInvoiceNo ?? this.deliveryInvoiceNo,
    );
}