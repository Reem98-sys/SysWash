
class ClosingReport {
    List<dynamic>? clothcount;
    int? totalQnty;
    int? totalGrossSale;
    int? totalCashSale;
    int? totalCardSale;
    int? totalBankSale;
    int? totalWalletSale;
    int? totalDiscount;
    int? totalCommission;
    int? totalPaidAmount;
    int? totalBalance;
    int? totalVatValue;
    int? totalExpense;
    int? walletBalance;
    int? walletaddamount;
    int? cashOut;
    int? cashIn;
    ServiceWiseCounts? serviceWiseCounts;
    int? outstandingamount;
    int? debtamount;
    int? cashexpense;

    ClosingReport({this.clothcount, this.totalQnty, this.totalGrossSale, this.totalCashSale, this.totalCardSale, this.totalBankSale, this.totalWalletSale, this.totalDiscount, this.totalCommission, this.totalPaidAmount, this.totalBalance, this.totalVatValue, this.totalExpense, this.walletBalance, this.walletaddamount, this.cashOut, this.cashIn, this.serviceWiseCounts, this.outstandingamount, this.debtamount, this.cashexpense});

    ClosingReport.fromJson(Map<String, dynamic> json) {
        if(json["Clothcount"] is List) {
            clothcount = json["Clothcount"] ?? [];
        }
        if(json["TotalQnty"] is num) {
            totalQnty = (json["TotalQnty"] as num).toInt();
        }
        if(json["TotalGrossSale"] is num) {
            totalGrossSale = (json["TotalGrossSale"] as num).toInt();
        }
        if(json["TotalCashSale"] is num) {
            totalCashSale = (json["TotalCashSale"] as num).toInt();
        }
        if(json["TotalCardSale"] is num) {
            totalCardSale = (json["TotalCardSale"] as num).toInt();
        }
        if(json["TotalBankSale"] is num) {
            totalBankSale = (json["TotalBankSale"] as num).toInt();
        }
        if(json["TotalWalletSale"] is num) {
            totalWalletSale = (json["TotalWalletSale"] as num).toInt();
        }
        if(json["TotalDiscount"] is num) {
            totalDiscount = (json["TotalDiscount"] as num).toInt();
        }
        if(json["TotalCommission"] is num) {
            totalCommission = (json["TotalCommission"] as num).toInt();
        }
        if(json["TotalPaidAmount"] is num) {
            totalPaidAmount = (json["TotalPaidAmount"] as num).toInt();
        }
        if(json["TotalBalance"] is num) {
            totalBalance = (json["TotalBalance"] as num).toInt();
        }
        if(json["TotalVatValue"] is num) {
            totalVatValue = (json["TotalVatValue"] as num).toInt();
        }
        if(json["TotalExpense"] is num) {
            totalExpense = (json["TotalExpense"] as num).toInt();
        }
        if(json["walletBalance"] is num) {
            walletBalance = (json["walletBalance"] as num).toInt();
        }
        if(json["walletaddamount"] is num) {
            walletaddamount = (json["walletaddamount"] as num).toInt();
        }
        if(json["CashOut"] is num) {
            cashOut = (json["CashOut"] as num).toInt();
        }
        if(json["cashIn"] is num) {
            cashIn = (json["cashIn"] as num).toInt();
        }
        if(json["ServiceWiseCounts"] is Map) {
            serviceWiseCounts = json["ServiceWiseCounts"] == null ? null : ServiceWiseCounts.fromJson(json["ServiceWiseCounts"]);
        }
        if(json["outstandingamount"] is num) {
            outstandingamount = (json["outstandingamount"] as num).toInt();
        }
        if(json["debtamount"] is num) {
            debtamount = (json["debtamount"] as num).toInt();
        }
        if(json["cashexpense"] is num) {
            cashexpense = (json["cashexpense"] as num).toInt();
        }
    }

    static List<ClosingReport> fromList(List<Map<String, dynamic>> list) {
        return list.map(ClosingReport.fromJson).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        if(clothcount != null) {
            _data["Clothcount"] = clothcount;
        }
        _data["TotalQnty"] = totalQnty;
        _data["TotalGrossSale"] = totalGrossSale;
        _data["TotalCashSale"] = totalCashSale;
        _data["TotalCardSale"] = totalCardSale;
        _data["TotalBankSale"] = totalBankSale;
        _data["TotalWalletSale"] = totalWalletSale;
        _data["TotalDiscount"] = totalDiscount;
        _data["TotalCommission"] = totalCommission;
        _data["TotalPaidAmount"] = totalPaidAmount;
        _data["TotalBalance"] = totalBalance;
        _data["TotalVatValue"] = totalVatValue;
        _data["TotalExpense"] = totalExpense;
        _data["walletBalance"] = walletBalance;
        _data["walletaddamount"] = walletaddamount;
        _data["CashOut"] = cashOut;
        _data["cashIn"] = cashIn;
        if(serviceWiseCounts != null) {
            _data["ServiceWiseCounts"] = serviceWiseCounts?.toJson();
        }
        _data["outstandingamount"] = outstandingamount;
        _data["debtamount"] = debtamount;
        _data["cashexpense"] = cashexpense;
        return _data;
    }

    ClosingReport copyWith({
        List<dynamic>? clothcount,
        int? totalQnty,
        int? totalGrossSale,
        int? totalCashSale,
        int? totalCardSale,
        int? totalBankSale,
        int? totalWalletSale,
        int? totalDiscount,
        int? totalCommission,
        int? totalPaidAmount,
        int? totalBalance,
        int? totalVatValue,
        int? totalExpense,
        int? walletBalance,
        int? walletaddamount,
        int? cashOut,
        int? cashIn,
        ServiceWiseCounts? serviceWiseCounts,
        int? outstandingamount,
        int? debtamount,
        int? cashexpense,
    }) => ClosingReport(
        clothcount: clothcount ?? this.clothcount,
        totalQnty: totalQnty ?? this.totalQnty,
        totalGrossSale: totalGrossSale ?? this.totalGrossSale,
        totalCashSale: totalCashSale ?? this.totalCashSale,
        totalCardSale: totalCardSale ?? this.totalCardSale,
        totalBankSale: totalBankSale ?? this.totalBankSale,
        totalWalletSale: totalWalletSale ?? this.totalWalletSale,
        totalDiscount: totalDiscount ?? this.totalDiscount,
        totalCommission: totalCommission ?? this.totalCommission,
        totalPaidAmount: totalPaidAmount ?? this.totalPaidAmount,
        totalBalance: totalBalance ?? this.totalBalance,
        totalVatValue: totalVatValue ?? this.totalVatValue,
        totalExpense: totalExpense ?? this.totalExpense,
        walletBalance: walletBalance ?? this.walletBalance,
        walletaddamount: walletaddamount ?? this.walletaddamount,
        cashOut: cashOut ?? this.cashOut,
        cashIn: cashIn ?? this.cashIn,
        serviceWiseCounts: serviceWiseCounts ?? this.serviceWiseCounts,
        outstandingamount: outstandingamount ?? this.outstandingamount,
        debtamount: debtamount ?? this.debtamount,
        cashexpense: cashexpense ?? this.cashexpense,
    );
}

class ServiceWiseCounts {
    ServiceWiseCounts();

    ServiceWiseCounts.fromJson(Map<String, dynamic> json) {

    }

    static List<ServiceWiseCounts> fromList(List<Map<String, dynamic>> list) {
        return list.map(ServiceWiseCounts.fromJson).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};

        return _data;
    }

    // ServiceWiseCounts copyWith({
    // }) => ServiceWiseCounts();
}