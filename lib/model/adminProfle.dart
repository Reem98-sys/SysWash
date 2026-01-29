
class AdminProfile {
    int? id;
    String? dateJoined;
    String? lastLogin;
    bool? isSuperuser;
    String? email;
    dynamic firstName;
    dynamic lastName;
    bool? isActive;
    bool? isStaff;
    String? password;
    String? userType;
    String? userName;
    String? userCreatedDate;
    String? userExpirationDate;
    String? lastLogout;
    int? failedAttempts;
    dynamic otp;
    dynamic otpCreatedAt;
    int? orderLimit;
    bool? trash;
    List<dynamic>? groups;
    List<dynamic>? userPermissions;

    AdminProfile({this.id, this.dateJoined, this.lastLogin, this.isSuperuser, this.email, this.firstName, this.lastName, this.isActive, this.isStaff, this.password, this.userType, this.userName, this.userCreatedDate, this.userExpirationDate, this.lastLogout, this.failedAttempts, this.otp, this.otpCreatedAt, this.orderLimit, this.trash, this.groups, this.userPermissions});

    AdminProfile.fromJson(Map<String, dynamic> json) {
        if(json["id"] is num) {
            id = (json["id"] as num).toInt();
        }
        if(json["date_joined"] is String) {
            dateJoined = json["date_joined"];
        }
        if(json["last_login"] is String) {
            lastLogin = json["last_login"];
        }
        if(json["is_superuser"] is bool) {
            isSuperuser = json["is_superuser"];
        }
        if(json["email"] is String) {
            email = json["email"];
        }
        firstName = json["first_name"];
        lastName = json["last_name"];
        if(json["is_active"] is bool) {
            isActive = json["is_active"];
        }
        if(json["is_staff"] is bool) {
            isStaff = json["is_staff"];
        }
        if(json["password"] is String) {
            password = json["password"];
        }
        if(json["userType"] is String) {
            userType = json["userType"];
        }
        if(json["userName"] is String) {
            userName = json["userName"];
        }
        if(json["userCreatedDate"] is String) {
            userCreatedDate = json["userCreatedDate"];
        }
        if(json["userExpirationDate"] is String) {
            userExpirationDate = json["userExpirationDate"];
        }
        if(json["last_logout"] is String) {
            lastLogout = json["last_logout"];
        }
        if(json["failed_attempts"] is num) {
            failedAttempts = (json["failed_attempts"] as num).toInt();
        }
        otp = json["otp"];
        otpCreatedAt = json["otp_created_at"];
        if(json["order_limit"] is num) {
            orderLimit = (json["order_limit"] as num).toInt();
        }
        if(json["trash"] is bool) {
            trash = json["trash"];
        }
        if(json["groups"] is List) {
            groups = json["groups"] ?? [];
        }
        if(json["user_permissions"] is List) {
            userPermissions = json["user_permissions"] ?? [];
        }
    }

    static List<AdminProfile> fromList(List<Map<String, dynamic>> list) {
        return list.map(AdminProfile.fromJson).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["date_joined"] = dateJoined;
        _data["last_login"] = lastLogin;
        _data["is_superuser"] = isSuperuser;
        _data["email"] = email;
        _data["first_name"] = firstName;
        _data["last_name"] = lastName;
        _data["is_active"] = isActive;
        _data["is_staff"] = isStaff;
        _data["password"] = password;
        _data["userType"] = userType;
        _data["userName"] = userName;
        _data["userCreatedDate"] = userCreatedDate;
        _data["userExpirationDate"] = userExpirationDate;
        _data["last_logout"] = lastLogout;
        _data["failed_attempts"] = failedAttempts;
        _data["otp"] = otp;
        _data["otp_created_at"] = otpCreatedAt;
        _data["order_limit"] = orderLimit;
        _data["trash"] = trash;
        if(groups != null) {
            _data["groups"] = groups;
        }
        if(userPermissions != null) {
            _data["user_permissions"] = userPermissions;
        }
        return _data;
    }

    AdminProfile copyWith({
        int? id,
        String? dateJoined,
        String? lastLogin,
        bool? isSuperuser,
        String? email,
        dynamic firstName,
        dynamic lastName,
        bool? isActive,
        bool? isStaff,
        String? password,
        String? userType,
        String? userName,
        String? userCreatedDate,
        String? userExpirationDate,
        String? lastLogout,
        int? failedAttempts,
        dynamic otp,
        dynamic otpCreatedAt,
        int? orderLimit,
        bool? trash,
        List<dynamic>? groups,
        List<dynamic>? userPermissions,
    }) => AdminProfile(
        id: id ?? this.id,
        dateJoined: dateJoined ?? this.dateJoined,
        lastLogin: lastLogin ?? this.lastLogin,
        isSuperuser: isSuperuser ?? this.isSuperuser,
        email: email ?? this.email,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        isActive: isActive ?? this.isActive,
        isStaff: isStaff ?? this.isStaff,
        password: password ?? this.password,
        userType: userType ?? this.userType,
        userName: userName ?? this.userName,
        userCreatedDate: userCreatedDate ?? this.userCreatedDate,
        userExpirationDate: userExpirationDate ?? this.userExpirationDate,
        lastLogout: lastLogout ?? this.lastLogout,
        failedAttempts: failedAttempts ?? this.failedAttempts,
        otp: otp ?? this.otp,
        otpCreatedAt: otpCreatedAt ?? this.otpCreatedAt,
        orderLimit: orderLimit ?? this.orderLimit,
        trash: trash ?? this.trash,
        groups: groups ?? this.groups,
        userPermissions: userPermissions ?? this.userPermissions,
    );
}