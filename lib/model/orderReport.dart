
class OrderReport {
    int? orderId;
    String? refNo;
    String? remarks;
    List<dynamic>? payment;
    List<EditHistory>? editHistory;
    List<dynamic>? deliveryassgn;
    int? dueDate;
    int? previousPaidAmount;
    String? orderDate;
    String? orderTime;
    String? deliveryDate;
    String? deliveryTime;
    String? lastModifieddate;
    String? lastModifiedTime;
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
    int? quantity;
    String? subTotal;
    String? discount;
    String? totalAmount;
    String? paidAmount;
    String? balance;
    String? bill;
    String? deliveryType;
    String? accountType;
    List<ClothData>? clothData;
    bool? folded;
    bool? hanger;
    bool? packing;
    String? status;
    int? tenderCurrency;
    int? commission;
    String? tenderDate;
    String? tenderTime;
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
    String? paymentremarks;
    String? vatsubTotal;
    bool? trash;
    String? paymentMode;
    List<ClothWiseStatus>? clothWiseStatus;
    int? driverId;
    String? driverName;
    int? pickupDriverId;
    String? pickupDriverName;
    String? employeeId;
    String? employeeName;
    String? rackName;
    String? rackFloor;
    String? deliveredDateTime;

    OrderReport({this.orderId, this.refNo, this.remarks, this.payment, this.editHistory, this.deliveryassgn, this.dueDate, this.previousPaidAmount, this.orderDate, this.orderTime, this.deliveryDate, this.deliveryTime, this.lastModifieddate, this.lastModifiedTime, this.customerId, this.customerCode, this.customerName, this.customerPhno, this.customerAddress, this.customerStreet, this.customerReffrNo, this.customerHotel, this.customerRoomNo, this.villaAddress, this.customerDiscount, this.cusfragrance, this.quantity, this.subTotal, this.discount, this.totalAmount, this.paidAmount, this.balance, this.bill, this.deliveryType, this.accountType, this.clothData, this.folded, this.hanger, this.packing, this.status, this.tenderCurrency, this.commission, this.tenderDate, this.tenderTime, this.billReceiver, this.pickupStatus, this.nasha, this.orderReceiver, this.wallet, this.vat, this.vatValue, this.openingBalance, this.packingType, this.starch, this.paymentremarks, this.vatsubTotal, this.trash, this.paymentMode, this.clothWiseStatus, this.driverId, this.driverName, this.pickupDriverId, this.pickupDriverName, this.employeeId, this.employeeName, this.rackName, this.rackFloor, this.deliveredDateTime});

    OrderReport.fromJson(Map<String, dynamic> json) {
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
            editHistory = json["edit_history"] == null ? null : (json["edit_history"] as List).map((e) => EditHistory.fromJson(e)).toList();
        }
        if(json["deliveryassgn"] is List) {
            deliveryassgn = json["deliveryassgn"] ?? [];
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
        if(json["lastModifieddate"] is String) {
            lastModifieddate = json["lastModifieddate"];
        }
        if(json["lastModifiedTime"] is String) {
            lastModifiedTime = json["lastModifiedTime"];
        }
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
        if(json["bill"] is String) {
            bill = json["bill"];
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
        if(json["tenderCurrency"] is num) {
            tenderCurrency = (json["tenderCurrency"] as num).toInt();
        }
        if(json["commission"] is num) {
            commission = (json["commission"] as num).toInt();
        }
        if(json["tenderDate"] is String) {
            tenderDate = json["tenderDate"];
        }
        if(json["tenderTime"] is String) {
            tenderTime = json["tenderTime"];
        }
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
        if(json["paymentremarks"] is String) {
            paymentremarks = json["paymentremarks"];
        }
        if(json["vatsubTotal"] is String) {
            vatsubTotal = json["vatsubTotal"];
        }
        if(json["trash"] is bool) {
            trash = json["trash"];
        }
        if(json["paymentMode"] is String) {
            paymentMode = json["paymentMode"];
        }
        if(json["ClothWiseStatus"] is List) {
            clothWiseStatus = json["ClothWiseStatus"] == null ? null : (json["ClothWiseStatus"] as List).map((e) => ClothWiseStatus.fromJson(e)).toList();
        }
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
        if(json["employeeId"] is String) {
            employeeId = json["employeeId"];
        }
        if(json["employeeName"] is String) {
            employeeName = json["employeeName"];
        }
        if(json["rackName"] is String) {
            rackName = json["rackName"];
        }
        if(json["rackFloor"] is String) {
            rackFloor = json["rackFloor"];
        }
        if(json["deliveredDateTime"] is String) {
            deliveredDateTime = json["deliveredDateTime"];
        }
    }

    static List<OrderReport> fromList(List<Map<String, dynamic>> list) {
        return list.map(OrderReport.fromJson).toList();
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
            _data["edit_history"] = editHistory?.map((e) => e.toJson()).toList();
        }
        if(deliveryassgn != null) {
            _data["deliveryassgn"] = deliveryassgn;
        }
        _data["due_date"] = dueDate;
        _data["previousPaidAmount"] = previousPaidAmount;
        _data["orderDate"] = orderDate;
        _data["orderTime"] = orderTime;
        _data["deliveryDate"] = deliveryDate;
        _data["deliveryTime"] = deliveryTime;
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
        _data["quantity"] = quantity;
        _data["subTotal"] = subTotal;
        _data["discount"] = discount;
        _data["totalAmount"] = totalAmount;
        _data["paidAmount"] = paidAmount;
        _data["balance"] = balance;
        _data["bill"] = bill;
        _data["deliveryType"] = deliveryType;
        _data["accountType"] = accountType;
        if(clothData != null) {
            _data["clothData"] = clothData?.map((e) => e.toJson()).toList();
        }
        _data["folded"] = folded;
        _data["hanger"] = hanger;
        _data["packing"] = packing;
        _data["status"] = status;
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
        _data["vatsubTotal"] = vatsubTotal;
        _data["trash"] = trash;
        _data["paymentMode"] = paymentMode;
        if(clothWiseStatus != null) {
            _data["ClothWiseStatus"] = clothWiseStatus?.map((e) => e.toJson()).toList();
        }
        _data["driverId"] = driverId;
        _data["driverName"] = driverName;
        _data["pickupDriverId"] = pickupDriverId;
        _data["pickupDriverName"] = pickupDriverName;
        _data["employeeId"] = employeeId;
        _data["employeeName"] = employeeName;
        _data["rackName"] = rackName;
        _data["rackFloor"] = rackFloor;
        _data["deliveredDateTime"] = deliveredDateTime;
        return _data;
    }

    OrderReport copyWith({
        int? orderId,
        String? refNo,
        String? remarks,
        List<dynamic>? payment,
        List<EditHistory>? editHistory,
        List<dynamic>? deliveryassgn,
        int? dueDate,
        int? previousPaidAmount,
        String? orderDate,
        String? orderTime,
        String? deliveryDate,
        String? deliveryTime,
        String? lastModifieddate,
        String? lastModifiedTime,
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
        int? quantity,
        String? subTotal,
        String? discount,
        String? totalAmount,
        String? paidAmount,
        String? balance,
        String? bill,
        String? deliveryType,
        String? accountType,
        List<ClothData>? clothData,
        bool? folded,
        bool? hanger,
        bool? packing,
        String? status,
        int? tenderCurrency,
        int? commission,
        String? tenderDate,
        String? tenderTime,
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
        String? paymentremarks,
        String? vatsubTotal,
        bool? trash,
        String? paymentMode,
        List<ClothWiseStatus>? clothWiseStatus,
        int? driverId,
        String? driverName,
        int? pickupDriverId,
        String? pickupDriverName,
        String? employeeId,
        String? employeeName,
        String? rackName,
        String? rackFloor,
        String? deliveredDateTime,
    }) => OrderReport(
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
        quantity: quantity ?? this.quantity,
        subTotal: subTotal ?? this.subTotal,
        discount: discount ?? this.discount,
        totalAmount: totalAmount ?? this.totalAmount,
        paidAmount: paidAmount ?? this.paidAmount,
        balance: balance ?? this.balance,
        bill: bill ?? this.bill,
        deliveryType: deliveryType ?? this.deliveryType,
        accountType: accountType ?? this.accountType,
        clothData: clothData ?? this.clothData,
        folded: folded ?? this.folded,
        hanger: hanger ?? this.hanger,
        packing: packing ?? this.packing,
        status: status ?? this.status,
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
        vatsubTotal: vatsubTotal ?? this.vatsubTotal,
        trash: trash ?? this.trash,
        paymentMode: paymentMode ?? this.paymentMode,
        clothWiseStatus: clothWiseStatus ?? this.clothWiseStatus,
        driverId: driverId ?? this.driverId,
        driverName: driverName ?? this.driverName,
        pickupDriverId: pickupDriverId ?? this.pickupDriverId,
        pickupDriverName: pickupDriverName ?? this.pickupDriverName,
        employeeId: employeeId ?? this.employeeId,
        employeeName: employeeName ?? this.employeeName,
        rackName: rackName ?? this.rackName,
        rackFloor: rackFloor ?? this.rackFloor,
        deliveredDateTime: deliveredDateTime ?? this.deliveredDateTime,
    );
}

class ClothWiseStatus {
    int? id;
    String? bill;
    String? date;
    String? cloth;
    int? deliveryQty;

    ClothWiseStatus({this.id, this.bill, this.date, this.cloth, this.deliveryQty});

    ClothWiseStatus.fromJson(Map<String, dynamic> json) {
        if(json["id"] is num) {
            id = (json["id"] as num).toInt();
        }
        if(json["bill"] is String) {
            bill = json["bill"];
        }
        if(json["date"] is String) {
            date = json["date"];
        }
        if(json["cloth"] is String) {
            cloth = json["cloth"];
        }
        if(json["deliveryQty"] is num) {
            deliveryQty = (json["deliveryQty"] as num).toInt();
        }
    }

    static List<ClothWiseStatus> fromList(List<Map<String, dynamic>> list) {
        return list.map(ClothWiseStatus.fromJson).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["bill"] = bill;
        _data["date"] = date;
        _data["cloth"] = cloth;
        _data["deliveryQty"] = deliveryQty;
        return _data;
    }

    ClothWiseStatus copyWith({
        int? id,
        String? bill,
        String? date,
        String? cloth,
        int? deliveryQty,
    }) => ClothWiseStatus(
        id: id ?? this.id,
        bill: bill ?? this.bill,
        date: date ?? this.date,
        cloth: cloth ?? this.cloth,
        deliveryQty: deliveryQty ?? this.deliveryQty,
    );
}

class ClothData {
    int? qnty;
    String? billing;
    int? priceId;
    String? service;
    String? clothImg;
    String? clothName;
    String? arabicName;
    int? clothPrice;

    ClothData({this.qnty, this.billing, this.priceId, this.service, this.clothImg, this.clothName, this.arabicName, this.clothPrice});

    ClothData.fromJson(Map<String, dynamic> json) {
        if(json["qnty"] is num) {
            qnty = (json["qnty"] as num).toInt();
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
        if(json["clothPrice"] is num) {
            clothPrice = (json["clothPrice"] as num).toInt();
        }
    }

    static List<ClothData> fromList(List<Map<String, dynamic>> list) {
        return list.map(ClothData.fromJson).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["qnty"] = qnty;
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
        String? billing,
        int? priceId,
        String? service,
        String? clothImg,
        String? clothName,
        String? arabicName,
        int? clothPrice,
    }) => ClothData(
        qnty: qnty ?? this.qnty,
        billing: billing ?? this.billing,
        priceId: priceId ?? this.priceId,
        service: service ?? this.service,
        clothImg: clothImg ?? this.clothImg,
        clothName: clothName ?? this.clothName,
        arabicName: arabicName ?? this.arabicName,
        clothPrice: clothPrice ?? this.clothPrice,
    );
}

class EditHistory {
    int? id;
    String? editedBy;
    String? editedDate;
    bool? trash;
    int? order;

    EditHistory({this.id, this.editedBy, this.editedDate, this.trash, this.order});

    EditHistory.fromJson(Map<String, dynamic> json) {
        if(json["id"] is num) {
            id = (json["id"] as num).toInt();
        }
        if(json["edited_by"] is String) {
            editedBy = json["edited_by"];
        }
        if(json["edited_date"] is String) {
            editedDate = json["edited_date"];
        }
        if(json["trash"] is bool) {
            trash = json["trash"];
        }
        if(json["order"] is num) {
            order = (json["order"] as num).toInt();
        }
    }

    static List<EditHistory> fromList(List<Map<String, dynamic>> list) {
        return list.map(EditHistory.fromJson).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["edited_by"] = editedBy;
        _data["edited_date"] = editedDate;
        _data["trash"] = trash;
        _data["order"] = order;
        return _data;
    }

    EditHistory copyWith({
        int? id,
        String? editedBy,
        String? editedDate,
        bool? trash,
        int? order,
    }) => EditHistory(
        id: id ?? this.id,
        editedBy: editedBy ?? this.editedBy,
        editedDate: editedDate ?? this.editedDate,
        trash: trash ?? this.trash,
        order: order ?? this.order,
    );
}