
class EmployeeReport {
    List<EmployeeReport1>? employeeReport;

    EmployeeReport({this.employeeReport});

    EmployeeReport.fromJson(Map<String, dynamic> json) {
        if(json["EmployeeReport"] is List) {
            employeeReport = json["EmployeeReport"] == null ? null : (json["EmployeeReport"] as List).map((e) => EmployeeReport1.fromJson(e)).toList();
        }
    }

    static List<EmployeeReport> fromList(List<Map<String, dynamic>> list) {
        return list.map(EmployeeReport.fromJson).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        if(employeeReport != null) {
            _data["EmployeeReport"] = employeeReport?.map((e) => e.toJson()).toList();
        }
        return _data;
    }

    EmployeeReport copyWith({
        List<EmployeeReport1>? employeeReport,
    }) => EmployeeReport(
        employeeReport: employeeReport ?? this.employeeReport,
    );
}

class EmployeeReport1 {
    int? employeeId;
    String? joinDate;
    String? employeeName;
    int? employeeMobile;
    String? employeeAddress;
    String? position;
    int? totalOrder;
    int? totalQuantity;
    int? pendingOrder;
    int? pendingQuantity;

    EmployeeReport1({this.employeeId, this.joinDate, this.employeeName, this.employeeMobile, this.employeeAddress, this.position, this.totalOrder, this.totalQuantity, this.pendingOrder, this.pendingQuantity});

    EmployeeReport1.fromJson(Map<String, dynamic> json) {
        if(json["EmployeeId"] is num) {
            employeeId = (json["EmployeeId"] as num).toInt();
        }
        if(json["JoinDate"] is String) {
            joinDate = json["JoinDate"];
        }
        if(json["EmployeeName"] is String) {
            employeeName = json["EmployeeName"];
        }
        if(json["EmployeeMobile"] is num) {
            employeeMobile = (json["EmployeeMobile"] as num).toInt();
        }
        if(json["EmployeeAddress"] is String) {
            employeeAddress = json["EmployeeAddress"];
        }
        if(json["Position"] is String) {
            position = json["Position"];
        }
        if(json["TotalOrder"] is num) {
            totalOrder = (json["TotalOrder"] as num).toInt();
        }
        if(json["TotalQuantity"] is num) {
            totalQuantity = (json["TotalQuantity"] as num).toInt();
        }
        if(json["PendingOrder"] is num) {
            pendingOrder = (json["PendingOrder"] as num).toInt();
        }
        if(json["PendingQuantity"] is num) {
            pendingQuantity = (json["PendingQuantity"] as num).toInt();
        }
    }

    static List<EmployeeReport1> fromList(List<Map<String, dynamic>> list) {
        return list.map(EmployeeReport1.fromJson).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["EmployeeId"] = employeeId;
        _data["JoinDate"] = joinDate;
        _data["EmployeeName"] = employeeName;
        _data["EmployeeMobile"] = employeeMobile;
        _data["EmployeeAddress"] = employeeAddress;
        _data["Position"] = position;
        _data["TotalOrder"] = totalOrder;
        _data["TotalQuantity"] = totalQuantity;
        _data["PendingOrder"] = pendingOrder;
        _data["PendingQuantity"] = pendingQuantity;
        return _data;
    }

    EmployeeReport1 copyWith({
        int? employeeId,
        String? joinDate,
        String? employeeName,
        int? employeeMobile,
        String? employeeAddress,
        String? position,
        int? totalOrder,
        int? totalQuantity,
        int? pendingOrder,
        int? pendingQuantity,
    }) => EmployeeReport1(
        employeeId: employeeId ?? this.employeeId,
        joinDate: joinDate ?? this.joinDate,
        employeeName: employeeName ?? this.employeeName,
        employeeMobile: employeeMobile ?? this.employeeMobile,
        employeeAddress: employeeAddress ?? this.employeeAddress,
        position: position ?? this.position,
        totalOrder: totalOrder ?? this.totalOrder,
        totalQuantity: totalQuantity ?? this.totalQuantity,
        pendingOrder: pendingOrder ?? this.pendingOrder,
        pendingQuantity: pendingQuantity ?? this.pendingQuantity,
    );
}