import 'dart:convert';
import 'package:http/http.dart' as http;

class GisQatarService {
  static const String _baseUrl =
      'https://services.gisqatar.org.qa/server/rest/services/'
      'Vector/QARS_wgs84/MapServer/0/query';

  /// Returns LatLng or null if not found
  static Future<Map<String, double>?> getLatLng({
    required String zone,
    required String street,
    required String building,
  }) async {
    final where =
        'zone_no=$zone AND street_no=$street AND building_no=$building';

    final uri = Uri.parse(_baseUrl).replace(queryParameters: {
      'where': where,
      'outFields': '*',
      'f': 'json',
    });

    final response = await http.get(uri);

    if (response.statusCode != 200) return null;

    final json = jsonDecode(response.body);
    final features = json['features'] as List?;

    if (features == null || features.isEmpty) return null;

    final geometry = features.first['geometry'];

    return {
      'lat': geometry['y'], // latitude
      'lng': geometry['x'], // longitude
    };
  }
}
