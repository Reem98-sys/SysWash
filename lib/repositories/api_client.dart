import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:syswash/repositories/api_exception.dart';




class ApiClient {
  Future<bool> _refreshToken() async {
  final refreshToken = await TokenStorage.refreshToken();
  if (refreshToken == null || refreshToken.isEmpty) return false;
  log('Refreshing token...');
  final response = await post(
    Uri.parse('https://be.syswash.net/api/token/refresh/'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'refresh': refreshToken}),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    await TokenStorage.saveTokens(
      accessToken: data['access'], refreshToken: data['refresh'],
    );
    log('Token refreshed successfully');
    return true;
  }
  log('Refresh token failed: ${response.body}');
  return false;
}

  Future<Response> invokeAPI(String path, String method, Object? body,{String? token, bool retry = true}) async {
    Map<String, String> headerParams = {};
    Response response;
    final accessToken = await TokenStorage.accessToken();
    String url = path;
    print(url);

    final nullableHeaderParams = (headerParams.isEmpty) ? null : headerParams;
    print(body);
    // Define common headers
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (accessToken != null) 'Authorization': 'Bearer $accessToken',
    };
  
  
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
  

    log('API [$method] $path => ${response.statusCode}');

//  ACCESS TOKEN EXPIRED
  if ((response.statusCode == 401 || response.statusCode == 403) && retry) {
    final refreshed = await _refreshToken();

    if (refreshed) {
      return invokeAPI(path, method, body, retry: false);
    } else {
      await TokenStorage.clear();
      throw ApiException('Session expired', 401);
    }
  }
  if (response.statusCode >= 400) {
      throw ApiException(response.body, response.statusCode);
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
/// ============================
/// TOKEN STORAGE
/// ============================
class TokenStorage {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();
  static Future<String?> accessToken() =>
      _storage.read(key: 'access_Token');

  static Future<String?> refreshToken() =>
      _storage.read(key: 'refresh_token');

  static Future<void> saveTokens({
    required String accessToken,
    required String refreshToken
  }) async {
    await _storage.write(key: 'access_Token', value: accessToken);
    await _storage.write(key: 'refresh_token', value: refreshToken);
  }
  static Future<void> clear() async {
    await _storage.deleteAll();
  }
  
}