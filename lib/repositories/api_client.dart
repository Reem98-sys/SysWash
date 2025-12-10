import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:syswash/repositories/api_exception.dart';




class ApiClient {
  Future<bool> _refreshToken() async {
  final refreshToken = await TokenStorage.refreshToken();
  if (refreshToken == null) return false;

  final response = await post(
    Uri.parse('https://be.syswash.net/api/syswash/token/refresh/'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'refresh': refreshToken}),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    await TokenStorage.saveTokens(
      accessToken: data['access_token'],
    );
    return true;
  }

  return false;
}

  Future<Response> invokeAPI(String path, String method, Object? body,{String? token, bool retry = true}) async {
    Map<String, String> headerParams = {};
    Response response;

    String url = path;
    print(url);

    final nullableHeaderParams = (headerParams.isEmpty) ? null : headerParams;
    print(body);
    // Define common headers
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    
    // Add Bearer token if available
  if (token != null && token.isNotEmpty) {
    headers['Authorization'] = 'Bearer $token';
  }
    switch (method) {
      case "POST":
        response = await post(Uri.parse(url),
            headers: headers,
            body: body);
        break;
      case "PUT":
        response = await put(Uri.parse(url),
            headers: headers,
            body: body);
        break;
      case "DELETE":
        response = await delete(Uri.parse(url), headers: {}, body: body);
        break;
      case "POST_":
        response = await post(
          Uri.parse(url),
          headers: headers,
          body: body,
        );
        break;
      case "GET_":
        response = await post(
          Uri.parse(url),
          headers: {},
          body: body,
        );
        break;
      case "GET":
        response = await get(
          Uri.parse(url),
          headers: headers,
        );
print(headers);
        break;
      case "PATCH":
        response = await patch(
          Uri.parse(url),
          headers: headers,
          body: body,
        );
        break;
      case "PATCH1":
        response = await patch(
          Uri.parse(url),
          headers: {},
          body: body,
        );
        break;
      default:
        response = await get(Uri.parse(url), headers: headers);
    }

//  ACCESS TOKEN EXPIRED
  if (response.statusCode == 401 && retry) {
    final refreshed = await _refreshToken();

    if (refreshed) {
      return invokeAPI(path, method, body, retry: false);
    } else {
      await TokenStorage.clear();
      throw ApiException('Session expired', 401);
    }
  }
    print('status of $path =>' + (response.statusCode).toString());
    print(response.body);
    if (response.statusCode >= 400) {
      log(path +
          ' : ' +
          response.statusCode.toString() +
          ' : ' +
          response.body);

      throw ApiException(_decodeBodyBytes(response), response.statusCode);
    }
    return response;
  }

  String _decodeBodyBytes(Response response) {
    var contentType = response.headers['content-type'];
    if (contentType != null && contentType.contains("application/json")) {
      return jsonDecode(response.body)['message'];
    } else {
      return response.body;
    }
  }
}

class TokenStorage {
  static const _storage = FlutterSecureStorage();

  static Future<String?> accessToken() =>
      _storage.read(key: 'access_Token');

  static Future<String?> refreshToken() =>
      _storage.read(key: 'refresh_token');

  static Future<void> saveTokens({
    required String accessToken,
  }) async {
    await _storage.write(key: 'access_Token', value: accessToken);
  }

  static Future<void> clear() async {
    await _storage.deleteAll();
  }
}