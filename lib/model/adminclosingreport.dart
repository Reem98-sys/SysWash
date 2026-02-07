
class AdminClosingReport {
    List<Clothcount>? clothcount;
    num? totalQnty;
    num? totalGrossSale;
    num? totalCashSale;
    num? totalCardSale;
    num? totalBankSale;
    num? totalWalletSale;
    num? totalDiscount;
    num? totalCommission;
    num? totalPaidAmount;
    num? totalBalance;
    num? totalVatValue;
    num? totalExpense;
    num? walletBalance;
    num? walletaddamount;
    num? cashOut;
    num? cashIn;
    Map<String, ServiceWiseCounts>? serviceWiseCounts;
    num? outstandingamount;
    num? debtamount;
    num? cashexpense;
    num? cardbalance;
    num? bankbalance;

    AdminClosingReport({this.clothcount, this.totalQnty, this.totalGrossSale, this.totalCashSale, this.totalCardSale, this.totalBankSale, this.totalWalletSale, this.totalDiscount, this.totalCommission, this.totalPaidAmount, this.totalBalance, this.totalVatValue, this.totalExpense, this.walletBalance, this.walletaddamount, this.cashOut, this.cashIn, this.serviceWiseCounts, this.outstandingamount, this.debtamount, this.cashexpense, this.cardbalance, this.bankbalance});

    AdminClosingReport.fromJson(Map<String, dynamic> json) {
        if(json["Clothcount"] is List) {
            clothcount = json["Clothcount"] == null ? null : (json["Clothcount"] as List).map((e) => Clothcount.fromJson(e)).toList();
        }
        if(json["TotalQnty"] is num) {
            totalQnty = json["TotalQnty"];
        }
        if(json["TotalGrossSale"] is num) {
            totalGrossSale = json["TotalGrossSale"];
        }
        if(json["TotalCashSale"] is num) {
            totalCashSale = json["TotalCashSale"];
        }
        if(json["TotalCardSale"] is num) {
            totalCardSale = json["TotalCardSale"];
        }
        if(json["TotalBankSale"] is num) {
            totalBankSale = json["TotalBankSale"];
        }
        if(json["TotalWalletSale"] is num) {
            totalWalletSale = json["TotalWalletSale"];
        }
        if(json["TotalDiscount"] is num) {
            totalDiscount = json["TotalDiscount"];
        }
        if(json["TotalCommission"] is num) {
            totalCommission = json["TotalCommission"];
        }
        if(json["TotalPaidAmount"] is num) {
            totalPaidAmount = json["TotalPaidAmount"];
        }
        if(json["TotalBalance"] is num) {
            totalBalance = json["TotalBalance"];
        }
        if(json["TotalVatValue"] is num) {
            totalVatValue = json["TotalVatValue"];
        }
        if(json["TotalExpense"] is num) {
            totalExpense = json["TotalExpense"];
        }
        if(json["walletBalance"] is num) {
            walletBalance = json["walletBalance"];
        }
        if(json["walletaddamount"] is num) {
            walletaddamount = json["walletaddamount"];
        }
        if(json["CashOut"] is num) {
            cashOut = json["CashOut"];
        }
        if(json["cashIn"] is num) {
            cashIn = json["cashIn"];
        }
        if (json["ServiceWiseCounts"] is Map<String, dynamic>) {
          serviceWiseCounts =
              (json["ServiceWiseCounts"] as Map<String, dynamic>).map(
            (key, value) => MapEntry(
              key,
              ServiceWiseCounts.fromJson(value),
            ),
          );
        }
        if(json["outstandingamount"] is num) {
            outstandingamount = json["outstandingamount"];
        }
        if(json["debtamount"] is num) {
            debtamount = json["debtamount"];
        }
        if(json["cashexpense"] is num) {
            cashexpense = json["cashexpense"];
        }
        if(json["cardbalance"] is num) {
            cardbalance = json["cardbalance"];
        }
        if(json["bankbalance"] is num) {
            bankbalance = json["bankbalance"];
        }
    }

    static List<AdminClosingReport> fromList(List<Map<String, dynamic>> list) {
        return list.map(AdminClosingReport.fromJson).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        if(clothcount != null) {
            _data["Clothcount"] = clothcount?.map((e) => e.toJson()).toList();
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
        if (serviceWiseCounts != null) {
          _data["ServiceWiseCounts"] =
              serviceWiseCounts!.map((k, v) => MapEntry(k, v.toJson()));
        }
        _data["outstandingamount"] = outstandingamount;
        _data["debtamount"] = debtamount;
        _data["cashexpense"] = cashexpense;
        _data["cardbalance"] = cardbalance;
        _data["bankbalance"] = bankbalance;
        return _data;
    }

    AdminClosingReport copyWith({
        List<Clothcount>? clothcount,
        num? totalQnty,
        num? totalGrossSale,
        num? totalCashSale,
        num? totalCardSale,
        num? totalBankSale,
        num? totalWalletSale,
        num? totalDiscount,
        num? totalCommission,
        num? totalPaidAmount,
        num? totalBalance,
        num? totalVatValue,
        num? totalExpense,
        num? walletBalance,
        num? walletaddamount,
        num? cashOut,
        num? cashIn,
        Map<String, ServiceWiseCounts>? serviceWiseCounts,
        num? outstandingamount,
        num? debtamount,
        num? cashexpense,
        num? cardbalance,
        num? bankbalance,
    }) => AdminClosingReport(
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
        cardbalance: cardbalance ?? this.cardbalance,
        bankbalance: bankbalance ?? this.bankbalance,
    );
}

class ServiceWiseCounts {
  int count;
  double totalPrice;

  ServiceWiseCounts({
    required this.count,
    required this.totalPrice,
  });

  factory ServiceWiseCounts.fromJson(Map<String, dynamic> json) {
    return ServiceWiseCounts(
      count: json['count'] ?? 0,
      totalPrice: (json['total_price'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'count': count,
        'total_price': totalPrice,
      };
}

class Clothcount {
    String? cloth;
    int? count;
    num? price;
    String? service;

    Clothcount({this.cloth, this.count, this.price, this.service});

    Clothcount.fromJson(Map<String, dynamic> json) {
        if(json["cloth"] is String) {
            cloth = json["cloth"];
        }
        if(json["count"] is num) {
            count = (json["count"] as num).toInt();
        }
        if(json["price"] is num) {
            price = json["price"];
        }
        if(json["service"] is String) {
            service = json["service"];
        }
    }

    static List<Clothcount> fromList(List<Map<String, dynamic>> list) {
        return list.map(Clothcount.fromJson).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["cloth"] = cloth;
        _data["count"] = count;
        _data["price"] = price;
        _data["service"] = service;
        return _data;
    }

    Clothcount copyWith({
        String? cloth,
        int? count,
        num? price,
        String? service,
    }) => Clothcount(
        cloth: cloth ?? this.cloth,
        count: count ?? this.count,
        price: price ?? this.price,
        service: service ?? this.service,
    );
}