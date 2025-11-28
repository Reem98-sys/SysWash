
class ServiceDetailsModel {
    int? serviceId;
    String? serviceName;
    String? serviceCode;
    String? serviceDate;
    bool? posView;
    bool? trash;

    ServiceDetailsModel({this.serviceId, this.serviceName, this.serviceCode, this.serviceDate, this.posView, this.trash});

    ServiceDetailsModel.fromJson(Map<String, dynamic> json) {
        if(json["serviceId"] is num) {
            serviceId = (json["serviceId"] as num).toInt();
        }
        if(json["serviceName"] is String) {
            serviceName = json["serviceName"];
        }
        if(json["serviceCode"] is String) {
            serviceCode = json["serviceCode"];
        }
        if(json["serviceDate"] is String) {
            serviceDate = json["serviceDate"];
        }
        if(json["posView"] is bool) {
            posView = json["posView"];
        }
        if(json["trash"] is bool) {
            trash = json["trash"];
        }
    }

    static List<ServiceDetailsModel> fromList(List<Map<String, dynamic>> list) {
        return list.map(ServiceDetailsModel.fromJson).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["serviceId"] = serviceId;
        _data["serviceName"] = serviceName;
        _data["serviceCode"] = serviceCode;
        _data["serviceDate"] = serviceDate;
        _data["posView"] = posView;
        _data["trash"] = trash;
        return _data;
    }

    ServiceDetailsModel copyWith({
        int? serviceId,
        String? serviceName,
        String? serviceCode,
        String? serviceDate,
        bool? posView,
        bool? trash,
    }) => ServiceDetailsModel(
        serviceId: serviceId ?? this.serviceId,
        serviceName: serviceName ?? this.serviceName,
        serviceCode: serviceCode ?? this.serviceCode,
        serviceDate: serviceDate ?? this.serviceDate,
        posView: posView ?? this.posView,
        trash: trash ?? this.trash,
    );
}