
class LoginModel {
    String? email;
    int? id;
    String? username;
    String? userType;
    String? access;
    String? refresh;

    LoginModel({this.email, this.id, this.username, this.userType, this.access, this.refresh});

    LoginModel.fromJson(Map<String, dynamic> json) {
        if(json["email"] is String) {
            email = json["email"];
        }
        if(json["id"] is num) {
            id = (json["id"] as num).toInt();
        }
        if(json["username"] is String) {
            username = json["username"];
        }
        if(json["userType"] is String) {
            userType = json["userType"];
        }
        if(json["access"] is String) {
            access = json["access"];
        }
        if(json["refresh"] is String) {
            refresh = json["refresh"];
        }
    }

    static List<LoginModel> fromList(List<Map<String, dynamic>> list) {
        return list.map(LoginModel.fromJson).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["email"] = email;
        _data["id"] = id;
        _data["username"] = username;
        _data["userType"] = userType;
        _data["access"] = access;
        _data["refresh"] = refresh;
        return _data;
    }

    LoginModel copyWith({
        String? email,
        int? id,
        String? username,
        String? userType,
        String? access,
        String? refresh,
    }) => LoginModel(
        email: email ?? this.email,
        id: id ?? this.id,
        username: username ?? this.username,
        userType: userType ?? this.userType,
        access: access ?? this.access,
        refresh: refresh ?? this.refresh,
    );
}