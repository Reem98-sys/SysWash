
class TotalOrderModel {
    List<dynamic>? pickup;
    List<dynamic>? delivery;

    TotalOrderModel({this.pickup, this.delivery});

    TotalOrderModel.fromJson(Map<String, dynamic> json) {
        if(json["pickup"] is List) {
            pickup = json["pickup"] ?? [];
        }
        if(json["delivery"] is List) {
            delivery = json["delivery"] ?? [];
        }
    }

    static List<TotalOrderModel> fromList(List<Map<String, dynamic>> list) {
        return list.map(TotalOrderModel.fromJson).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        if(pickup != null) {
            _data["pickup"] = pickup;
        }
        if(delivery != null) {
            _data["delivery"] = delivery;
        }
        return _data;
    }

    TotalOrderModel copyWith({
        List<dynamic>? pickup,
        List<dynamic>? delivery,
    }) => TotalOrderModel(
        pickup: pickup ?? this.pickup,
        delivery: delivery ?? this.delivery,
    );
}