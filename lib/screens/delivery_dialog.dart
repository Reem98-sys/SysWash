import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:syswash/bloc/bloc/deliverystatus_bloc.dart';

class DeliveryDialog {
  static Future<void> show(
    BuildContext context, {
    required Map<String, dynamic> payModes,
    required int? deliveryassgnId,
  }) async {
    //  Capture parent Bloc before dialog is shown
    final parentBloc = BlocProvider.of<DeliverystatusBloc>(context);

    return showDialog(
      context: context,
      builder: (dialogContext) {
        //  Provide the same Bloc instance to the dialog
        return BlocProvider.value(
          value: parentBloc,
          child: _DeliveryDialogContent(
            payModes: payModes,
            deliveryassgnId: deliveryassgnId,
          ),
        );
      },
    );
  }
}

class _DeliveryDialogContent extends StatelessWidget {
  final Map<String, dynamic> payModes;
  final int? deliveryassgnId;

  const _DeliveryDialogContent({
    required this.payModes,
    required this.deliveryassgnId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeliverystatusBloc, DeliverystatusState>(
      listener: (context, state) {
        if (state is DeliveryLoading) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Updating delivery...')));
        } else if (state is DeliverySuccess) {
          Navigator.pop(context, true);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Updated Successfully'),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is DeliveryError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Something went wrong'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text(
          'Select Option',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF68188B),
            fontSize: 18,
          ),
        ),
        content: const Text(
          'Choose payment status',
          style: TextStyle(fontSize: 14),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.r),
              ),
            ),
            onPressed: () async {
              final selectedMethod = await _showPaymentOptions(
                context,
                payModes,
              );
              if (selectedMethod != null) {

                // Now call API here
                const storage = FlutterSecureStorage();
                final companyCode = await storage.read(key: 'company_Code');
                final token = await storage.read(key: 'access_Token');
        
                if (token != null && companyCode != null) {
                  final deliverystatusBloc = context.read<DeliverystatusBloc>();
                  deliverystatusBloc.add(
                    FetchDeliveryStatusEvent(
                      companyCode: companyCode,
                      token: token,
                      deliveryassgnId: deliveryassgnId ?? 0,
                      paymentMode: selectedMethod,
                      paymentstatus: 'Collected',
                    ),
                  );
                }
              }
            },
            child: const Text('Pay Now', style: TextStyle(color: Colors.white)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF68188B),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            onPressed: () async {
              final storage = const FlutterSecureStorage();
              final companyCode = await storage.read(key: 'company_Code');
              final token = await storage.read(key: 'access_Token');
              print(' companyCode: $companyCode');
              print(' token: $token');

              if (token != null && companyCode != null) {
                context.read<DeliverystatusBloc>().add(
                  FetchDeliveryStatusEvent(
                    companyCode: companyCode,
                    token: token,
                    deliveryassgnId: deliveryassgnId ?? 0,
                    paymentMode: '',
                    paymentstatus: '',
                  ),
                );
              }
            },
            child: const Text(
              'Delivery Unpaid',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

//  Secondary dialog for payment options
Future<String?> _showPaymentOptions(
  BuildContext context,
  Map<String, dynamic> payModes,
) async {
  final List<String> availableMethods = [];
  if (payModes['PaymodeCash'] == true) availableMethods.add('Cash');
  if (payModes['PaymodeBank'] == true) availableMethods.add('Bank');
  if (payModes['PaymodeCard'] == true) availableMethods.add('Card');
  if (payModes['PaymodeWallet'] == true) availableMethods.add('Wallet');
  if (payModes['PaymodeVoid'] == true) availableMethods.add('Void');

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text(
          'Select Payment Method',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF68188B),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children:
              availableMethods.isNotEmpty
                  ? availableMethods
                      .map((method) => _paymentOption(context, method))
                      .toList()
                  : [
                    const Text(
                      'No payment methods available',
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
        ),
      );
    },
  );
}

//  Helper widget for payment items
Widget _paymentOption(BuildContext context, String method) {
  return ListTile(
    leading: const Icon(Icons.payment, color: Color(0xFF68188B)),
    title: Text(method, style: const TextStyle(fontSize: 16)),
    onTap: () => Navigator.of(context).pop(method),
  );
}
