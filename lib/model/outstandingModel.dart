
class OutstandingModel {
    int? customerId;
    String? customerCode;
    String? customerName;
    int? customerPhno;
    String? area;
    int? totalAmount;
    int? paidamount;
    int? balance;
    String? accountType;

    OutstandingModel({this.customerId, this.customerCode, this.customerName, this.customerPhno, this.area, this.totalAmount, this.paidamount, this.balance, this.accountType});

    OutstandingModel.fromJson(Map<String, dynamic> json) {
        if(json["CustomerId"] is num) {
            customerId = (json["CustomerId"] as num).toInt();
        }
        if(json["CustomerCode"] is String) {
            customerCode = json["CustomerCode"];
        }
        if(json["CustomerName"] is String) {
            customerName = json["CustomerName"];
        }
        if(json["CustomerPhno"] is num) {
            customerPhno = (json["CustomerPhno"] as num).toInt();
        }
        if(json["Area"] is String) {
            area = json["Area"];
        }
        if(json["TotalAmount"] is num) {
            totalAmount = (json["TotalAmount"] as num).toInt();
        }
        if(json["Paidamount"] is num) {
            paidamount = (json["Paidamount"] as num).toInt();
        }
        if(json["Balance"] is num) {
            balance = (json["Balance"] as num).toInt();
        }
        if(json["AccountType"] is String) {
            accountType = json["AccountType"];
        }
    }

    static List<OutstandingModel> fromList(List<Map<String, dynamic>> list) {
        return list.map(OutstandingModel.fromJson).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["CustomerId"] = customerId;
        _data["CustomerCode"] = customerCode;
        _data["CustomerName"] = customerName;
        _data["CustomerPhno"] = customerPhno;
        _data["Area"] = area;
        _data["TotalAmount"] = totalAmount;
        _data["Paidamount"] = paidamount;
        _data["Balance"] = balance;
        _data["AccountType"] = accountType;
        return _data;
    }

    OutstandingModel copyWith({
        int? customerId,
        String? customerCode,
        String? customerName,
        int? customerPhno,
        String? area,
        int? totalAmount,
        int? paidamount,
        int? balance,
        String? accountType,
    }) => OutstandingModel(
        customerId: customerId ?? this.customerId,
        customerCode: customerCode ?? this.customerCode,
        customerName: customerName ?? this.customerName,
        customerPhno: customerPhno ?? this.customerPhno,
        area: area ?? this.area,
        totalAmount: totalAmount ?? this.totalAmount,
        paidamount: paidamount ?? this.paidamount,
        balance: balance ?? this.balance,
        accountType: accountType ?? this.accountType,
    );
}