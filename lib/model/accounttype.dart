
class AccountType {
    int? acTypeId;
    String? acTypeName;
    bool? trash;

    AccountType({this.acTypeId, this.acTypeName, this.trash});

    AccountType.fromJson(Map<String, dynamic> json) {
        if(json["acTypeId"] is num) {
            acTypeId = (json["acTypeId"] as num).toInt();
        }
        if(json["acTypeName"] is String) {
            acTypeName = json["acTypeName"];
        }
        if(json["trash"] is bool) {
            trash = json["trash"];
        }
    }

    static List<AccountType> fromList(List<Map<String, dynamic>> list) {
        return list.map(AccountType.fromJson).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["acTypeId"] = acTypeId;
        _data["acTypeName"] = acTypeName;
        _data["trash"] = trash;
        return _data;
    }

    AccountType copyWith({
        int? acTypeId,
        String? acTypeName,
        bool? trash,
    }) => AccountType(
        acTypeId: acTypeId ?? this.acTypeId,
        acTypeName: acTypeName ?? this.acTypeName,
        trash: trash ?? this.trash,
    );
}