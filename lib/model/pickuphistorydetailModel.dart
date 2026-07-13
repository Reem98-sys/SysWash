
class PickupHistoryDetailModel {
    List<Pickup>? pickup;

    PickupHistoryDetailModel({this.pickup});

    PickupHistoryDetailModel.fromJson(Map<String, dynamic> json) {
        if(json["pickup"] is List) {
            pickup = json["pickup"] == null ? null : (json["pickup"] as List).map((e) => Pickup.fromJson(e)).toList();
        }
    }

    static List<PickupHistoryDetailModel> fromList(List<Map<String, dynamic>> list) {
        return list.map(PickupHistoryDetailModel.fromJson).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        if(pickup != null) {
            _data["pickup"] = pickup?.map((e) => e.toJson()).toList();
        }
        return _data;
    }

    PickupHistoryDetailModel copyWith({
        List<Pickup>? pickup,
    }) => PickupHistoryDetailModel(
        pickup: pickup ?? this.pickup,
    );
}

class Pickup {
    int? pickupassgnId;
    List<Pickupassgn>? pickupassgn;
    String? pickupDate;
    String? pickuptime;
    String? pickupCustomerId;
    String? pickupCustomerName;
    String? pickupCustomerArea;
    String? pickupCustomerCode;
    int? pickupCustomerPhno;
    int? pickupDriverid;
    String? pickupDrivername;
    String? pickupstatus;
    dynamic assignedFrom;
    dynamic pickupOrderId;
    dynamic remarks;
    dynamic notes;
    dynamic orderStatus;
    bool? trash;

    Pickup({this.pickupassgnId, this.pickupassgn, this.pickupDate, this.pickuptime, this.pickupCustomerId, this.pickupCustomerName, this.pickupCustomerArea, this.pickupCustomerCode, this.pickupCustomerPhno, this.pickupDriverid, this.pickupDrivername, this.pickupstatus, this.assignedFrom, this.pickupOrderId, this.remarks, this.notes, this.orderStatus, this.trash});

    Pickup.fromJson(Map<String, dynamic> json) {
        if(json["pickupassgnId"] is num) {
            pickupassgnId = (json["pickupassgnId"] as num).toInt();
        }
        if(json["pickupassgn"] is List) {
            pickupassgn = json["pickupassgn"] == null ? null : (json["pickupassgn"] as List).map((e) => Pickupassgn.fromJson(e)).toList();
        }
        if(json["pickupDate"] is String) {
            pickupDate = json["pickupDate"];
        }
        if(json["pickuptime"] is String) {
            pickuptime = json["pickuptime"];
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
        assignedFrom = json["AssignedFrom"];
        pickupOrderId = json["pickupOrderId"];
        remarks = json["remarks"];
        notes = json["notes"];
        orderStatus = json["orderStatus"];
        if(json["trash"] is bool) {
            trash = json["trash"];
        }
    }

    static List<Pickup> fromList(List<Map<String, dynamic>> list) {
        return list.map(Pickup.fromJson).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["pickupassgnId"] = pickupassgnId;
        if(pickupassgn != null) {
            _data["pickupassgn"] = pickupassgn?.map((e) => e.toJson()).toList();
        }
        _data["pickupDate"] = pickupDate;
        _data["pickuptime"] = pickuptime;
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
        _data["orderStatus"] = orderStatus;
        _data["trash"] = trash;
        return _data;
    }

    Pickup copyWith({
        int? pickupassgnId,
        List<Pickupassgn>? pickupassgn,
        String? pickupDate,
        String? pickuptime,
        String? pickupCustomerId,
        String? pickupCustomerName,
        String? pickupCustomerArea,
        String? pickupCustomerCode,
        int? pickupCustomerPhno,
        int? pickupDriverid,
        String? pickupDrivername,
        String? pickupstatus,
        dynamic assignedFrom,
        dynamic pickupOrderId,
        dynamic remarks,
        dynamic notes,
        dynamic orderStatus,
        bool? trash,
    }) => Pickup(
        pickupassgnId: pickupassgnId ?? this.pickupassgnId,
        pickupassgn: pickupassgn ?? this.pickupassgn,
        pickupDate: pickupDate ?? this.pickupDate,
        pickuptime: pickuptime ?? this.pickuptime,
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
        orderStatus: orderStatus ?? this.orderStatus,
        trash: trash ?? this.trash,
    );
}

class Pickupassgn {
    int? pickuporderId;
    dynamic paymentMode;
    String? pickuporderDate;
    String? pickuporderTime;
    int? quantity;
    int? subTotal;
    int? discount;
    int? totalAmount;
    int? paidAmount;
    int? balance;
    String? deliveryType;
    String? accountType;
    List<ClothData>? clothData;
    dynamic clothWiseStatus;
    String? status;
    dynamic tenderCurrency;
    dynamic tenderDate;
    dynamic tenderTime;
    dynamic billReceiver;
    dynamic referenceno;
    bool? trash;
    int? pickupassgn;

    Pickupassgn({this.pickuporderId, this.paymentMode, this.pickuporderDate, this.pickuporderTime, this.quantity, this.subTotal, this.discount, this.totalAmount, this.paidAmount, this.balance, this.deliveryType, this.accountType, this.clothData, this.clothWiseStatus, this.status, this.tenderCurrency, this.tenderDate, this.tenderTime, this.billReceiver, this.referenceno, this.trash, this.pickupassgn});

    Pickupassgn.fromJson(Map<String, dynamic> json) {
        if(json["pickuporderId"] is num) {
            pickuporderId = (json["pickuporderId"] as num).toInt();
        }
        paymentMode = json["paymentMode"];
        if(json["pickuporderDate"] is String) {
            pickuporderDate = json["pickuporderDate"];
        }
        if(json["pickuporderTime"] is String) {
            pickuporderTime = json["pickuporderTime"];
        }
        if(json["quantity"] is num) {
            quantity = (json["quantity"] as num).toInt();
        }
        if(json["subTotal"] is num) {
            subTotal = (json["subTotal"] as num).toInt();
        }
        if(json["discount"] is num) {
            discount = (json["discount"] as num).toInt();
        }
        if(json["totalAmount"] is num) {
            totalAmount = (json["totalAmount"] as num).toInt();
        }
        if(json["paidAmount"] is num) {
            paidAmount = (json["paidAmount"] as num).toInt();
        }
        if(json["balance"] is num) {
            balance = (json["balance"] as num).toInt();
        }
        if(json["deliveryType"] is String) {
            deliveryType = json["deliveryType"];
        }
        if(json["accountType"] is String) {
            accountType = json["accountType"];
        }
        if(json["clothData"] is List) {
            clothData = json["clothData"] == null ? null : (json["clothData"] as List).map((e) => ClothData.fromJson(e)).toList();
        }
        clothWiseStatus = json["ClothWiseStatus"];
        if(json["status"] is String) {
            status = json["status"];
        }
        tenderCurrency = json["tenderCurrency"];
        tenderDate = json["tenderDate"];
        tenderTime = json["tenderTime"];
        billReceiver = json["billReceiver"];
        referenceno = json["referenceno"];
        if(json["trash"] is bool) {
            trash = json["trash"];
        }
        if(json["pickupassgn"] is num) {
            pickupassgn = (json["pickupassgn"] as num).toInt();
        }
    }

    static List<Pickupassgn> fromList(List<Map<String, dynamic>> list) {
        return list.map(Pickupassgn.fromJson).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["pickuporderId"] = pickuporderId;
        _data["paymentMode"] = paymentMode;
        _data["pickuporderDate"] = pickuporderDate;
        _data["pickuporderTime"] = pickuporderTime;
        _data["quantity"] = quantity;
        _data["subTotal"] = subTotal;
        _data["discount"] = discount;
        _data["totalAmount"] = totalAmount;
        _data["paidAmount"] = paidAmount;
        _data["balance"] = balance;
        _data["deliveryType"] = deliveryType;
        _data["accountType"] = accountType;
        if(clothData != null) {
            _data["clothData"] = clothData?.map((e) => e.toJson()).toList();
        }
        _data["ClothWiseStatus"] = clothWiseStatus;
        _data["status"] = status;
        _data["tenderCurrency"] = tenderCurrency;
        _data["tenderDate"] = tenderDate;
        _data["tenderTime"] = tenderTime;
        _data["billReceiver"] = billReceiver;
        _data["referenceno"] = referenceno;
        _data["trash"] = trash;
        _data["pickupassgn"] = pickupassgn;
        return _data;
    }

    Pickupassgn copyWith({
        int? pickuporderId,
        dynamic paymentMode,
        String? pickuporderDate,
        String? pickuporderTime,
        int? quantity,
        int? subTotal,
        int? discount,
        int? totalAmount,
        int? paidAmount,
        int? balance,
        String? deliveryType,
        String? accountType,
        List<ClothData>? clothData,
        dynamic clothWiseStatus,
        String? status,
        dynamic tenderCurrency,
        dynamic tenderDate,
        dynamic tenderTime,
        dynamic billReceiver,
        dynamic referenceno,
        bool? trash,
        int? pickupassgn,
    }) => Pickupassgn(
        pickuporderId: pickuporderId ?? this.pickuporderId,
        paymentMode: paymentMode ?? this.paymentMode,
        pickuporderDate: pickuporderDate ?? this.pickuporderDate,
        pickuporderTime: pickuporderTime ?? this.pickuporderTime,
        quantity: quantity ?? this.quantity,
        subTotal: subTotal ?? this.subTotal,
        discount: discount ?? this.discount,
        totalAmount: totalAmount ?? this.totalAmount,
        paidAmount: paidAmount ?? this.paidAmount,
        balance: balance ?? this.balance,
        deliveryType: deliveryType ?? this.deliveryType,
        accountType: accountType ?? this.accountType,
        clothData: clothData ?? this.clothData,
        clothWiseStatus: clothWiseStatus ?? this.clothWiseStatus,
        status: status ?? this.status,
        tenderCurrency: tenderCurrency ?? this.tenderCurrency,
        tenderDate: tenderDate ?? this.tenderDate,
        tenderTime: tenderTime ?? this.tenderTime,
        billReceiver: billReceiver ?? this.billReceiver,
        referenceno: referenceno ?? this.referenceno,
        trash: trash ?? this.trash,
        pickupassgn: pickupassgn ?? this.pickupassgn,
    );
}

class ClothData {
    int? qnty;
    String? unit;
    String? billing;
    int? priceId;
    String? service;
    String? clothImg;
    String? clothName;
    String? arabicName;
    String? clothPrice;

    ClothData({this.qnty, this.unit, this.billing, this.priceId, this.service, this.clothImg, this.clothName, this.arabicName, this.clothPrice});

    ClothData.fromJson(Map<String, dynamic> json) {
        if(json["qnty"] is num) {
            qnty = (json["qnty"] as num).toInt();
        }
        if(json["unit"] is String) {
            unit = json["unit"];
        }
        if(json["billing"] is String) {
            billing = json["billing"];
        }
        if(json["priceId"] is num) {
            priceId = (json["priceId"] as num).toInt();
        }
        if(json["service"] is String) {
            service = json["service"];
        }
        if(json["clothImg"] is String) {
            clothImg = json["clothImg"];
        }
        if(json["clothName"] is String) {
            clothName = json["clothName"];
        }
        if(json["arabicName"] is String) {
            arabicName = json["arabicName"];
        }
        if(json["clothPrice"] is String) {
            clothPrice = json["clothPrice"];
        }
    }

    static List<ClothData> fromList(List<Map<String, dynamic>> list) {
        return list.map(ClothData.fromJson).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["qnty"] = qnty;
        _data["unit"] = unit;
        _data["billing"] = billing;
        _data["priceId"] = priceId;
        _data["service"] = service;
        _data["clothImg"] = clothImg;
        _data["clothName"] = clothName;
        _data["arabicName"] = arabicName;
        _data["clothPrice"] = clothPrice;
        return _data;
    }

    ClothData copyWith({
        int? qnty,
        String? unit,
        String? billing,
        int? priceId,
        String? service,
        String? clothImg,
        String? clothName,
        String? arabicName,
        String? clothPrice,
    }) => ClothData(
        qnty: qnty ?? this.qnty,
        unit: unit ?? this.unit,
        billing: billing ?? this.billing,
        priceId: priceId ?? this.priceId,
        service: service ?? this.service,
        clothImg: clothImg ?? this.clothImg,
        clothName: clothName ?? this.clothName,
        arabicName: arabicName ?? this.arabicName,
        clothPrice: clothPrice ?? this.clothPrice,
    );
}