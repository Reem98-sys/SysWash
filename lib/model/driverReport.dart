
class DriverReport {
    List<DriverReport1>? driverReport;

    DriverReport({this.driverReport});

    DriverReport.fromJson(Map<String, dynamic> json) {
        if(json["DriverReport"] is List) {
            driverReport = json["DriverReport"] == null ? null : (json["DriverReport"] as List).map((e) => DriverReport1.fromJson(e)).toList();
        }
    }

    static List<DriverReport> fromList(List<Map<String, dynamic>> list) {
        return list.map(DriverReport.fromJson).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        if(driverReport != null) {
            _data["DriverReport"] = driverReport?.map((e) => e.toJson()).toList();
        }
        return _data;
    }

    DriverReport copyWith({
        List<DriverReport1>? driverReport,
    }) => DriverReport(
        driverReport: driverReport ?? this.driverReport,
    );
}

class DriverReport1 {
    int? driverId;
    String? joinDate;
    String? driverName;
    int? driverMobile;
    String? driverArea;
    int? pendingOrders;
    int? totalOrders;

    DriverReport1({this.driverId, this.joinDate, this.driverName, this.driverMobile, this.driverArea, this.pendingOrders, this.totalOrders});

    DriverReport1.fromJson(Map<String, dynamic> json) {
        if(json["DriverId"] is num) {
            driverId = (json["DriverId"] as num).toInt();
        }
        if(json["JoinDate"] is String) {
            joinDate = json["JoinDate"];
        }
        if(json["DriverName"] is String) {
            driverName = json["DriverName"];
        }
        if(json["DriverMobile"] is num) {
            driverMobile = (json["DriverMobile"] as num).toInt();
        }
        if(json["DriverArea"] is String) {
            driverArea = json["DriverArea"];
        }
        if(json["PendingOrders"] is num) {
            pendingOrders = (json["PendingOrders"] as num).toInt();
        }
        if(json["TotalOrders"] is num) {
            totalOrders = (json["TotalOrders"] as num).toInt();
        }
    }

    static List<DriverReport1> fromList(List<Map<String, dynamic>> list) {
        return list.map(DriverReport1.fromJson).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["DriverId"] = driverId;
        _data["JoinDate"] = joinDate;
        _data["DriverName"] = driverName;
        _data["DriverMobile"] = driverMobile;
        _data["DriverArea"] = driverArea;
        _data["PendingOrders"] = pendingOrders;
        _data["TotalOrders"] = totalOrders;
        return _data;
    }

    DriverReport1 copyWith({
        int? driverId,
        String? joinDate,
        String? driverName,
        int? driverMobile,
        String? driverArea,
        int? pendingOrders,
        int? totalOrders,
    }) => DriverReport1(
        driverId: driverId ?? this.driverId,
        joinDate: joinDate ?? this.joinDate,
        driverName: driverName ?? this.driverName,
        driverMobile: driverMobile ?? this.driverMobile,
        driverArea: driverArea ?? this.driverArea,
        pendingOrders: pendingOrders ?? this.pendingOrders,
        totalOrders: totalOrders ?? this.totalOrders,
    );
}