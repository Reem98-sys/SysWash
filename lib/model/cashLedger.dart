
class CashLedger {
    int? order;
    String? orderDate;
    String? paymentDate;
    String? paymentTime;
    String? customerName;
    String? paymentMode;
    String? billReceiver;
    int? paidAmount;
    String? paymentremarks;

    CashLedger({this.order, this.orderDate, this.paymentDate, this.paymentTime, this.customerName, this.paymentMode, this.billReceiver, this.paidAmount, this.paymentremarks});

    CashLedger.fromJson(Map<String, dynamic> json) {
        if(json["order"] is num) {
            order = (json["order"] as num).toInt();
        }
        if(json["orderDate"] is String) {
            orderDate = json["orderDate"];
        }
        if(json["paymentDate"] is String) {
            paymentDate = json["paymentDate"];
        }
        if(json["paymentTime"] is String) {
            paymentTime = json["paymentTime"];
        }
        if(json["customerName"] is String) {
            customerName = json["customerName"];
        }
        if(json["paymentMode"] is String) {
            paymentMode = json["paymentMode"];
        }
        if(json["billReceiver"] is String) {
            billReceiver = json["billReceiver"];
        }
        if(json["paidAmount"] is num) {
            paidAmount = (json["paidAmount"] as num).toInt();
        }
        if(json["paymentremarks"] is String) {
            paymentremarks = json["paymentremarks"];
        }
    }

    static List<CashLedger> fromList(List<Map<String, dynamic>> list) {
        return list.map(CashLedger.fromJson).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["order"] = order;
        _data["orderDate"] = orderDate;
        _data["paymentDate"] = paymentDate;
        _data["paymentTime"] = paymentTime;
        _data["customerName"] = customerName;
        _data["paymentMode"] = paymentMode;
        _data["billReceiver"] = billReceiver;
        _data["paidAmount"] = paidAmount;
        _data["paymentremarks"] = paymentremarks;
        return _data;
    }

    CashLedger copyWith({
        int? order,
        String? orderDate,
        String? paymentDate,
        String? paymentTime,
        String? customerName,
        String? paymentMode,
        String? billReceiver,
        int? paidAmount,
        String? paymentremarks,
    }) => CashLedger(
        order: order ?? this.order,
        orderDate: orderDate ?? this.orderDate,
        paymentDate: paymentDate ?? this.paymentDate,
        paymentTime: paymentTime ?? this.paymentTime,
        customerName: customerName ?? this.customerName,
        paymentMode: paymentMode ?? this.paymentMode,
        billReceiver: billReceiver ?? this.billReceiver,
        paidAmount: paidAmount ?? this.paidAmount,
        paymentremarks: paymentremarks ?? this.paymentremarks,
    );
}