
class CompanyDetails {
    int? companyId;
    String? companyName;
    String? companyNameArabic;
    String? address;
    String? adminEmail;
    String? street;
    String? streetArabic;
    String? city;
    String? cityArabic;
    String? country;
    String? countryArabic;
    String? companyMobile;
    String? mobileArabic;
    String? companyWhatsapp;
    String? whatsappArabic;
    String? bankName;
    String? bankNameArabic;
    String? bankBranchCode;
    String? bankAccountNumber;
    String? billDeclaration;
    String? billDeclarationArabic;
    String? customerPrefix;
    dynamic version;
    String? currencyCode;
    String? imageLightMode;
    String? printLogo;
    String? joiningDate;
    String? paymentDate;
    String? paymentStatus;
    String? paidDate;
    String? remarks;
    String? additionalNote;
    int? currencyDecimal;
    bool? trash;

    CompanyDetails({this.companyId, this.companyName, this.companyNameArabic, this.address, this.adminEmail, this.street, this.streetArabic, this.city, this.cityArabic, this.country, this.countryArabic, this.companyMobile, this.mobileArabic, this.companyWhatsapp, this.whatsappArabic, this.bankName, this.bankNameArabic, this.bankBranchCode, this.bankAccountNumber, this.billDeclaration, this.billDeclarationArabic, this.customerPrefix, this.version, this.currencyCode, this.imageLightMode, this.printLogo, this.joiningDate, this.paymentDate, this.paymentStatus, this.paidDate, this.remarks, this.additionalNote, this.currencyDecimal, this.trash});

    CompanyDetails.fromJson(Map<String, dynamic> json) {
        if(json["companyId"] is num) {
            companyId = (json["companyId"] as num).toInt();
        }
        if(json["companyName"] is String) {
            companyName = json["companyName"];
        }
        if(json["companyNameArabic"] is String) {
            companyNameArabic = json["companyNameArabic"];
        }
        if(json["address"] is String) {
            address = json["address"];
        }
        if(json["adminEmail"] is String) {
            adminEmail = json["adminEmail"];
        }
        if(json["street"] is String) {
            street = json["street"];
        }
        if(json["streetArabic"] is String) {
            streetArabic = json["streetArabic"];
        }
        if(json["city"] is String) {
            city = json["city"];
        }
        if(json["cityArabic"] is String) {
            cityArabic = json["cityArabic"];
        }
        if(json["country"] is String) {
            country = json["country"];
        }
        if(json["countryArabic"] is String) {
            countryArabic = json["countryArabic"];
        }
        if(json["companyMobile"] is String) {
            companyMobile = json["companyMobile"];
        }
        if(json["mobileArabic"] is String) {
            mobileArabic = json["mobileArabic"];
        }
        if(json["companyWhatsapp"] is String) {
            companyWhatsapp = json["companyWhatsapp"];
        }
        if(json["whatsappArabic"] is String) {
            whatsappArabic = json["whatsappArabic"];
        }
        if(json["bankName"] is String) {
            bankName = json["bankName"];
        }
        if(json["bankNameArabic"] is String) {
            bankNameArabic = json["bankNameArabic"];
        }
        if(json["bankBranchCode"] is String) {
            bankBranchCode = json["bankBranchCode"];
        }
        if(json["bankAccountNumber"] is String) {
            bankAccountNumber = json["bankAccountNumber"];
        }
        if(json["billDeclaration"] is String) {
            billDeclaration = json["billDeclaration"];
        }
        if(json["billDeclarationArabic"] is String) {
            billDeclarationArabic = json["billDeclarationArabic"];
        }
        if(json["customerPrefix"] is String) {
            customerPrefix = json["customerPrefix"];
        }
        version = json["version"];
        if(json["currencyCode"] is String) {
            currencyCode = json["currencyCode"];
        }
        if(json["imageLightMode"] is String) {
            imageLightMode = json["imageLightMode"];
        }
        if(json["printLogo"] is String) {
            printLogo = json["printLogo"];
        }
        if(json["joiningDate"] is String) {
            joiningDate = json["joiningDate"];
        }
        if(json["paymentDate"] is String) {
            paymentDate = json["paymentDate"];
        }
        if(json["payment_status"] is String) {
            paymentStatus = json["payment_status"];
        }
        if(json["paidDate"] is String) {
            paidDate = json["paidDate"];
        }
        if(json["remarks"] is String) {
            remarks = json["remarks"];
        }
        if(json["additionalNote"] is String) {
            additionalNote = json["additionalNote"];
        }
        if(json["currencyDecimal"] is num) {
            currencyDecimal = (json["currencyDecimal"] as num).toInt();
        }
        if(json["trash"] is bool) {
            trash = json["trash"];
        }
    }

    static List<CompanyDetails> fromList(List<Map<String, dynamic>> list) {
        return list.map(CompanyDetails.fromJson).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["companyId"] = companyId;
        _data["companyName"] = companyName;
        _data["companyNameArabic"] = companyNameArabic;
        _data["address"] = address;
        _data["adminEmail"] = adminEmail;
        _data["street"] = street;
        _data["streetArabic"] = streetArabic;
        _data["city"] = city;
        _data["cityArabic"] = cityArabic;
        _data["country"] = country;
        _data["countryArabic"] = countryArabic;
        _data["companyMobile"] = companyMobile;
        _data["mobileArabic"] = mobileArabic;
        _data["companyWhatsapp"] = companyWhatsapp;
        _data["whatsappArabic"] = whatsappArabic;
        _data["bankName"] = bankName;
        _data["bankNameArabic"] = bankNameArabic;
        _data["bankBranchCode"] = bankBranchCode;
        _data["bankAccountNumber"] = bankAccountNumber;
        _data["billDeclaration"] = billDeclaration;
        _data["billDeclarationArabic"] = billDeclarationArabic;
        _data["customerPrefix"] = customerPrefix;
        _data["version"] = version;
        _data["currencyCode"] = currencyCode;
        _data["imageLightMode"] = imageLightMode;
        _data["printLogo"] = printLogo;
        _data["joiningDate"] = joiningDate;
        _data["paymentDate"] = paymentDate;
        _data["payment_status"] = paymentStatus;
        _data["paidDate"] = paidDate;
        _data["remarks"] = remarks;
        _data["additionalNote"] = additionalNote;
        _data["currencyDecimal"] = currencyDecimal;
        _data["trash"] = trash;
        return _data;
    }

    CompanyDetails copyWith({
        int? companyId,
        String? companyName,
        String? companyNameArabic,
        String? address,
        String? adminEmail,
        String? street,
        String? streetArabic,
        String? city,
        String? cityArabic,
        String? country,
        String? countryArabic,
        String? companyMobile,
        String? mobileArabic,
        String? companyWhatsapp,
        String? whatsappArabic,
        String? bankName,
        String? bankNameArabic,
        String? bankBranchCode,
        String? bankAccountNumber,
        String? billDeclaration,
        String? billDeclarationArabic,
        String? customerPrefix,
        dynamic version,
        String? currencyCode,
        String? imageLightMode,
        String? printLogo,
        String? joiningDate,
        String? paymentDate,
        String? paymentStatus,
        String? paidDate,
        String? remarks,
        String? additionalNote,
        int? currencyDecimal,
        bool? trash,
    }) => CompanyDetails(
        companyId: companyId ?? this.companyId,
        companyName: companyName ?? this.companyName,
        companyNameArabic: companyNameArabic ?? this.companyNameArabic,
        address: address ?? this.address,
        adminEmail: adminEmail ?? this.adminEmail,
        street: street ?? this.street,
        streetArabic: streetArabic ?? this.streetArabic,
        city: city ?? this.city,
        cityArabic: cityArabic ?? this.cityArabic,
        country: country ?? this.country,
        countryArabic: countryArabic ?? this.countryArabic,
        companyMobile: companyMobile ?? this.companyMobile,
        mobileArabic: mobileArabic ?? this.mobileArabic,
        companyWhatsapp: companyWhatsapp ?? this.companyWhatsapp,
        whatsappArabic: whatsappArabic ?? this.whatsappArabic,
        bankName: bankName ?? this.bankName,
        bankNameArabic: bankNameArabic ?? this.bankNameArabic,
        bankBranchCode: bankBranchCode ?? this.bankBranchCode,
        bankAccountNumber: bankAccountNumber ?? this.bankAccountNumber,
        billDeclaration: billDeclaration ?? this.billDeclaration,
        billDeclarationArabic: billDeclarationArabic ?? this.billDeclarationArabic,
        customerPrefix: customerPrefix ?? this.customerPrefix,
        version: version ?? this.version,
        currencyCode: currencyCode ?? this.currencyCode,
        imageLightMode: imageLightMode ?? this.imageLightMode,
        printLogo: printLogo ?? this.printLogo,
        joiningDate: joiningDate ?? this.joiningDate,
        paymentDate: paymentDate ?? this.paymentDate,
        paymentStatus: paymentStatus ?? this.paymentStatus,
        paidDate: paidDate ?? this.paidDate,
        remarks: remarks ?? this.remarks,
        additionalNote: additionalNote ?? this.additionalNote,
        currencyDecimal: currencyDecimal ?? this.currencyDecimal,
        trash: trash ?? this.trash,
    );
}