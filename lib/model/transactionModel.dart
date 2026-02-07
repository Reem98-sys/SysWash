
class TransactionModel {
    String? date;
    String? trType;
    String? transactionDetails;
    String? mode;
    num? debit;
    num? credit;

    TransactionModel({this.date, this.trType, this.transactionDetails, this.mode, this.debit, this.credit});

    TransactionModel.fromJson(Map<String, dynamic> json) {
        if(json["Date"] is String) {
            date = json["Date"];
        }
        if(json["TrType"] is String) {
            trType = json["TrType"];
        }
        if(json["TransactionDetails"] is String) {
            transactionDetails = json["TransactionDetails"];
        }
        if(json["Mode"] is String) {
            mode = json["Mode"];
        }
        if(json["Debit"] is num) {
            debit = json["Debit"];
        }
        if(json["Credit"] is num) {
            credit = json["Credit"];
        }
    }

    static List<TransactionModel> fromList(List<Map<String, dynamic>> list) {
        return list.map(TransactionModel.fromJson).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["Date"] = date;
        _data["TrType"] = trType;
        _data["TransactionDetails"] = transactionDetails;
        _data["Mode"] = mode;
        _data["Debit"] = debit;
        _data["Credit"] = credit;
        return _data;
    }

    TransactionModel copyWith({
        String? date,
        String? trType,
        String? transactionDetails,
        String? mode,
        num? debit,
        num? credit,
    }) => TransactionModel(
        date: date ?? this.date,
        trType: trType ?? this.trType,
        transactionDetails: transactionDetails ?? this.transactionDetails,
        mode: mode ?? this.mode,
        debit: debit ?? this.debit,
        credit: credit ?? this.credit,
    );
}