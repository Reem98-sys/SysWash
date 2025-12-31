
class PickupOrderItemsModel {
    int? orderId;
    String? refNo;
    String? remarks;
    List<dynamic>? payment;
    List<dynamic>? editHistory;
    List<Deliveryassgn>? deliveryassgn;
    int? dueDate;
    int? previousPaidAmount;
    String? orderDate;
    String? orderTime;
    String? deliveryDate;
    String? deliveryTime;
    String? deliveredDateTime;
    dynamic lastModifieddate;
    dynamic lastModifiedTime;
    String? customerId;
    String? customerCode;
    String? customerName;
    int? customerPhno;
    String? customerAddress;
    String? customerStreet;
    String? customerReffrNo;
    String? customerHotel;
    String? customerRoomNo;
    String? villaAddress;
    int? customerDiscount;
    String? cusfragrance;
    dynamic employeeId;
    dynamic employeeName;
    int? driverId;
    String? driverName;
    int? pickupDriverId;
    String? pickupDriverName;
    int? quantity;
    String? subTotal;
    String? discount;
    String? totalAmount;
    String? paidAmount;
    String? balance;
    dynamic bill;
    String? deliveryType;
    String? accountType;
    dynamic paymentMode;
    List<ClothData>? clothData;
    dynamic clothWiseStatus;
    bool? folded;
    bool? hanger;
    bool? packing;
    String? status;
    dynamic rackName;
    dynamic rackFloor;
    dynamic clothAndMechineId;
    int? tenderCurrency;
    int? commission;
    String? tenderDate;
    dynamic tenderTime;
    String? billReceiver;
    bool? pickupStatus;
    String? nasha;
    String? orderReceiver;
    int? wallet;
    int? vat;
    int? vatValue;
    int? openingBalance;
    String? packingType;
    String? starch;
    dynamic paymentremarks;
    bool? trash;

    PickupOrderItemsModel({this.orderId, this.refNo, this.remarks, this.payment, this.editHistory, this.deliveryassgn, this.dueDate, this.previousPaidAmount, this.orderDate, this.orderTime, this.deliveryDate, this.deliveryTime, this.deliveredDateTime, this.lastModifieddate, this.lastModifiedTime, this.customerId, this.customerCode, this.customerName, this.customerPhno, this.customerAddress, this.customerStreet, this.customerReffrNo, this.customerHotel, this.customerRoomNo, this.villaAddress, this.customerDiscount, this.cusfragrance, this.employeeId, this.employeeName, this.driverId, this.driverName, this.pickupDriverId, this.pickupDriverName, this.quantity, this.subTotal, this.discount, this.totalAmount, this.paidAmount, this.balance, this.bill, this.deliveryType, this.accountType, this.paymentMode, this.clothData, this.clothWiseStatus, this.folded, this.hanger, this.packing, this.status, this.rackName, this.rackFloor, this.clothAndMechineId, this.tenderCurrency, this.commission, this.tenderDate, this.tenderTime, this.billReceiver, this.pickupStatus, this.nasha, this.orderReceiver, this.wallet, this.vat, this.vatValue, this.openingBalance, this.packingType, this.starch, this.paymentremarks, this.trash});

    PickupOrderItemsModel.fromJson(Map<String, dynamic> json) {
        if(json["orderId"] is num) {
            orderId = (json["orderId"] as num).toInt();
        }
        if(json["refNo"] is String) {
            refNo = json["refNo"];
        }
        if(json["remarks"] is String) {
            remarks = json["remarks"];
        }
        if(json["payment"] is List) {
            payment = json["payment"] ?? [];
        }
        if(json["edit_history"] is List) {
            editHistory = json["edit_history"] ?? [];
        }
        if(json["deliveryassgn"] is List) {
            deliveryassgn = json["deliveryassgn"] == null ? null : (json["deliveryassgn"] as List).map((e) => Deliveryassgn.fromJson(e)).toList();
        }
        if(json["due_date"] is num) {
            dueDate = (json["due_date"] as num).toInt();
        }
        if(json["previousPaidAmount"] is num) {
            previousPaidAmount = (json["previousPaidAmount"] as num).toInt();
        }
        if(json["orderDate"] is String) {
            orderDate = json["orderDate"];
        }
        if(json["orderTime"] is String) {
            orderTime = json["orderTime"];
        }
        if(json["deliveryDate"] is String) {
            deliveryDate = json["deliveryDate"];
        }
        if(json["deliveryTime"] is String) {
            deliveryTime = json["deliveryTime"];
        }
        if(json["deliveredDateTime"] is String) {
            deliveredDateTime = json["deliveredDateTime"];
        }
        lastModifieddate = json["lastModifieddate"];
        lastModifiedTime = json["lastModifiedTime"];
        if(json["customerId"] is String) {
            customerId = json["customerId"];
        }
        if(json["customerCode"] is String) {
            customerCode = json["customerCode"];
        }
        if(json["customerName"] is String) {
            customerName = json["customerName"];
        }
        if(json["customerPhno"] is num) {
            customerPhno = (json["customerPhno"] as num).toInt();
        }
        if(json["customerAddress"] is String) {
            customerAddress = json["customerAddress"];
        }
        if(json["customerStreet"] is String) {
            customerStreet = json["customerStreet"];
        }
        if(json["customerReffrNo"] is String) {
            customerReffrNo = json["customerReffrNo"];
        }
        if(json["customerHotel"] is String) {
            customerHotel = json["customerHotel"];
        }
        if(json["customerRoomNo"] is String) {
            customerRoomNo = json["customerRoomNo"];
        }
        if(json["villaAddress"] is String) {
            villaAddress = json["villaAddress"];
        }
        if(json["customerDiscount"] is num) {
            customerDiscount = (json["customerDiscount"] as num).toInt();
        }
        if(json["cusfragrance"] is String) {
            cusfragrance = json["cusfragrance"];
        }
        employeeId = json["employeeId"];
        employeeName = json["employeeName"];
        if(json["driverId"] is num) {
            driverId = (json["driverId"] as num).toInt();
        }
        if(json["driverName"] is String) {
            driverName = json["driverName"];
        }
        if(json["pickupDriverId"] is num) {
            pickupDriverId = (json["pickupDriverId"] as num).toInt();
        }
        if(json["pickupDriverName"] is String) {
            pickupDriverName = json["pickupDriverName"];
        }
        if(json["quantity"] is num) {
            quantity = (json["quantity"] as num).toInt();
        }
        if(json["subTotal"] is String) {
            subTotal = json["subTotal"];
        }
        if(json["discount"] is String) {
            discount = json["discount"];
        }
        if(json["totalAmount"] is String) {
            totalAmount = json["totalAmount"];
        }
        if(json["paidAmount"] is String) {
            paidAmount = json["paidAmount"];
        }
        if(json["balance"] is String) {
            balance = json["balance"];
        }
        bill = json["bill"];
        if(json["deliveryType"] is String) {
            deliveryType = json["deliveryType"];
        }
        if(json["accountType"] is String) {
            accountType = json["accountType"];
        }
        paymentMode = json["paymentMode"];
        if(json["clothData"] is List) {
            clothData = json["clothData"] == null ? null : (json["clothData"] as List).map((e) => ClothData.fromJson(e)).toList();
        }
        clothWiseStatus = json["ClothWiseStatus"];
        if(json["folded"] is bool) {
            folded = json["folded"];
        }
        if(json["hanger"] is bool) {
            hanger = json["hanger"];
        }
        if(json["packing"] is bool) {
            packing = json["packing"];
        }
        if(json["status"] is String) {
            status = json["status"];
        }
        rackName = json["rackName"];
        rackFloor = json["rackFloor"];
        clothAndMechineId = json["clothAndMechineId"];
        if(json["tenderCurrency"] is num) {
            tenderCurrency = (json["tenderCurrency"] as num).toInt();
        }
        if(json["commission"] is num) {
            commission = (json["commission"] as num).toInt();
        }
        if(json["tenderDate"] is String) {
            tenderDate = json["tenderDate"];
        }
        tenderTime = json["tenderTime"];
        if(json["billReceiver"] is String) {
            billReceiver = json["billReceiver"];
        }
        if(json["pickupStatus"] is bool) {
            pickupStatus = json["pickupStatus"];
        }
        if(json["nasha"] is String) {
            nasha = json["nasha"];
        }
        if(json["orderReceiver"] is String) {
            orderReceiver = json["orderReceiver"];
        }
        if(json["wallet"] is num) {
            wallet = (json["wallet"] as num).toInt();
        }
        if(json["vat"] is num) {
            vat = (json["vat"] as num).toInt();
        }
        if(json["vatValue"] is num) {
            vatValue = (json["vatValue"] as num).toInt();
        }
        if(json["openingBalance"] is num) {
            openingBalance = (json["openingBalance"] as num).toInt();
        }
        if(json["packingType"] is String) {
            packingType = json["packingType"];
        }
        if(json["starch"] is String) {
            starch = json["starch"];
        }
        paymentremarks = json["paymentremarks"];
        if(json["trash"] is bool) {
            trash = json["trash"];
        }
    }

    static List<PickupOrderItemsModel> fromList(List<Map<String, dynamic>> list) {
        return list.map(PickupOrderItemsModel.fromJson).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["orderId"] = orderId;
        _data["refNo"] = refNo;
        _data["remarks"] = remarks;
        if(payment != null) {
            _data["payment"] = payment;
        }
        if(editHistory != null) {
            _data["edit_history"] = editHistory;
        }
        if(deliveryassgn != null) {
            _data["deliveryassgn"] = deliveryassgn?.map((e) => e.toJson()).toList();
        }
        _data["due_date"] = dueDate;
        _data["previousPaidAmount"] = previousPaidAmount;
        _data["orderDate"] = orderDate;
        _data["orderTime"] = orderTime;
        _data["deliveryDate"] = deliveryDate;
        _data["deliveryTime"] = deliveryTime;
        _data["deliveredDateTime"] = deliveredDateTime;
        _data["lastModifieddate"] = lastModifieddate;
        _data["lastModifiedTime"] = lastModifiedTime;
        _data["customerId"] = customerId;
        _data["customerCode"] = customerCode;
        _data["customerName"] = customerName;
        _data["customerPhno"] = customerPhno;
        _data["customerAddress"] = customerAddress;
        _data["customerStreet"] = customerStreet;
        _data["customerReffrNo"] = customerReffrNo;
        _data["customerHotel"] = customerHotel;
        _data["customerRoomNo"] = customerRoomNo;
        _data["villaAddress"] = villaAddress;
        _data["customerDiscount"] = customerDiscount;
        _data["cusfragrance"] = cusfragrance;
        _data["employeeId"] = employeeId;
        _data["employeeName"] = employeeName;
        _data["driverId"] = driverId;
        _data["driverName"] = driverName;
        _data["pickupDriverId"] = pickupDriverId;
        _data["pickupDriverName"] = pickupDriverName;
        _data["quantity"] = quantity;
        _data["subTotal"] = subTotal;
        _data["discount"] = discount;
        _data["totalAmount"] = totalAmount;
        _data["paidAmount"] = paidAmount;
        _data["balance"] = balance;
        _data["bill"] = bill;
        _data["deliveryType"] = deliveryType;
        _data["accountType"] = accountType;
        _data["paymentMode"] = paymentMode;
        if(clothData != null) {
            _data["clothData"] = clothData?.map((e) => e.toJson()).toList();
        }
        _data["ClothWiseStatus"] = clothWiseStatus;
        _data["folded"] = folded;
        _data["hanger"] = hanger;
        _data["packing"] = packing;
        _data["status"] = status;
        _data["rackName"] = rackName;
        _data["rackFloor"] = rackFloor;
        _data["clothAndMechineId"] = clothAndMechineId;
        _data["tenderCurrency"] = tenderCurrency;
        _data["commission"] = commission;
        _data["tenderDate"] = tenderDate;
        _data["tenderTime"] = tenderTime;
        _data["billReceiver"] = billReceiver;
        _data["pickupStatus"] = pickupStatus;
        _data["nasha"] = nasha;
        _data["orderReceiver"] = orderReceiver;
        _data["wallet"] = wallet;
        _data["vat"] = vat;
        _data["vatValue"] = vatValue;
        _data["openingBalance"] = openingBalance;
        _data["packingType"] = packingType;
        _data["starch"] = starch;
        _data["paymentremarks"] = paymentremarks;
        _data["trash"] = trash;
        return _data;
    }

    PickupOrderItemsModel copyWith({
        int? orderId,
        String? refNo,
        String? remarks,
        List<dynamic>? payment,
        List<dynamic>? editHistory,
        List<Deliveryassgn>? deliveryassgn,
        int? dueDate,
        int? previousPaidAmount,
        String? orderDate,
        String? orderTime,
        String? deliveryDate,
        String? deliveryTime,
        String? deliveredDateTime,
        dynamic lastModifieddate,
        dynamic lastModifiedTime,
        String? customerId,
        String? customerCode,
        String? customerName,
        int? customerPhno,
        String? customerAddress,
        String? customerStreet,
        String? customerReffrNo,
        String? customerHotel,
        String? customerRoomNo,
        String? villaAddress,
        int? customerDiscount,
        String? cusfragrance,
        dynamic employeeId,
        dynamic employeeName,
        int? driverId,
        String? driverName,
        int? pickupDriverId,
        String? pickupDriverName,
        int? quantity,
        String? subTotal,
        String? discount,
        String? totalAmount,
        String? paidAmount,
        String? balance,
        dynamic bill,
        String? deliveryType,
        String? accountType,
        dynamic paymentMode,
        List<ClothData>? clothData,
        dynamic clothWiseStatus,
        bool? folded,
        bool? hanger,
        bool? packing,
        String? status,
        dynamic rackName,
        dynamic rackFloor,
        dynamic clothAndMechineId,
        int? tenderCurrency,
        int? commission,
        String? tenderDate,
        dynamic tenderTime,
        String? billReceiver,
        bool? pickupStatus,
        String? nasha,
        String? orderReceiver,
        int? wallet,
        int? vat,
        int? vatValue,
        int? openingBalance,
        String? packingType,
        String? starch,
        dynamic paymentremarks,
        bool? trash,
    }) => PickupOrderItemsModel(
        orderId: orderId ?? this.orderId,
        refNo: refNo ?? this.refNo,
        remarks: remarks ?? this.remarks,
        payment: payment ?? this.payment,
        editHistory: editHistory ?? this.editHistory,
        deliveryassgn: deliveryassgn ?? this.deliveryassgn,
        dueDate: dueDate ?? this.dueDate,
        previousPaidAmount: previousPaidAmount ?? this.previousPaidAmount,
        orderDate: orderDate ?? this.orderDate,
        orderTime: orderTime ?? this.orderTime,
        deliveryDate: deliveryDate ?? this.deliveryDate,
        deliveryTime: deliveryTime ?? this.deliveryTime,
        deliveredDateTime: deliveredDateTime ?? this.deliveredDateTime,
        lastModifieddate: lastModifieddate ?? this.lastModifieddate,
        lastModifiedTime: lastModifiedTime ?? this.lastModifiedTime,
        customerId: customerId ?? this.customerId,
        customerCode: customerCode ?? this.customerCode,
        customerName: customerName ?? this.customerName,
        customerPhno: customerPhno ?? this.customerPhno,
        customerAddress: customerAddress ?? this.customerAddress,
        customerStreet: customerStreet ?? this.customerStreet,
        customerReffrNo: customerReffrNo ?? this.customerReffrNo,
        customerHotel: customerHotel ?? this.customerHotel,
        customerRoomNo: customerRoomNo ?? this.customerRoomNo,
        villaAddress: villaAddress ?? this.villaAddress,
        customerDiscount: customerDiscount ?? this.customerDiscount,
        cusfragrance: cusfragrance ?? this.cusfragrance,
        employeeId: employeeId ?? this.employeeId,
        employeeName: employeeName ?? this.employeeName,
        driverId: driverId ?? this.driverId,
        driverName: driverName ?? this.driverName,
        pickupDriverId: pickupDriverId ?? this.pickupDriverId,
        pickupDriverName: pickupDriverName ?? this.pickupDriverName,
        quantity: quantity ?? this.quantity,
        subTotal: subTotal ?? this.subTotal,
        discount: discount ?? this.discount,
        totalAmount: totalAmount ?? this.totalAmount,
        paidAmount: paidAmount ?? this.paidAmount,
        balance: balance ?? this.balance,
        bill: bill ?? this.bill,
        deliveryType: deliveryType ?? this.deliveryType,
        accountType: accountType ?? this.accountType,
        paymentMode: paymentMode ?? this.paymentMode,
        clothData: clothData ?? this.clothData,
        clothWiseStatus: clothWiseStatus ?? this.clothWiseStatus,
        folded: folded ?? this.folded,
        hanger: hanger ?? this.hanger,
        packing: packing ?? this.packing,
        status: status ?? this.status,
        rackName: rackName ?? this.rackName,
        rackFloor: rackFloor ?? this.rackFloor,
        clothAndMechineId: clothAndMechineId ?? this.clothAndMechineId,
        tenderCurrency: tenderCurrency ?? this.tenderCurrency,
        commission: commission ?? this.commission,
        tenderDate: tenderDate ?? this.tenderDate,
        tenderTime: tenderTime ?? this.tenderTime,
        billReceiver: billReceiver ?? this.billReceiver,
        pickupStatus: pickupStatus ?? this.pickupStatus,
        nasha: nasha ?? this.nasha,
        orderReceiver: orderReceiver ?? this.orderReceiver,
        wallet: wallet ?? this.wallet,
        vat: vat ?? this.vat,
        vatValue: vatValue ?? this.vatValue,
        openingBalance: openingBalance ?? this.openingBalance,
        packingType: packingType ?? this.packingType,
        starch: starch ?? this.starch,
        paymentremarks: paymentremarks ?? this.paymentremarks,
        trash: trash ?? this.trash,
    );
    factory PickupOrderItemsModel.empty() {
    return PickupOrderItemsModel(
      clothData: [],
      quantity: 0,
      remarks: '',
    );
  }
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

class Deliveryassgn {
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
    String? paymentremarks;
    bool? trash;
    int? deliveryInvoiceNo;

    Deliveryassgn({this.deliveryassgnId, this.deliveryDate, this.deliveryTime, this.deliveryCustomerId, this.deliveryCustomerName, this.deliveryCustomerArea, this.deliveryCustomerCode, this.deliveryCustomerPhno, this.deliveryDriverid, this.deliveryDrivername, this.status, this.paymentstatus, this.paymentMode, this.paymentremarks, this.trash, this.deliveryInvoiceNo});

    Deliveryassgn.fromJson(Map<String, dynamic> json) {
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
        if(json["paymentremarks"] is String) {
            paymentremarks = json["paymentremarks"];
        }
        if(json["trash"] is bool) {
            trash = json["trash"];
        }
        if(json["deliveryInvoiceNo"] is num) {
            deliveryInvoiceNo = (json["deliveryInvoiceNo"] as num).toInt();
        }
    }

    static List<Deliveryassgn> fromList(List<Map<String, dynamic>> list) {
        return list.map(Deliveryassgn.fromJson).toList();
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
        _data["paymentremarks"] = paymentremarks;
        _data["trash"] = trash;
        _data["deliveryInvoiceNo"] = deliveryInvoiceNo;
        return _data;
    }

    Deliveryassgn copyWith({
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
        String? paymentremarks,
        bool? trash,
        int? deliveryInvoiceNo,
    }) => Deliveryassgn(
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
        paymentremarks: paymentremarks ?? this.paymentremarks,
        trash: trash ?? this.trash,
        deliveryInvoiceNo: deliveryInvoiceNo ?? this.deliveryInvoiceNo,
    );
}