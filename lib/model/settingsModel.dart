
class SettingsModel {
    int? settingsId;
    String? labelType;
    bool? logoInvoice;
    bool? accountType;
    bool? deliveryType;
    bool? outletCopy;
    bool? deliveryCopy;
    String? editingEmail;
    String? autoStatus;
    String? orderType;
    bool? deliveryDate;
    bool? orderDate;
    bool? customerAddress;
    int? deliverySet;
    bool? billDueCustomer;
    bool? billDueOutlet;
    bool? billDueDelivery;
    bool? tendReceipt;
    bool? tendCustomer;
    bool? tendOutlet;
    bool? tendDelivery;
    bool? biginOutlet;
    bool? biginDelivery;
    int? fontSizeOutlet;
    String? cusCodeEntry;
    bool? qrcode;
    bool? barcode;
    bool? outletprice;
    bool? outletContctNo;
    bool? starchCustomer;
    bool? starchOutlet;
    bool? starchDelivery;
    bool? nashaCustomer;
    bool? nashaOutlet;
    bool? nashaDelivery;
    bool? foldCustomer;
    bool? foldOutlet;
    bool? foldDelivery;
    bool? processing;
    bool? orderReady;
    bool? delivered;
    bool? pressing;
    bool? washing;
    bool? customerOldBill;
    String? vat;
    int? vatAmount;
    bool? voidMode;
    bool? oldBalance;
    bool? totalAmountPay;
    bool? itemWisedReport;
    bool? serviceWisedReport;
    String? orderWisePrinting;
    bool? customerEdit;
    bool? customerDelete;
    bool? dailyClosingreport;
    bool? customerTotalduemail;
    bool? orderEdit;
    bool? orderDelete;
    bool? billNoteCustomer;
    bool? billNoteOutlet;
    bool? billNoteDelivery;
    bool? smsnotify;
    bool? cusfragrance;
    bool? whatsappshare;
    bool? outstandingAmount;
    bool? readyfordeliveryPrint;
    bool? pendingAmount;
    bool? customerCopy;
    bool? referenceNo;
    bool? confirmPasswordpopup;
    int? userLimit;
    int? employeLimit;
    int? driverLimit;
    int? serviceLimit;
    int? acTypeLimit;
    int? clothLimit;
    bool? custombillDeclaration;
    bool? cuscodeSearch;
    String? accessToken;
    String? instanceId;
    String? messagetype;
    String? message;
    bool? messageOnpayment;
    bool? messageOndelivery;
    bool? messageOnorder;
    bool? paymodeCash;
    bool? paymodeBank;
    bool? paymodeCard;
    bool? paymodeWallet;
    bool? paymodeVoid;
    bool? addopeningbalance;
    bool? commission;
    bool? paymentDelete;
    bool? companyName;
    bool? outFordelivery;
    bool? customerCode;
    bool? trash;

    SettingsModel({this.settingsId, this.labelType, this.logoInvoice, this.accountType, this.deliveryType, this.outletCopy, this.deliveryCopy, this.editingEmail, this.autoStatus, this.orderType, this.deliveryDate, this.orderDate, this.customerAddress, this.deliverySet, this.billDueCustomer, this.billDueOutlet, this.billDueDelivery, this.tendReceipt, this.tendCustomer, this.tendOutlet, this.tendDelivery, this.biginOutlet, this.biginDelivery, this.fontSizeOutlet, this.cusCodeEntry, this.qrcode, this.barcode, this.outletprice, this.outletContctNo, this.starchCustomer, this.starchOutlet, this.starchDelivery, this.nashaCustomer, this.nashaOutlet, this.nashaDelivery, this.foldCustomer, this.foldOutlet, this.foldDelivery, this.processing, this.orderReady, this.delivered, this.pressing, this.washing, this.customerOldBill, this.vat, this.vatAmount, this.voidMode, this.oldBalance, this.totalAmountPay, this.itemWisedReport, this.serviceWisedReport, this.orderWisePrinting, this.customerEdit, this.customerDelete, this.dailyClosingreport, this.customerTotalduemail, this.orderEdit, this.orderDelete, this.billNoteCustomer, this.billNoteOutlet, this.billNoteDelivery, this.smsnotify, this.cusfragrance, this.whatsappshare, this.outstandingAmount, this.readyfordeliveryPrint, this.pendingAmount, this.customerCopy, this.referenceNo, this.confirmPasswordpopup, this.userLimit, this.employeLimit, this.driverLimit, this.serviceLimit, this.acTypeLimit, this.clothLimit, this.custombillDeclaration, this.cuscodeSearch, this.accessToken, this.instanceId, this.messagetype, this.message, this.messageOnpayment, this.messageOndelivery, this.messageOnorder, this.paymodeCash, this.paymodeBank, this.paymodeCard, this.paymodeWallet, this.paymodeVoid, this.addopeningbalance, this.commission, this.paymentDelete, this.companyName, this.outFordelivery, this.customerCode, this.trash});

    SettingsModel.fromJson(Map<String, dynamic> json) {
        if(json["settingsId"] is num) {
            settingsId = (json["settingsId"] as num).toInt();
        }
        if(json["labelType"] is String) {
            labelType = json["labelType"];
        }
        if(json["logoInvoice"] is bool) {
            logoInvoice = json["logoInvoice"];
        }
        if(json["accountType"] is bool) {
            accountType = json["accountType"];
        }
        if(json["deliveryType"] is bool) {
            deliveryType = json["deliveryType"];
        }
        if(json["outletCopy"] is bool) {
            outletCopy = json["outletCopy"];
        }
        if(json["deliveryCopy"] is bool) {
            deliveryCopy = json["deliveryCopy"];
        }
        if(json["editingEmail"] is String) {
            editingEmail = json["editingEmail"];
        }
        if(json["autoStatus"] is String) {
            autoStatus = json["autoStatus"];
        }
        if(json["orderType"] is String) {
            orderType = json["orderType"];
        }
        if(json["deliveryDate"] is bool) {
            deliveryDate = json["deliveryDate"];
        }
        if(json["orderDate"] is bool) {
            orderDate = json["orderDate"];
        }
        if(json["customerAddress"] is bool) {
            customerAddress = json["customerAddress"];
        }
        if(json["deliverySet"] is num) {
            deliverySet = (json["deliverySet"] as num).toInt();
        }
        if(json["billDueCustomer"] is bool) {
            billDueCustomer = json["billDueCustomer"];
        }
        if(json["billDueOutlet"] is bool) {
            billDueOutlet = json["billDueOutlet"];
        }
        if(json["billDueDelivery"] is bool) {
            billDueDelivery = json["billDueDelivery"];
        }
        if(json["tendReceipt"] is bool) {
            tendReceipt = json["tendReceipt"];
        }
        if(json["tendCustomer"] is bool) {
            tendCustomer = json["tendCustomer"];
        }
        if(json["tendOutlet"] is bool) {
            tendOutlet = json["tendOutlet"];
        }
        if(json["tendDelivery"] is bool) {
            tendDelivery = json["tendDelivery"];
        }
        if(json["biginOutlet"] is bool) {
            biginOutlet = json["biginOutlet"];
        }
        if(json["biginDelivery"] is bool) {
            biginDelivery = json["biginDelivery"];
        }
        if(json["fontSizeOutlet"] is num) {
            fontSizeOutlet = (json["fontSizeOutlet"] as num).toInt();
        }
        if(json["cusCodeEntry"] is String) {
            cusCodeEntry = json["cusCodeEntry"];
        }
        if(json["qrcode"] is bool) {
            qrcode = json["qrcode"];
        }
        if(json["barcode"] is bool) {
            barcode = json["barcode"];
        }
        if(json["outletprice"] is bool) {
            outletprice = json["outletprice"];
        }
        if(json["outletContctNo"] is bool) {
            outletContctNo = json["outletContctNo"];
        }
        if(json["starchCustomer"] is bool) {
            starchCustomer = json["starchCustomer"];
        }
        if(json["starchOutlet"] is bool) {
            starchOutlet = json["starchOutlet"];
        }
        if(json["starchDelivery"] is bool) {
            starchDelivery = json["starchDelivery"];
        }
        if(json["nashaCustomer"] is bool) {
            nashaCustomer = json["nashaCustomer"];
        }
        if(json["nashaOutlet"] is bool) {
            nashaOutlet = json["nashaOutlet"];
        }
        if(json["nashaDelivery"] is bool) {
            nashaDelivery = json["nashaDelivery"];
        }
        if(json["foldCustomer"] is bool) {
            foldCustomer = json["foldCustomer"];
        }
        if(json["foldOutlet"] is bool) {
            foldOutlet = json["foldOutlet"];
        }
        if(json["foldDelivery"] is bool) {
            foldDelivery = json["foldDelivery"];
        }
        if(json["processing"] is bool) {
            processing = json["processing"];
        }
        if(json["orderReady"] is bool) {
            orderReady = json["orderReady"];
        }
        if(json["delivered"] is bool) {
            delivered = json["delivered"];
        }
        if(json["pressing"] is bool) {
            pressing = json["pressing"];
        }
        if(json["washing"] is bool) {
            washing = json["washing"];
        }
        if(json["customerOldBill"] is bool) {
            customerOldBill = json["customerOldBill"];
        }
        if(json["vat"] is String) {
            vat = json["vat"];
        }
        if(json["vatAmount"] is num) {
            vatAmount = (json["vatAmount"] as num).toInt();
        }
        if(json["voidMode"] is bool) {
            voidMode = json["voidMode"];
        }
        if(json["oldBalance"] is bool) {
            oldBalance = json["oldBalance"];
        }
        if(json["totalAmountPay"] is bool) {
            totalAmountPay = json["totalAmountPay"];
        }
        if(json["itemWisedReport"] is bool) {
            itemWisedReport = json["itemWisedReport"];
        }
        if(json["serviceWisedReport"] is bool) {
            serviceWisedReport = json["serviceWisedReport"];
        }
        if(json["orderWisePrinting"] is String) {
            orderWisePrinting = json["orderWisePrinting"];
        }
        if(json["customerEdit"] is bool) {
            customerEdit = json["customerEdit"];
        }
        if(json["customerDelete"] is bool) {
            customerDelete = json["customerDelete"];
        }
        if(json["dailyClosingreport"] is bool) {
            dailyClosingreport = json["dailyClosingreport"];
        }
        if(json["customerTotalduemail"] is bool) {
            customerTotalduemail = json["customerTotalduemail"];
        }
        if(json["orderEdit"] is bool) {
            orderEdit = json["orderEdit"];
        }
        if(json["orderDelete"] is bool) {
            orderDelete = json["orderDelete"];
        }
        if(json["billNoteCustomer"] is bool) {
            billNoteCustomer = json["billNoteCustomer"];
        }
        if(json["billNoteOutlet"] is bool) {
            billNoteOutlet = json["billNoteOutlet"];
        }
        if(json["billNoteDelivery"] is bool) {
            billNoteDelivery = json["billNoteDelivery"];
        }
        if(json["smsnotify"] is bool) {
            smsnotify = json["smsnotify"];
        }
        if(json["cusfragrance"] is bool) {
            cusfragrance = json["cusfragrance"];
        }
        if(json["whatsappshare"] is bool) {
            whatsappshare = json["whatsappshare"];
        }
        if(json["outstandingAmount"] is bool) {
            outstandingAmount = json["outstandingAmount"];
        }
        if(json["readyfordeliveryPrint"] is bool) {
            readyfordeliveryPrint = json["readyfordeliveryPrint"];
        }
        if(json["pendingAmount"] is bool) {
            pendingAmount = json["pendingAmount"];
        }
        if(json["customerCopy"] is bool) {
            customerCopy = json["customerCopy"];
        }
        if(json["ReferenceNo"] is bool) {
            referenceNo = json["ReferenceNo"];
        }
        if(json["confirmPasswordpopup"] is bool) {
            confirmPasswordpopup = json["confirmPasswordpopup"];
        }
        if(json["userLimit"] is num) {
            userLimit = (json["userLimit"] as num).toInt();
        }
        if(json["employeLimit"] is num) {
            employeLimit = (json["employeLimit"] as num).toInt();
        }
        if(json["driverLimit"] is num) {
            driverLimit = (json["driverLimit"] as num).toInt();
        }
        if(json["serviceLimit"] is num) {
            serviceLimit = (json["serviceLimit"] as num).toInt();
        }
        if(json["acTypeLimit"] is num) {
            acTypeLimit = (json["acTypeLimit"] as num).toInt();
        }
        if(json["clothLimit"] is num) {
            clothLimit = (json["clothLimit"] as num).toInt();
        }
        if(json["custombillDeclaration"] is bool) {
            custombillDeclaration = json["custombillDeclaration"];
        }
        if(json["CuscodeSearch"] is bool) {
            cuscodeSearch = json["CuscodeSearch"];
        }
        if(json["ACCESS_TOKEN"] is String) {
            accessToken = json["ACCESS_TOKEN"];
        }
        if(json["INSTANCE_ID"] is String) {
            instanceId = json["INSTANCE_ID"];
        }
        if(json["messagetype"] is String) {
            messagetype = json["messagetype"];
        }
        if(json["message"] is String) {
            message = json["message"];
        }
        if(json["messageOnpayment"] is bool) {
            messageOnpayment = json["messageOnpayment"];
        }
        if(json["messageOndelivery"] is bool) {
            messageOndelivery = json["messageOndelivery"];
        }
        if(json["messageOnorder"] is bool) {
            messageOnorder = json["messageOnorder"];
        }
        if(json["PaymodeCash"] is bool) {
            paymodeCash = json["PaymodeCash"];
        }
        if(json["PaymodeBank"] is bool) {
            paymodeBank = json["PaymodeBank"];
        }
        if(json["PaymodeCard"] is bool) {
            paymodeCard = json["PaymodeCard"];
        }
        if(json["PaymodeWallet"] is bool) {
            paymodeWallet = json["PaymodeWallet"];
        }
        if(json["PaymodeVoid"] is bool) {
            paymodeVoid = json["PaymodeVoid"];
        }
        if(json["Addopeningbalance"] is bool) {
            addopeningbalance = json["Addopeningbalance"];
        }
        if(json["Commission"] is bool) {
            commission = json["Commission"];
        }
        if(json["paymentDelete"] is bool) {
            paymentDelete = json["paymentDelete"];
        }
        if(json["companyName"] is bool) {
            companyName = json["companyName"];
        }
        if(json["outFordelivery"] is bool) {
            outFordelivery = json["outFordelivery"];
        }
        if(json["customerCode"] is bool) {
            customerCode = json["customerCode"];
        }
        if(json["trash"] is bool) {
            trash = json["trash"];
        }
    }

    static List<SettingsModel> fromList(List<Map<String, dynamic>> list) {
        return list.map(SettingsModel.fromJson).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["settingsId"] = settingsId;
        _data["labelType"] = labelType;
        _data["logoInvoice"] = logoInvoice;
        _data["accountType"] = accountType;
        _data["deliveryType"] = deliveryType;
        _data["outletCopy"] = outletCopy;
        _data["deliveryCopy"] = deliveryCopy;
        _data["editingEmail"] = editingEmail;
        _data["autoStatus"] = autoStatus;
        _data["orderType"] = orderType;
        _data["deliveryDate"] = deliveryDate;
        _data["orderDate"] = orderDate;
        _data["customerAddress"] = customerAddress;
        _data["deliverySet"] = deliverySet;
        _data["billDueCustomer"] = billDueCustomer;
        _data["billDueOutlet"] = billDueOutlet;
        _data["billDueDelivery"] = billDueDelivery;
        _data["tendReceipt"] = tendReceipt;
        _data["tendCustomer"] = tendCustomer;
        _data["tendOutlet"] = tendOutlet;
        _data["tendDelivery"] = tendDelivery;
        _data["biginOutlet"] = biginOutlet;
        _data["biginDelivery"] = biginDelivery;
        _data["fontSizeOutlet"] = fontSizeOutlet;
        _data["cusCodeEntry"] = cusCodeEntry;
        _data["qrcode"] = qrcode;
        _data["barcode"] = barcode;
        _data["outletprice"] = outletprice;
        _data["outletContctNo"] = outletContctNo;
        _data["starchCustomer"] = starchCustomer;
        _data["starchOutlet"] = starchOutlet;
        _data["starchDelivery"] = starchDelivery;
        _data["nashaCustomer"] = nashaCustomer;
        _data["nashaOutlet"] = nashaOutlet;
        _data["nashaDelivery"] = nashaDelivery;
        _data["foldCustomer"] = foldCustomer;
        _data["foldOutlet"] = foldOutlet;
        _data["foldDelivery"] = foldDelivery;
        _data["processing"] = processing;
        _data["orderReady"] = orderReady;
        _data["delivered"] = delivered;
        _data["pressing"] = pressing;
        _data["washing"] = washing;
        _data["customerOldBill"] = customerOldBill;
        _data["vat"] = vat;
        _data["vatAmount"] = vatAmount;
        _data["voidMode"] = voidMode;
        _data["oldBalance"] = oldBalance;
        _data["totalAmountPay"] = totalAmountPay;
        _data["itemWisedReport"] = itemWisedReport;
        _data["serviceWisedReport"] = serviceWisedReport;
        _data["orderWisePrinting"] = orderWisePrinting;
        _data["customerEdit"] = customerEdit;
        _data["customerDelete"] = customerDelete;
        _data["dailyClosingreport"] = dailyClosingreport;
        _data["customerTotalduemail"] = customerTotalduemail;
        _data["orderEdit"] = orderEdit;
        _data["orderDelete"] = orderDelete;
        _data["billNoteCustomer"] = billNoteCustomer;
        _data["billNoteOutlet"] = billNoteOutlet;
        _data["billNoteDelivery"] = billNoteDelivery;
        _data["smsnotify"] = smsnotify;
        _data["cusfragrance"] = cusfragrance;
        _data["whatsappshare"] = whatsappshare;
        _data["outstandingAmount"] = outstandingAmount;
        _data["readyfordeliveryPrint"] = readyfordeliveryPrint;
        _data["pendingAmount"] = pendingAmount;
        _data["customerCopy"] = customerCopy;
        _data["ReferenceNo"] = referenceNo;
        _data["confirmPasswordpopup"] = confirmPasswordpopup;
        _data["userLimit"] = userLimit;
        _data["employeLimit"] = employeLimit;
        _data["driverLimit"] = driverLimit;
        _data["serviceLimit"] = serviceLimit;
        _data["acTypeLimit"] = acTypeLimit;
        _data["clothLimit"] = clothLimit;
        _data["custombillDeclaration"] = custombillDeclaration;
        _data["CuscodeSearch"] = cuscodeSearch;
        _data["ACCESS_TOKEN"] = accessToken;
        _data["INSTANCE_ID"] = instanceId;
        _data["messagetype"] = messagetype;
        _data["message"] = message;
        _data["messageOnpayment"] = messageOnpayment;
        _data["messageOndelivery"] = messageOndelivery;
        _data["messageOnorder"] = messageOnorder;
        _data["PaymodeCash"] = paymodeCash;
        _data["PaymodeBank"] = paymodeBank;
        _data["PaymodeCard"] = paymodeCard;
        _data["PaymodeWallet"] = paymodeWallet;
        _data["PaymodeVoid"] = paymodeVoid;
        _data["Addopeningbalance"] = addopeningbalance;
        _data["Commission"] = commission;
        _data["paymentDelete"] = paymentDelete;
        _data["companyName"] = companyName;
        _data["outFordelivery"] = outFordelivery;
        _data["customerCode"] = customerCode;
        _data["trash"] = trash;
        return _data;
    }

    SettingsModel copyWith({
        int? settingsId,
        String? labelType,
        bool? logoInvoice,
        bool? accountType,
        bool? deliveryType,
        bool? outletCopy,
        bool? deliveryCopy,
        String? editingEmail,
        String? autoStatus,
        String? orderType,
        bool? deliveryDate,
        bool? orderDate,
        bool? customerAddress,
        int? deliverySet,
        bool? billDueCustomer,
        bool? billDueOutlet,
        bool? billDueDelivery,
        bool? tendReceipt,
        bool? tendCustomer,
        bool? tendOutlet,
        bool? tendDelivery,
        bool? biginOutlet,
        bool? biginDelivery,
        int? fontSizeOutlet,
        String? cusCodeEntry,
        bool? qrcode,
        bool? barcode,
        bool? outletprice,
        bool? outletContctNo,
        bool? starchCustomer,
        bool? starchOutlet,
        bool? starchDelivery,
        bool? nashaCustomer,
        bool? nashaOutlet,
        bool? nashaDelivery,
        bool? foldCustomer,
        bool? foldOutlet,
        bool? foldDelivery,
        bool? processing,
        bool? orderReady,
        bool? delivered,
        bool? pressing,
        bool? washing,
        bool? customerOldBill,
        String? vat,
        int? vatAmount,
        bool? voidMode,
        bool? oldBalance,
        bool? totalAmountPay,
        bool? itemWisedReport,
        bool? serviceWisedReport,
        String? orderWisePrinting,
        bool? customerEdit,
        bool? customerDelete,
        bool? dailyClosingreport,
        bool? customerTotalduemail,
        bool? orderEdit,
        bool? orderDelete,
        bool? billNoteCustomer,
        bool? billNoteOutlet,
        bool? billNoteDelivery,
        bool? smsnotify,
        bool? cusfragrance,
        bool? whatsappshare,
        bool? outstandingAmount,
        bool? readyfordeliveryPrint,
        bool? pendingAmount,
        bool? customerCopy,
        bool? referenceNo,
        bool? confirmPasswordpopup,
        int? userLimit,
        int? employeLimit,
        int? driverLimit,
        int? serviceLimit,
        int? acTypeLimit,
        int? clothLimit,
        bool? custombillDeclaration,
        bool? cuscodeSearch,
        String? accessToken,
        String? instanceId,
        String? messagetype,
        String? message,
        bool? messageOnpayment,
        bool? messageOndelivery,
        bool? messageOnorder,
        bool? paymodeCash,
        bool? paymodeBank,
        bool? paymodeCard,
        bool? paymodeWallet,
        bool? paymodeVoid,
        bool? addopeningbalance,
        bool? commission,
        bool? paymentDelete,
        bool? companyName,
        bool? outFordelivery,
        bool? customerCode,
        bool? trash,
    }) => SettingsModel(
        settingsId: settingsId ?? this.settingsId,
        labelType: labelType ?? this.labelType,
        logoInvoice: logoInvoice ?? this.logoInvoice,
        accountType: accountType ?? this.accountType,
        deliveryType: deliveryType ?? this.deliveryType,
        outletCopy: outletCopy ?? this.outletCopy,
        deliveryCopy: deliveryCopy ?? this.deliveryCopy,
        editingEmail: editingEmail ?? this.editingEmail,
        autoStatus: autoStatus ?? this.autoStatus,
        orderType: orderType ?? this.orderType,
        deliveryDate: deliveryDate ?? this.deliveryDate,
        orderDate: orderDate ?? this.orderDate,
        customerAddress: customerAddress ?? this.customerAddress,
        deliverySet: deliverySet ?? this.deliverySet,
        billDueCustomer: billDueCustomer ?? this.billDueCustomer,
        billDueOutlet: billDueOutlet ?? this.billDueOutlet,
        billDueDelivery: billDueDelivery ?? this.billDueDelivery,
        tendReceipt: tendReceipt ?? this.tendReceipt,
        tendCustomer: tendCustomer ?? this.tendCustomer,
        tendOutlet: tendOutlet ?? this.tendOutlet,
        tendDelivery: tendDelivery ?? this.tendDelivery,
        biginOutlet: biginOutlet ?? this.biginOutlet,
        biginDelivery: biginDelivery ?? this.biginDelivery,
        fontSizeOutlet: fontSizeOutlet ?? this.fontSizeOutlet,
        cusCodeEntry: cusCodeEntry ?? this.cusCodeEntry,
        qrcode: qrcode ?? this.qrcode,
        barcode: barcode ?? this.barcode,
        outletprice: outletprice ?? this.outletprice,
        outletContctNo: outletContctNo ?? this.outletContctNo,
        starchCustomer: starchCustomer ?? this.starchCustomer,
        starchOutlet: starchOutlet ?? this.starchOutlet,
        starchDelivery: starchDelivery ?? this.starchDelivery,
        nashaCustomer: nashaCustomer ?? this.nashaCustomer,
        nashaOutlet: nashaOutlet ?? this.nashaOutlet,
        nashaDelivery: nashaDelivery ?? this.nashaDelivery,
        foldCustomer: foldCustomer ?? this.foldCustomer,
        foldOutlet: foldOutlet ?? this.foldOutlet,
        foldDelivery: foldDelivery ?? this.foldDelivery,
        processing: processing ?? this.processing,
        orderReady: orderReady ?? this.orderReady,
        delivered: delivered ?? this.delivered,
        pressing: pressing ?? this.pressing,
        washing: washing ?? this.washing,
        customerOldBill: customerOldBill ?? this.customerOldBill,
        vat: vat ?? this.vat,
        vatAmount: vatAmount ?? this.vatAmount,
        voidMode: voidMode ?? this.voidMode,
        oldBalance: oldBalance ?? this.oldBalance,
        totalAmountPay: totalAmountPay ?? this.totalAmountPay,
        itemWisedReport: itemWisedReport ?? this.itemWisedReport,
        serviceWisedReport: serviceWisedReport ?? this.serviceWisedReport,
        orderWisePrinting: orderWisePrinting ?? this.orderWisePrinting,
        customerEdit: customerEdit ?? this.customerEdit,
        customerDelete: customerDelete ?? this.customerDelete,
        dailyClosingreport: dailyClosingreport ?? this.dailyClosingreport,
        customerTotalduemail: customerTotalduemail ?? this.customerTotalduemail,
        orderEdit: orderEdit ?? this.orderEdit,
        orderDelete: orderDelete ?? this.orderDelete,
        billNoteCustomer: billNoteCustomer ?? this.billNoteCustomer,
        billNoteOutlet: billNoteOutlet ?? this.billNoteOutlet,
        billNoteDelivery: billNoteDelivery ?? this.billNoteDelivery,
        smsnotify: smsnotify ?? this.smsnotify,
        cusfragrance: cusfragrance ?? this.cusfragrance,
        whatsappshare: whatsappshare ?? this.whatsappshare,
        outstandingAmount: outstandingAmount ?? this.outstandingAmount,
        readyfordeliveryPrint: readyfordeliveryPrint ?? this.readyfordeliveryPrint,
        pendingAmount: pendingAmount ?? this.pendingAmount,
        customerCopy: customerCopy ?? this.customerCopy,
        referenceNo: referenceNo ?? this.referenceNo,
        confirmPasswordpopup: confirmPasswordpopup ?? this.confirmPasswordpopup,
        userLimit: userLimit ?? this.userLimit,
        employeLimit: employeLimit ?? this.employeLimit,
        driverLimit: driverLimit ?? this.driverLimit,
        serviceLimit: serviceLimit ?? this.serviceLimit,
        acTypeLimit: acTypeLimit ?? this.acTypeLimit,
        clothLimit: clothLimit ?? this.clothLimit,
        custombillDeclaration: custombillDeclaration ?? this.custombillDeclaration,
        cuscodeSearch: cuscodeSearch ?? this.cuscodeSearch,
        accessToken: accessToken ?? this.accessToken,
        instanceId: instanceId ?? this.instanceId,
        messagetype: messagetype ?? this.messagetype,
        message: message ?? this.message,
        messageOnpayment: messageOnpayment ?? this.messageOnpayment,
        messageOndelivery: messageOndelivery ?? this.messageOndelivery,
        messageOnorder: messageOnorder ?? this.messageOnorder,
        paymodeCash: paymodeCash ?? this.paymodeCash,
        paymodeBank: paymodeBank ?? this.paymodeBank,
        paymodeCard: paymodeCard ?? this.paymodeCard,
        paymodeWallet: paymodeWallet ?? this.paymodeWallet,
        paymodeVoid: paymodeVoid ?? this.paymodeVoid,
        addopeningbalance: addopeningbalance ?? this.addopeningbalance,
        commission: commission ?? this.commission,
        paymentDelete: paymentDelete ?? this.paymentDelete,
        companyName: companyName ?? this.companyName,
        outFordelivery: outFordelivery ?? this.outFordelivery,
        customerCode: customerCode ?? this.customerCode,
        trash: trash ?? this.trash,
    );
}