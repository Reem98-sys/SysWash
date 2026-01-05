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
import 'package:syswash/model/profileModel.dart';
import 'package:syswash/model/serviceDetails.dart';
import 'package:syswash/model/settingsModel.dart';
import 'package:syswash/model/totalOrder.dart';

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

  Future<List<ServiceDetailsModel>> servicedetail(
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

  Future<SettingsModel> settingsData(String companyCode, String token) async {
    String url =
        "https://be.syswash.net/api/syswash/settings/1?code=${companyCode}";
    Response response = await apiClient.invokeAPI(
      url,
      "GET",
      jsonEncode({}),
      token: token,
    );
    return SettingsModel.fromJson(jsonDecode(response.body));
  }

  Future<void> addnewOrderItem(
    String token,
    String companyCode,
    String pickupassgnId,
    String pickupTime,
    int quantity,
    double subTotal,
    double discount,
    double totalAmount,
    double paidAmount,
    double balance,
    List<Map<String, dynamic>> clothData,
  ) async {
    String url =
        "https://be.syswash.net/api/syswash/pickuporder?code=${companyCode}";
    body = {
      'pickupassgn_id': pickupassgnId,
      'pickuporderTime': pickupTime,
      'quantity': quantity,
      'subTotal': subTotal,
      'discount': discount,
      'totalAmount': totalAmount,
      'paidAmount': paidAmount,
      'balance': balance,
      'deliveryType': "PICKUP & DELIVERY",
      'accountType': "MobileApp",
      'clothData': clothData,
    };
    Response response = await apiClient.invokeAPI(
      url,
      "POST",
      jsonEncode(body),
      token: token,
    );
    final data = jsonDecode(response.body);
    return data['status'];
  }

  Future<String?> pickupstatus(
    int pickupAssignId,
    String token,
    String companyCode,
    String status
  ) async {
    String url =
        "https://be.syswash.net/api/syswash/pickupstatus/${pickupAssignId}?code=${companyCode}";
    body = {"pickupstatus": status};
    Response response = await apiClient.invokeAPI(
      url,
      "PUT",
      jsonEncode(body),
      token: token,
    );
    final data = jsonDecode(response.body);
    return data['status'];
  }

  Future<int?> addpickuporder(
    String pickupOrderId,
    String token,
    String companyCode,
    String balance,
    List<Map<String, dynamic>> clothData,
    int customerDiscount,
    int discount,
    String lastModifiedTime,
    String lastModifieddate,
    int paidAmount,
    int quantity,
    String subTotal,
    String totalAmount,
    String userName,
  ) async {
    String url =
        "https://be.syswash.net/api/syswash/order/${pickupOrderId}?code=${companyCode}";
    body = {
      'balance': balance,
      'clothData': clothData,
      'customerDiscount': customerDiscount,
      'discount': discount,
      'lastModifiedTime': lastModifiedTime,
      'lastModifieddate': lastModifieddate,
      'paidAmount': paidAmount,
      'quantity': quantity,
      'subTotal': subTotal,
      'totalAmount': totalAmount,
      'userName': userName,
    };
    Response response = await apiClient.invokeAPI(
      url,
      "PUT",
      jsonEncode(body),
      token: token,
    );
    final data = jsonDecode(response.body);
    return data['status'];
  }

  Future<bool> uploadPickupDatas(
    String companyCode,
    String token,
    String notes,
    String pickupCustomerArea,
    String pickupCustomerCode,
    String pickupCustomerId,
    String pickupCustomerName,
    String pickupCustomerPhno,
    String pickupDate,
    String pickuptime,
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
      "pickupDate": pickupDate,
      "pickuptime": pickuptime,
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
      return true;
    } else {
      return false;
    }
  }

  Future<ProfileModel> profileDetail(
    String userId,
    String companyCode,
    String token,
  ) async {
    String url =
        "https://be.syswash.net/api/syswash/driverdetails/${userId}?code=${companyCode}";
    Response response = await apiClient.invokeAPI(
      url,
      "GET",
      jsonEncode({}),
      token: token,
    );
    return ProfileModel.fromJson(jsonDecode(response.body));
  }

  Future<String> deliverypaymentstatus(
    String companyCode,
    String token,
    int deliveryassgnId,
    String? paymentMode,
    String? paymentstatus,
    String? remark
  ) async {
    final now = DateTime.now();
    final formattedDateTime =
        "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} "
        "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
    String url =
        "https://be.syswash.net/api/syswash/deliverystatus/${deliveryassgnId}?code=${companyCode}";
    if (paymentMode == '' || paymentstatus == '') {
      body = {
        "deliveredDateTime": formattedDateTime.toString(),
        "deliveryassgnId": deliveryassgnId,
        "status": "Delivered",
      };
    } else {
      if (remark == '') {
        body = {
        "deliveredDateTime": formattedDateTime.toString(),
        "deliveryassgnId": deliveryassgnId,
        "status": "Delivered",
        "paymentstatus": paymentstatus,
        "paymentMode": paymentMode,
        };
      }
      else {
        body = {
        "deliveredDateTime": formattedDateTime.toString(),
        "deliveryassgnId": deliveryassgnId,
        "status": "Delivered",
        "paymentstatus": paymentstatus,
        "paymentMode": paymentMode,
        "paymentremarks": remark
        };
      }
      
    }

    Response response = await apiClient.invokeAPI(
      url,
      "PUT",
      jsonEncode(body),
      token: token,
    );
    final Map<String, dynamic> data = jsonDecode(response.body);

    if (data['status'] != 200 && data['status'] != true && data['status'] != 1) {
      throw Exception(
      data['Message'] ?? data['message'] ?? 'Delivery failed',
      );
    }

    return data['Message'] ?? 'Updated Successfully';
  }

  Future<String> updateProfile(
    String userID,
    String companyCode,
    String token,
    String name,
    String email,
    String phone,
    String password
  ) async {
   
    String url =
        "https://be.syswash.net/api/syswash/driverdetails/${userID}?code=${companyCode}";
    body = {
      "name": name, 
      "email": email, 
      "mobile": phone,
      "password":password
      };
    Response response = await apiClient.invokeAPI(
      url,
      "PUT",
      jsonEncode(body),
      token: token,
    );
    if (response.statusCode == 200) {
      return 'Profile updated successfully';
    } else {
      return 'Unable to update';
    }
  }

  Future<String> updatepassword(
    String userID,
    String companyCode,
    String token,
    String currentpass,
    String newPass,
    String newconfpass,
  ) async {
   
    String url =
        "https://be.syswash.net/api/syswash/driverchangepass/${userID}?code=${companyCode}";
    body = {
      "currentPass": currentpass, 
      "newPass": newPass, 
      "newConfPass": newconfpass,
      };
    Response response = await apiClient.invokeAPI(
      url,
      "PUT",
      jsonEncode(body),
      token: token,
    );
    if (response.statusCode == 200) {
      return 'Profile updated successfully';
    } else {
      return 'Unable to update';
    }
  }
  Future<String> adddevicetoken(
    String userID,
    String companyCode,
    String token,
    String devicetoken,
  ) async {
   
    String url =
        "https://be.syswash.net/api/syswash/driverdevicetoken?code=${companyCode}";
    body = {
      "driver_id": userID, 
      "device_token": devicetoken
      };
    Response response = await apiClient.invokeAPI(
      url,
      "POST",
      jsonEncode(body),
      token: token,
    );
    if (response.statusCode == 200) {
      return 'Device token registered successfully';
    } else {
      return '';
    }
  }

  Future<String> forgotpass(
    String companyCode,
    String email,
  ) async {
   
    String url =
        "https://be.syswash.net/api/syswash/driverforgetpassword?code=${companyCode}";
    body = {
      "email": email,
      };
    Response response = await apiClient.invokeAPI(
      url,
      "POST",
      jsonEncode(body)
    );
    
      return jsonDecode(response.body)["message"];
    
  }
  Future<String> resetpass(
    String companyCode,
    String email,
    String newpass,
    int otp
  ) async {
   
    String url =
        "https://be.syswash.net/api/syswash/driverresetpassword?code=${companyCode}";
    body = {
      "email": email,
      "new_password": newpass,
      "otp": otp.toString()
      };
    Response response = await apiClient.invokeAPI(
      url,
      "POST",
      jsonEncode(body)
    );
    final decoded = jsonDecode(response.body);

  if (response.statusCode == 200) {
    return decoded["message"].toString();
  } else {
    return decoded["error"]?.toString() ?? "Something went wrong";
  }
      
    
  }
}
