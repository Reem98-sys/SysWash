import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:syswash/helper/extractid.dart';
import 'package:syswash/screens/invoicedetails.dart';

class QrScannerPage extends StatefulWidget {
  const QrScannerPage({super.key});

  @override
  State<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {
  final MobileScannerController controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    returnImage: false,
  );

  bool scanned = false;

  // Fixed the method syntax here
  void _onDetect(BarcodeCapture capture) {
    if (scanned) return;

    final barcode = capture.barcodes.firstOrNull;
    if (barcode == null) return;

    final qrData = capture.barcodes.first.rawValue;
    print("RAW QR DATA: $qrData");
    if (qrData == null) return;

    setState(() {
      scanned = true;
    });

    final invoiceId = extractInvoiceId(qrData);
    print("Invoice ID: $invoiceId");
    // Stop the camera before navigating away to save resources
    controller.stop();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => InvoiceDetailsPage(
          pickupOrderId: invoiceId,
        ),
      ),
    ).then((_) {
      // Reset state and restart camera when returning to this page
      setState(() {
        scanned = false;
      });
      controller.start();
    });
  }

  @override
  void dispose() {
    controller.dispose(); // Always dispose controllers to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan QR Code')),
      body: MobileScanner(
        controller: controller,
        onDetect: _onDetect, // Pass the consolidated method here
      ),
    );
  }
}