
class TotalOrderModel {
    String? totalOrders;
    String? message;

    TotalOrderModel({this.totalOrders, this.message});

    TotalOrderModel.fromJson(Map<String, dynamic> json) {
        if(json["total_orders"] is String) {
            totalOrders = json["total_orders"];
        }
        if(json["message"] is String) {
            message = json["message"];
        }
    }

    static List<TotalOrderModel> fromList(List<Map<String, dynamic>> list) {
        return list.map(TotalOrderModel.fromJson).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["total_orders"] = totalOrders;
        _data["message"] = message;
        return _data;
    }

    TotalOrderModel copyWith({
        String? totalOrders,
        String? message,
    }) => TotalOrderModel(
        totalOrders: totalOrders ?? this.totalOrders,
        message: message ?? this.message,
    );
}