
class ProfileModel {
    int? id;
    String? joinDate;
    String? name;
    String? gender;
    String? email;
    int? mobile;
    String? nationalId;
    String? address;
    String? password;
    String? deviceToken;
    bool? trash;

    ProfileModel({this.id, this.joinDate, this.name, this.gender, this.email, this.mobile, this.nationalId, this.address, this.password, this.deviceToken, this.trash});

    ProfileModel.fromJson(Map<String, dynamic> json) {
        if(json["id"] is num) {
            id = (json["id"] as num).toInt();
        }
        if(json["joinDate"] is String) {
            joinDate = json["joinDate"];
        }
        if(json["name"] is String) {
            name = json["name"];
        }
        if(json["gender"] is String) {
            gender = json["gender"];
        }
        if(json["email"] is String) {
            email = json["email"];
        }
        if(json["mobile"] is num) {
            mobile = (json["mobile"] as num).toInt();
        }
        if(json["nationalId"] is String) {
            nationalId = json["nationalId"];
        }
        if(json["address"] is String) {
            address = json["address"];
        }
        if(json["password"] is String) {
            password = json["password"];
        }
        if(json["device_token"] is String) {
            deviceToken = json["device_token"];
        }
        if(json["trash"] is bool) {
            trash = json["trash"];
        }
    }

    static List<ProfileModel> fromList(List<Map<String, dynamic>> list) {
        return list.map(ProfileModel.fromJson).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["joinDate"] = joinDate;
        _data["name"] = name;
        _data["gender"] = gender;
        _data["email"] = email;
        _data["mobile"] = mobile;
        _data["nationalId"] = nationalId;
        _data["address"] = address;
        _data["password"] = password;
        _data["device_token"] = deviceToken;
        _data["trash"] = trash;
        return _data;
    }

    ProfileModel copyWith({
        int? id,
        String? joinDate,
        String? name,
        String? gender,
        String? email,
        int? mobile,
        String? nationalId,
        String? address,
        String? password,
        String? deviceToken,
        bool? trash,
    }) => ProfileModel(
        id: id ?? this.id,
        joinDate: joinDate ?? this.joinDate,
        name: name ?? this.name,
        gender: gender ?? this.gender,
        email: email ?? this.email,
        mobile: mobile ?? this.mobile,
        nationalId: nationalId ?? this.nationalId,
        address: address ?? this.address,
        password: password ?? this.password,
        deviceToken: deviceToken ?? this.deviceToken,
        trash: trash ?? this.trash,
    );
}