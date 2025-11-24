import 'dart:convert';

import 'package:syswash/model/customerListModel.dart';
import 'package:syswash/model/customer_list_response.dart';
import 'package:syswash/model/deliveryListModel.dart';
import 'package:syswash/model/delivery_list_response.dart';
import 'package:syswash/model/pickupCustomerDetailsModel.dart';
import 'package:syswash/model/pickupListModel.dart';
import 'package:syswash/model/pickup_list_response.dart';
import 'package:syswash/model/totalOrder.dart';
import 'package:syswash/screens/login.dart';

import 'api_client.dart';
import 'package:http/http.dart';
import 'package:syswash/model/loginModel.dart';
import 'package:syswash/repositories/api_client.dart';

class SysRepository {
  ApiClient apiClient = ApiClient();
  var body = {};
  Future<LoginModel> loginIn(
    String email,
    String password,
    String companyCode,
  ) async {
    String url = "https://be.syswash.net/api/syswash/login?code=${companyCode}";
    var body = {"email": email, "password": password};
    Response response = await apiClient.invokeAPI(
      url,
      "POST",
      jsonEncode(body),
    );
    return LoginModel.fromJson(jsonDecode(response.body));
  }

  Future<TotalOrderModel> totalOrder(
    String userId,
    String companyCode,
    String token,
  ) async {
    String url =
        "https://be.syswash.net/api/syswash/historylist/${userId}?code=${companyCode}";
    var body = {};
    Response response = await apiClient.invokeAPI(
      url,
      "GET",
      jsonEncode(body),
      token: token,
    );
    return TotalOrderModel.fromJson(jsonDecode(response.body));
  }

  Future<PickUpListResponse> pickUpList(
    String userId,
    String companyCode,
    String token,
  ) async {
    String url =
        "https://be.syswash.net/api/syswash/pickuplist/$userId?code=$companyCode";

    Response response = await apiClient.invokeAPI(
      url,
      "GET",
      jsonEncode({}),
      token: token,
    );

    final decoded = jsonDecode(response.body);

    if (decoded is List) {
      // When API directly returns a list
      return PickUpListResponse(
        data: decoded.map((item) => PickUpListModel.fromJson(item)).toList(),
      );
    } else if (decoded is Map && decoded['data'] is List) {
      //  When API returns { "data": [ ... ] }
      return PickUpListResponse(
        data:
            (decoded['data'] as List)
                .map((item) => PickUpListModel.fromJson(item))
                .toList(),
      );
    } else {
      throw Exception('Unexpected response format: ${decoded.runtimeType}');
    }
  }

  Future<DeliveryListResponse> deliveryList(
    String userId,
    String companyCode,
    String token,
  ) async {
    String url =
        "https://be.syswash.net/api/syswash/deliverylist/$userId?code=$companyCode";

    Response response = await apiClient.invokeAPI(
      url,
      "GET",
      jsonEncode({}),
      token: token,
    );

    final decoded = jsonDecode(response.body);

    if (decoded is List) {
      return DeliveryListResponse(
        data: decoded.map((item) => DeliveryListModel.fromJson(item)).toList(),
      );
    } else if (decoded is Map && decoded['data'] is List) {
      return DeliveryListResponse(
        data:
            (decoded['data'] as List)
                .map((item) => DeliveryListModel.fromJson(item))
                .toList(),
      );
    } else {
      throw Exception('Unexpected response format: ${decoded.runtimeType}');
    }
  }

  Future<CustomerListResponse> customerList(String token) async {
    String url = "https://be.syswash.net/api/syswash/customerlist?code=A";

    Response response = await apiClient.invokeAPI(
      url,
      "GET",
      jsonEncode({}),
      token: token,
    );

    final decoded = jsonDecode(response.body);
    print('🚀 deliveryList API response type: ${decoded.runtimeType}');

    if (decoded is List) {
      return CustomerListResponse(
        data: decoded.map((item) => CustomerListModel.fromJson(item)).toList(),
      );
    } else if (decoded is Map && decoded['data'] is List) {
      return CustomerListResponse(
        data:
            (decoded['data'] as List)
                .map((item) => CustomerListModel.fromJson(item))
                .toList(),
      );
    } else {
      throw Exception('Unexpected response format: ${decoded.runtimeType}');
    }
  }

  Future<PickUpCustomerDetailsModel> pickupcustomerdetails(
    String pickupassgnId,
    String token,
    String companyCode,
  ) async {
    String url = "pickup/${pickupassgnId}?code=${companyCode}";
    Response response = await apiClient.invokeAPI(
      url,
      "GET",
      jsonEncode({}),
      token: token,
    );
    return PickUpCustomerDetailsModel.fromJson(jsonDecode(response.body));
  }
}
