

import 'package:syswash/model/customerListModel.dart';

class CustomerListResponse {
  List<CustomerListModel>? data;

  CustomerListResponse({this.data});

  factory CustomerListResponse.fromJson(dynamic json) {
    if (json is List) {
      return CustomerListResponse(
        data: json.map((e) => CustomerListModel.fromJson(e)).toList(),
      );
    } else {
      throw Exception('Expected a list but got ${json.runtimeType}');
    }
  }
}