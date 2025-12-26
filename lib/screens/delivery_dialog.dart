import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:syswash/bloc/bloc/deliverystatus_bloc.dart';

class DeliveryDialog {
  static Future<bool?> show(
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
          Center(child: CircularProgressIndicator());
        } else if (state is DeliverySuccess) {
          
            Navigator.of(context, rootNavigator: true).pop(true);
          
        } else if (state is DeliveryError) {
          Navigator.of(context).popUntil((route) => route.isFirst);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
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
              final result = await _showPaymentOptions(context, payModes);
              if (result != null) {
                final selectedMethod = result['method'];
                final remark = result['remark'];
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
                      remark: remark ?? '',
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

              if (token != null && companyCode != null) {
                context.read<DeliverystatusBloc>().add(
                  FetchDeliveryStatusEvent(
                    companyCode: companyCode,
                    token: token,
                    deliveryassgnId: deliveryassgnId ?? 0,
                    paymentMode: '',
                    paymentstatus: '',
                    remark: '',
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
Future<Map<String, String>?> _showPaymentOptions(
  BuildContext context,
  Map<String, dynamic> payModes,
) async {
  String? selectedMethod;
  final TextEditingController remarkController = TextEditingController();

  final List<String> availableMethods = [];
  if (payModes['PaymodeCash'] == true) availableMethods.add('Cash');
  if (payModes['PaymodeBank'] == true) availableMethods.add('Bank');
  if (payModes['PaymodeCard'] == true) availableMethods.add('Card');
  if (payModes['PaymodeWallet'] == true) availableMethods.add('Wallet');

  return showDialog<Map<String, String>>(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
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
              children: [
                ...availableMethods.map(
                  (method) => CheckboxListTile(
                    title: Text(method),
                    value: selectedMethod == method,
                    activeColor: const Color(0xFF68188B),
                    onChanged: (value) {
                      setState(() {
                        selectedMethod = value == true ? method : null;
                      });
                    },
                  ),
                ),

                // 🔹 Remark only for Bank / Card
                if (selectedMethod == 'Bank' || selectedMethod == 'Card')
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: TextField(
                      controller: remarkController,
                      decoration: const InputDecoration(
                        labelText: 'Remark',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(null),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF68188B),
                ),
                onPressed:
                    selectedMethod == null
                        ? null
                        : () {
                          Navigator.of(context).pop({
                            'method': selectedMethod!,
                            'remark': remarkController.text,
                          });
                          // Navigator.pop(context, selectedMethod);
                        },
                child: const Text(
                  'Confirm',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        },
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
