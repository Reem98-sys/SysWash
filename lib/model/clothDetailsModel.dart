
class ClothDetailsModel {
    List<Data>? data;

    ClothDetailsModel({this.data});

    ClothDetailsModel.fromJson(Map<String, dynamic> json) {
        if(json["data"] is List) {
            data = json["data"] == null ? null : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
        }
    }

    static List<ClothDetailsModel> fromList(List<Map<String, dynamic>> list) {
        return list.map(ClothDetailsModel.fromJson).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        if(data != null) {
            _data["data"] = data?.map((e) => e.toJson()).toList();
        }
        return _data;
    }

    ClothDetailsModel copyWith({
        List<Data>? data,
    }) => ClothDetailsModel(
        data: data ?? this.data,
    );
}

class Data {
    Data1? data;
    String? clothImage;
    String? clothArabicName;
    String? serviceCode;

    Data({this.data, this.clothImage, this.clothArabicName, this.serviceCode});

    Data.fromJson(Map<String, dynamic> json) {
        if(json["data"] is Map) {
            data = json["data"] == null ? null : Data1.fromJson(json["data"]);
        }
        if(json["clothImage"] is String) {
            clothImage = json["clothImage"];
        }
        if(json["ClothArabicName"] is String) {
            clothArabicName = json["ClothArabicName"];
        }
        if(json["ServiceCode"] is String) {
            serviceCode = json["ServiceCode"];
        }
    }

    static List<Data> fromList(List<Map<String, dynamic>> list) {
        return list.map(Data.fromJson).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        if(data != null) {
            _data["data"] = data?.toJson();
        }
        _data["clothImage"] = clothImage;
        _data["ClothArabicName"] = clothArabicName;
        _data["ServiceCode"] = serviceCode;
        return _data;
    }

    Data copyWith({
        Data1? data,
        String? clothImage,
        String? clothArabicName,
        String? serviceCode,
    }) => Data(
        data: data ?? this.data,
        clothImage: clothImage ?? this.clothImage,
        clothArabicName: clothArabicName ?? this.clothArabicName,
        serviceCode: serviceCode ?? this.serviceCode,
    );
}

class Data1 {
    int? priceId;
    String? serviceName;
    String? clothType;
    String? price;
    String? xprice;
    String? date;
    String? unit;
    bool? trash;

    Data1({this.priceId, this.serviceName, this.clothType, this.price, this.xprice, this.date, this.unit, this.trash});

    Data1.fromJson(Map<String, dynamic> json) {
        if(json["priceId"] is num) {
            priceId = (json["priceId"] as num).toInt();
        }
        if(json["serviceName"] is String) {
            serviceName = json["serviceName"];
        }
        if(json["clothType"] is String) {
            clothType = json["clothType"];
        }
        if(json["price"] is String) {
            price = json["price"];
        }
        if(json["xprice"] is String) {
            xprice = json["xprice"];
        }
        if(json["date"] is String) {
            date = json["date"];
        }
        if(json["unit"] is String) {
            unit = json["unit"];
        }
        if(json["trash"] is bool) {
            trash = json["trash"];
        }
    }

    static List<Data1> fromList(List<Map<String, dynamic>> list) {
        return list.map(Data1.fromJson).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["priceId"] = priceId;
        _data["serviceName"] = serviceName;
        _data["clothType"] = clothType;
        _data["price"] = price;
        _data["xprice"] = xprice;
        _data["date"] = date;
        _data["unit"] = unit;
        _data["trash"] = trash;
        return _data;
    }

    Data1 copyWith({
        int? priceId,
        String? serviceName,
        String? clothType,
        String? price,
        String? xprice,
        String? date,
        String? unit,
        bool? trash,
    }) => Data1(
        priceId: priceId ?? this.priceId,
        serviceName: serviceName ?? this.serviceName,
        clothType: clothType ?? this.clothType,
        price: price ?? this.price,
        xprice: xprice ?? this.xprice,
        date: date ?? this.date,
        unit: unit ?? this.unit,
        trash: trash ?? this.trash,
    );
}