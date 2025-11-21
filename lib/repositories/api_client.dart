import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:syswash/repositories/api_exception.dart';




class ApiClient {
  Future<Response> invokeAPI(String path, String method, Object? body,{String? token}) async {
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