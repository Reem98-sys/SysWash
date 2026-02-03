
class ItemWise {
    String? clothName;
    List<ServiceName>? serviceName;

    ItemWise({this.clothName, this.serviceName});

    ItemWise.fromJson(Map<String, dynamic> json) {
        if(json["ClothName"] is String) {
            clothName = json["ClothName"];
        }
        if(json["ServiceName"] is List) {
            serviceName = json["ServiceName"] == null ? null : (json["ServiceName"] as List).map((e) => ServiceName.fromJson(e)).toList();
        }
    }

    static List<ItemWise> fromList(List<Map<String, dynamic>> list) {
        return list.map(ItemWise.fromJson).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["ClothName"] = clothName;
        if(serviceName != null) {
            _data["ServiceName"] = serviceName?.map((e) => e.toJson()).toList();
        }
        return _data;
    }

    ItemWise copyWith({
        String? clothName,
        List<ServiceName>? serviceName,
    }) => ItemWise(
        clothName: clothName ?? this.clothName,
        serviceName: serviceName ?? this.serviceName,
    );
}

class ServiceName {
    String? serName;
    int? salesCount;
    int? salesValue;
    String? customerName;
    int? quantity;

    ServiceName({this.serName, this.salesCount, this.salesValue, this.customerName, this.quantity});

    ServiceName.fromJson(Map<String, dynamic> json) {
        if(json["SerName"] is String) {
            serName = json["SerName"];
        }
        if(json["SalesCount"] is num) {
            salesCount = (json["SalesCount"] as num).toInt();
        }
        if(json["SalesValue"] is num) {
            salesValue = (json["SalesValue"] as num).toInt();
        }
        if(json["CustomerName"] is String) {
            customerName = json["CustomerName"];
        }
        if(json["quantity"] is num) {
            quantity = (json["quantity"] as num).toInt();
        }
    }

    static List<ServiceName> fromList(List<Map<String, dynamic>> list) {
        return list.map(ServiceName.fromJson).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["SerName"] = serName;
        _data["SalesCount"] = salesCount;
        _data["SalesValue"] = salesValue;
        _data["CustomerName"] = customerName;
        _data["quantity"] = quantity;
        return _data;
    }

    ServiceName copyWith({
        String? serName,
        int? salesCount,
        int? salesValue,
        String? customerName,
        int? quantity,
    }) => ServiceName(
        serName: serName ?? this.serName,
        salesCount: salesCount ?? this.salesCount,
        salesValue: salesValue ?? this.salesValue,
        customerName: customerName ?? this.customerName,
        quantity: quantity ?? this.quantity,
    );
}