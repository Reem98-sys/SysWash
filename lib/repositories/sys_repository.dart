import 'dart:convert';

import 'package:syswash/model/clothDetailsModel.dart';
import 'package:syswash/model/customerDetailsModel.dart';
import 'package:syswash/model/customerListModel.dart';
import 'package:syswash/model/customer_list_response.dart';
import 'package:syswash/model/deliveryListModel.dart';
import 'package:syswash/model/delivery_list_response.dart';
import 'package:syswash/model/pickupListModel.dart';
import 'package:syswash/model/pickupOrderItemsModel.dart';
import 'package:syswash/model/pickup_list_response.dart';
import 'package:syswash/model/serviceDetails.dart';
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

Future<List<ServiceDetailsModel>> servicedetail (
    String companyCode,
    String token,
  ) async {
    String url =
        "https://be.syswash.net/api/syswash/servicedetails?code=${companyCode}";

    Response response = await apiClient.invokeAPI(
      url,
      "GET",
      jsonEncode({}),
      token: token,
    );

    final decoded = jsonDecode(response.body);
    print('🚀 deliveryList API response type: ${decoded.runtimeType}');

    if (decoded is List) {
    return decoded.map((item) => ServiceDetailsModel.fromJson(item)).toList();
  } else if (decoded is Map && decoded['data'] is List) {
    return (decoded['data'] as List)
        .map((item) => ServiceDetailsModel.fromJson(item))
        .toList();
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

  Future<CustomerListResponse> customerList(
    String token,
    String companyCode,
  ) async {
    String url =
        "https://be.syswash.net/api/syswash/customerlist?code=${companyCode}";

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

  Future<ClothDetailsModel> clothdetailsList(
    String servicetype,
    String token,
    String companyCode,
  ) async {
    String url =
        "https://be.syswash.net/api/syswash/pos/${servicetype}?&code=${companyCode}";

    Response response = await apiClient.invokeAPI(
      url,
      "GET",
      jsonEncode({}),
      token: token,
    );

    return ClothDetailsModel.fromJson(jsonDecode(response.body));
  }

  Future<CustomerDetailsModel> pickupcustomerdetails(
    String customerId,
    String token,
    String companyCode,
  ) async {
    String url =
        "https://be.syswash.net/api/syswash/customerdetails/${customerId}?area=null&acType=null&deliveryType=null&code=${companyCode}&search=undefined&cuscodesearch=undefined";
    Response response = await apiClient.invokeAPI(
      url,
      "GET",
      jsonEncode({}),
      token: token,
    );
    return CustomerDetailsModel.fromJson(jsonDecode(response.body));
  }

  Future<PickupOrderItemsModel> pickuporderitem(
    String pickupOrderId,
    String token,
    String companyCode,
  ) async {
    String url =
        "https://be.syswash.net/api/syswash/order/${pickupOrderId}?code=${companyCode}";
    Response response = await apiClient.invokeAPI(
      url,
      "GET",
      jsonEncode({}),
      token: token,
    );
    return PickupOrderItemsModel.fromJson(jsonDecode(response.body));
  }

  Future<PickupOrderItemsModel> addpickuporder(
    String pickupOrderId,
    String token,
    String companyCode,
  ) async {
    String url =
        "https://be.syswash.net/api/syswash/order/${pickupOrderId}?code=${companyCode}";
    Response response = await apiClient.invokeAPI(
      url,
      "POST",
      jsonEncode({}),
      token: token,
    );
    return PickupOrderItemsModel.fromJson(jsonDecode(response.body));
  }

  Future<void> uploadPickupDatas(
    String companyCode,
    String token,
    String notes,
    String pickupCustomerArea,
    String pickupCustomerCode,
    String pickupCustomerId,
    String pickupCustomerName,
    String pickupCustomerPhno,
    String pickupDate,
    String pickupDriverid,
    String pickupDrivername,
    String remarks,
  ) async {
    String url =
        "https://be.syswash.net/api/syswash/pickup?code=${companyCode}";
    body = {
      "notes": notes != '' ? notes : null,
      "pickupCustomerArea": pickupCustomerArea,
      "pickupCustomerCode": pickupCustomerCode,
      "pickupCustomerId": pickupCustomerId,
      "pickupCustomerName": pickupCustomerName,
      "pickupCustomerPhno": pickupCustomerPhno,
      "pickupDate": '2025-12-25',
      "pickupDriverid": pickupDriverid,
      "pickupDrivername": pickupDrivername,
      "remarks": remarks != '' ? remarks : null,
    };
    Response response = await apiClient.invokeAPI(
      url,
      "POST",
      jsonEncode(body),
      token: token,
    );
    if (response.statusCode == 200) {
      print('Upload successful: ${response.body}');
    } else {
      print('Upload failed: ${response.statusCode}');
    }
  }
}
