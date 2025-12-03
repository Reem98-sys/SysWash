import 'package:url_launcher/url_launcher.dart';

Future<void> openRoute(String address) async {
  if (address.trim().isEmpty) {
    throw Exception('Address is empty');
  }

  final encodedAddress = Uri.encodeComponent(address);

  //  Define URLs
  final googleMapsApp = Uri.parse('geo:0,0?q=$encodedAddress'); // opens Google Maps app if installed
  final googleMapsWeb = Uri.parse('https://www.google.com/maps/search/?api=1&query=$encodedAddress');
  final wazeApp = Uri.parse('waze://?q=$encodedAddress&navigate=yes'); // deep link to Waze app
  final appleMaps = Uri.parse('http://maps.apple.com/?q=$encodedAddress');
  try {
    if (await canLaunchUrl(wazeApp)) {
      await launchUrl(wazeApp, mode: LaunchMode.externalApplication);
    }

    else if (await canLaunchUrl(googleMapsApp)) {
      await launchUrl(googleMapsApp, mode: LaunchMode.externalApplication);
    } else if (await canLaunchUrl(appleMaps)) {
      await launchUrl(appleMaps, mode: LaunchMode.externalApplication);
    }
    // Fallback to browser
    else {
      await launchUrl(googleMapsWeb, mode: LaunchMode.externalApplication);
    }
  } catch (e) {
    print('❌ Failed to launch map: $e');
  }
}
