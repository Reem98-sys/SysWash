
class AdminBranch {
    List<Data>? data;

    AdminBranch({this.data});

    AdminBranch.fromJson(Map<String, dynamic> json) {
        if(json["data"] is List) {
            data = json["data"] == null ? null : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
        }
    }

    static List<AdminBranch> fromList(List<Map<String, dynamic>> list) {
        return list.map(AdminBranch.fromJson).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        if(data != null) {
            _data["data"] = data?.map((e) => e.toJson()).toList();
        }
        return _data;
    }

    AdminBranch copyWith({
        List<Data>? data,
    }) => AdminBranch(
        data: data ?? this.data,
    );
}

class Data {
    int? branchId;
    String? branchName;
    String? branchCode;
    String? adminEmail;
    String? joiningDate;
    String? city;
    String? country;
    String? companyMobile;
    bool? trash;

    Data({this.branchId, this.branchName, this.branchCode, this.adminEmail, this.joiningDate, this.city, this.country, this.companyMobile, this.trash});

    Data.fromJson(Map<String, dynamic> json) {
        if(json["branchId"] is num) {
            branchId = (json["branchId"] as num).toInt();
        }
        if(json["branchName"] is String) {
            branchName = json["branchName"];
        }
        if(json["branchCode"] is String) {
            branchCode = json["branchCode"];
        }
        if(json["adminEmail"] is String) {
            adminEmail = json["adminEmail"];
        }
        if(json["joiningDate"] is String) {
            joiningDate = json["joiningDate"];
        }
        if(json["city"] is String) {
            city = json["city"];
        }
        if(json["country"] is String) {
            country = json["country"];
        }
        if(json["companyMobile"] is String) {
            companyMobile = json["companyMobile"];
        }
        if(json["trash"] is bool) {
            trash = json["trash"];
        }
    }

    static List<Data> fromList(List<Map<String, dynamic>> list) {
        return list.map(Data.fromJson).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["branchId"] = branchId;
        _data["branchName"] = branchName;
        _data["branchCode"] = branchCode;
        _data["adminEmail"] = adminEmail;
        _data["joiningDate"] = joiningDate;
        _data["city"] = city;
        _data["country"] = country;
        _data["companyMobile"] = companyMobile;
        _data["trash"] = trash;
        return _data;
    }

    Data copyWith({
        int? branchId,
        String? branchName,
        String? branchCode,
        String? adminEmail,
        String? joiningDate,
        String? city,
        String? country,
        String? companyMobile,
        bool? trash,
    }) => Data(
        branchId: branchId ?? this.branchId,
        branchName: branchName ?? this.branchName,
        branchCode: branchCode ?? this.branchCode,
        adminEmail: adminEmail ?? this.adminEmail,
        joiningDate: joiningDate ?? this.joiningDate,
        city: city ?? this.city,
        country: country ?? this.country,
        companyMobile: companyMobile ?? this.companyMobile,
        trash: trash ?? this.trash,
    );
}