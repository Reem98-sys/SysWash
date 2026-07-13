import 'dart:convert';

int extractInvoiceId(String qrData) {
  qrData = qrData.trim();

  // Case 1: plain number
  if (RegExp(r'^\d+$').hasMatch(qrData)) {
    return int.parse(qrData);
  }

  // Case 2: URL
  if (qrData.startsWith('http')) {
    qrData = qrData.split('/').last.split('#').first;
  }

  // Case 3: Base64
  final decoded = utf8.decode(
    base64.decode(base64.normalize(qrData)),
  );

  return int.parse(decoded);
}