import 'package:syswash/model/deliveryListModel.dart';

class DeliveryListResponse {
  List<DeliveryListModel>? data;

  DeliveryListResponse({this.data});

  factory DeliveryListResponse.fromJson(dynamic json) {
    if (json is List) {
      return DeliveryListResponse(
        data: json.map((e) => DeliveryListModel.fromJson(e)).toList(),
      );
    } else {
      throw Exception('Expected a list but got ${json.runtimeType}');
    }
  }
}
