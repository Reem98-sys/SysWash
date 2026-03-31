import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  static const String _refreshUrl = 'https://be.syswash.net/api/token/refresh/';

  static Future<String?> refreshAccessToken(String refreshToken) async {
    try {
      final response = await http.post(
        Uri.parse(_refreshUrl),
        body: {
          'refresh': refreshToken, // Most APIs expect the key 'refresh'
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['access']; // Return the new access token
      }
      return null; // Refresh token itself is expired or invalid
    } catch (e) {
      return null;
    }
  }
}