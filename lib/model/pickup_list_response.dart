import 'package:syswash/model/pickupListModel.dart';

class PickUpListResponse {
  List<PickUpListModel>? data;

  PickUpListResponse({this.data});

  factory PickUpListResponse.fromJson(dynamic json) {
    if (json is List) {
      return PickUpListResponse(
        data: json.map((e) => PickUpListModel.fromJson(e)).toList(),
      );
    } else {
      throw Exception('Expected a list but got ${json.runtimeType}');
    }
  }
}
