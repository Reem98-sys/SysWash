import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:syswash/bloc/bloc/qrgetdata_bloc.dart';
import 'package:syswash/bloc/bloc/qrputdata_bloc.dart';
import 'package:syswash/helper/gis_qatar_service.dart';
import 'package:syswash/screens/bottomnav.dart';
import 'package:syswash/screens/mapping.dart';

class InvoiceDetailsPage extends StatefulWidget {
  final int? pickupOrderId;

  const InvoiceDetailsPage({super.key, this.pickupOrderId});

  @override
  State<InvoiceDetailsPage> createState() => _InvoiceDetailsPageState();
}

class _InvoiceDetailsPageState extends State<InvoiceDetailsPage> {
  final storage = const FlutterSecureStorage();
  bool showDetails = false;
  String? companyCode;
  String? token;
  String? userId;
  String? username;
  @override
  void initState() {
    super.initState();
    _loadDataAndFetchEvent();
  }

  Future<void> _loadDataAndFetchEvent() async {
  companyCode = await storage.read(key: 'company_Code');
  token = await storage.read(key: 'access_Token');
  userId = await storage.read(key: 'login_id');
  username = await storage.read(key: 'user_name');

  if (!mounted) return;

  context.read<QrgetdataBloc>().add(
    FetchQrgetdataEvent(
      pickupOrderId: widget.pickupOrderId?.toString() ?? '',
      token: token ?? '',
      companyCode: companyCode ?? '',
    ),
  );

  setState(() {});
}

  String buildFullAddress({
    String? hotel,
    String? area,
    String? zone,
    String? street,
    String? villano,
  }) {
    // Collect only non-empty values
    String address = '';
    if (hotel != null && hotel.trim().isNotEmpty) address += 'Hotel $hotel, ';
    if (villano != null && villano.trim().isNotEmpty)
      address += 'Villa  $villano, ';
    if (street != null && street.trim().isNotEmpty)
      address += 'Street $street, ';
    if (zone != null && zone.trim().isNotEmpty) address += 'Zone $zone, ';
    if (area != null && area.trim().isNotEmpty) address += '$area, ';
    address += 'Qatar';

    return address;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          "Invoice Details",
          style: TextStyle(fontFamily: 'DM Sans', fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: BlocListener<QrputdataBloc, QrputdataState>(
            listener: (context, state) {
              if (state is QrputdataBlocLoaded) {
                ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.green,
                  ),
                );
                Navigator.push(context, MaterialPageRoute(builder: (context) => Bottomnav()));
              }

              if (state is QrputdataBlocError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Unable to Confirm'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: BlocBuilder<QrgetdataBloc, QrgetdataState>(
              builder: (context, state) {
                if (state is QrgetdataBlocLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is QrgetdataBlocError) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Failed to load data')),
                    );
                    Navigator.pop(context);
                  });
                  return const SizedBox.shrink();
                }

                // Check if your state contains the loaded dataset
                // Note: Replace "QrgetdataBlocLoaded" with your exact success state class name if it differs!
                dynamic data;
                final custdata;
                if (state is QrgetdataBlocLoaded) {
                  // If your BLoC packages the model within a property variable name:
                  data = state.pickupOrderItemsModel;
                  custdata = state.customerDetailsModel;
                  print(state.customerDetailsModel);
                  print("Customer model = ${state.customerDetailsModel}");
                  print("Customer name = ${state.customerDetailsModel?.name}");
                  print("Area = ${state.customerDetailsModel?.area}");
                  List<dynamic> clothData = data.clothData ?? [];
                  String status = data.bill ?? 'Pending';

                  final List<Map<String, String?>> gridItems = [
                    {'label': 'Area', 'value': custdata.area ?? ''},
                    {'label': 'Zone', 'value': custdata.zone ?? ''},
                    {'label': 'Street No', 'value': custdata.streetNo ?? ''},
                    {'label': 'Villa No', 'value': custdata.villaNumber ?? ''},
                    {'label': 'Hotel', 'value': custdata.hotel ?? ''},
                    {'label': 'Room No', 'value': custdata.roomNo ?? ''},
                    {'label': 'Fragrance', 'value': custdata.fragrance ?? ''},
                    {'label': 'Reference No', 'value': custdata.refNo ?? ''},
                    {
                      'label': 'Order No',
                      'value':
                          data.orderId?.toString() ??
                          widget.pickupOrderId?.toString() ??
                          '',
                    },
                  ];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- Main Customer Summary Card ---
                      Container(
                        width: 384.w,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (data.orderId != null)
                                      Text(
                                        '# ${data.orderId}',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.sp,
                                          fontFamily: 'DM Sans',
                                        ),
                                      ),
                                    Text(
                                      '${data.customerName ?? ''} [${data.customerCode ?? ''}]',
                                      style: TextStyle(
                                        color: const Color(0xFF0A0A0A),
                                        fontSize: 16.sp,
                                        fontFamily: 'DM Sans',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Discount: ',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12.sp,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          data.customerDiscount?.toString() ??
                                              '0.000',
                                          style: TextStyle(
                                            color: const Color(0xFF68188B),
                                            fontSize: 12.sp,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5.h),
                                    Row(
                                      children: [
                                        Icon(Icons.phone_in_talk, size: 18.sp),
                                        SizedBox(width: 4.w),
                                        Text(
                                          data.customerPhno ?? '',
                                          style: TextStyle(
                                            color: const Color(0xFF0A0A0A),
                                            fontSize: 14.sp,
                                            fontFamily: 'DM Sans',
                                          ),
                                        ),
                                        SizedBox(width: 10.w),
                                        Icon(
                                          Icons.location_on_sharp,
                                          size: 18.sp,
                                        ),
                                        SizedBox(width: 4.w),
                                        Expanded(
                                          child: Text(
                                            data.customerAddress?.toString() ??
                                                '',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12.sp,
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  // Text(
                                  //   status.toUpperCase(),
                                  //   style: TextStyle(
                                  //     color:
                                  //         status.toLowerCase() == 'pending'
                                  //             ? Colors.orange
                                  //             : Colors.green,
                                  //     fontSize: 16.sp,
                                  //     fontFamily: 'DM Sans',
                                  //     fontWeight: FontWeight.bold,
                                  //   ),
                                  // ),
                                  SizedBox(height: 12.h),
                                  GestureDetector(
                                    onTap: () async {
                                      final zone = custdata.zone?.toString();
                                      final street =
                                          custdata.streetNo?.toString();
                                      final villano =
                                          custdata.villaNumber?.toString();
                                      if (zone == null ||
                                          street == null ||
                                          villano == null) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Address details incomplete',
                                            ),
                                          ),
                                        );
                                        return;
                                      }
                                      final coords =
                                          await GisQatarService.getLatLng(
                                            zone: zone,
                                            street: street,
                                            building: villano,
                                          );
                                      if (coords == null) {
                                        final fullAddress = buildFullAddress(
                                          hotel: custdata.hotel,
                                          area: custdata.area,
                                          zone: custdata.zone,
                                          street: custdata.streetNo,
                                          villano: custdata.villaNumber,
                                        );
                                        if (fullAddress.isNotEmpty) {
                                          openRoute(fullAddress);
                                        } else {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Address not available',
                                              ),
                                            ),
                                          );
                                        }
                                      } else {
                                        await openRouteLatLng(
                                          coords['lat']!,
                                          coords['lng']!,
                                        );
                                      }
                                    },
                                    child: Container(
                                      width: 100.w,
                                      height: 30.h,
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFF68188B),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            3,
                                          ),
                                        ),
                                        shadows: [
                                          BoxShadow(
                                            color: Color(0x3F000000),
                                            blurRadius: 4,
                                            offset: Offset(0, 4),
                                            spreadRadius: 0,
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Route',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.sp,
                                            fontFamily: 'DM Sans',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        showDetails = !showDetails;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          showDetails
                                              ? 'Close Details'
                                              : 'View Details',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: const Color(0xFF68188B),
                                            fontSize: 12.sp,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Icon(
                                          showDetails
                                              ? Icons.keyboard_arrow_up_sharp
                                              : Icons.keyboard_arrow_down_sharp,
                                          color: const Color(0xFF68188B),
                                          size: 22.sp,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),

                      // --- Expandable Grid Details Table ---
                      AnimatedCrossFade(
                        firstChild: const SizedBox.shrink(),
                        secondChild: Container(
                          width: 384.w,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Table(
                              columnWidths: const {
                                0: FlexColumnWidth(1),
                                1: FlexColumnWidth(1),
                                2: FlexColumnWidth(1),
                              },
                              children: buildDetailsTableRows(gridItems),
                            ),
                          ),
                        ),
                        crossFadeState:
                            showDetails
                                ? CrossFadeState.showSecond
                                : CrossFadeState.showFirst,
                        duration: const Duration(milliseconds: 300),
                      ),
                      SizedBox(height: 21.h),

                      Text(
                        'Delivery Items',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 17.h),

                      // --- Cloth Items List View ---
                      // --- Cloth Items List View ---
                      Expanded(
                        child:
                            clothData.isEmpty
                                ? const Center(
                                  child: Text("No itemized laundry rows found"),
                                )
                                : ListView.builder(
                                  itemCount: clothData.length,
                                  itemBuilder: (context, index) {
                                    final item =
                                        clothData[index]; // This is an instance of ClothData object
                                    return Padding(
                                      padding: EdgeInsets.only(bottom: 10.h),
                                      child: Container(
                                        width: 364.w,
                                        decoration: ShapeDecoration(
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              8.r,
                                            ),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(6.r),
                                                child: Image.network(
                                                  item.clothImg?.toString() ??
                                                      '', // Fixed: Use dot notation
                                                  width: 46.w,
                                                  height: 44.h,
                                                  fit: BoxFit.cover,
                                                  loadingBuilder: (
                                                    context,
                                                    child,
                                                    loadingProgress,
                                                  ) {
                                                    if (loadingProgress == null)
                                                      return child;
                                                    return const Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    );
                                                  },
                                                  errorBuilder: (
                                                    context,
                                                    error,
                                                    stackTrace,
                                                  ) {
                                                    return const Icon(
                                                      Icons.broken_image,
                                                      color: Colors.grey,
                                                      size: 40,
                                                    );
                                                  },
                                                ),
                                              ),
                                              SizedBox(width: 10.w),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    item.clothName
                                                            ?.toString() ??
                                                        'Linen/Cloth Item', // Fixed: Use dot notation
                                                    style: TextStyle(
                                                      color: const Color(
                                                        0xFF150B3D,
                                                      ),
                                                      fontSize: 16.sp,
                                                      fontFamily: 'DM Sans',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                  Text(
                                                    '${item.qnty ?? 0} QTY', // Fixed: Use dot notation
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14.sp,
                                                      fontFamily: 'DM Sans',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Spacer(),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    item.service?.toString() ??
                                                        'DryClean', // Fixed: Use dot notation
                                                    style: TextStyle(
                                                      color: const Color(
                                                        0xFF150B3D,
                                                      ),
                                                      fontSize: 16.sp,
                                                      fontFamily: 'DM Sans',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                  Text(
                                                    item.billing?.toString() ??
                                                        '0.000', // Fixed: Use dot notation
                                                    style: TextStyle(
                                                      color: const Color(
                                                        0xFF68188B,
                                                      ),
                                                      fontSize: 14.sp,
                                                      fontFamily: 'DM Sans',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                      ),
                    ],
                  );
                } else {
                  return const Center(
                    child: Text("Waiting for order details..."),
                  );
                }

                // if (data == null) {
                //     return const Center(child: Text("No order details found"));
                //   }

                // --- Extraction directly mapping to your flat API JSON response ---
              },
            ),
          ),
        ),
      ),

      // --- Bottom Summary Bar ---
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          top: false,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: BlocBuilder<QrgetdataBloc, QrgetdataState>(
              builder: (context, state) {
                if (state is QrgetdataBlocLoaded &&
                    state.pickupOrderItemsModel != null) {
                  final data = state.pickupOrderItemsModel;
                  num quantity = data.quantity ?? 0;
                  String totalAmount =
                      double.tryParse(
                        data.totalAmount?.toString() ?? '0',
                      )?.toStringAsFixed(2) ??
                      '0.00';

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Total Quantity: ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                quantity.toString(),
                                style: TextStyle(
                                  color: const Color(0xFF68188B),
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Total Amount: ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                totalAmount,
                                style: TextStyle(
                                  color: const Color(0xFF68188B),
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      if(data.status!.toLowerCase() == 'order ready')
                      ElevatedButton(
                        onPressed: () {
                          context.read<QrputdataBloc>().add(
                            FetchQrputdataEvent(
                              pickupOrderId: widget.pickupOrderId.toString(),
                              token: token ?? '',
                              companyCode: companyCode ?? '',
                              deliveryCustomerArea: data.customerAddress!,
                              deliveryCustomerCode: data.customerCode!,
                              deliveryCustomerId: data.customerId!,
                              deliveryCustomerName: data.customerName!,
                              deliveryCustomerPhno: data.customerPhno!,
                              deliveryDate: data.deliveryDate!,
                              deliveryDriverid: userId ?? '',
                              deliveryDrivername: username ?? '',
                              deliveryInvoiceNo:
                                  widget.pickupOrderId.toString(),
                              deliveryTime: data.deliveryTime ?? '',
                              orderReceiver: data.orderReceiver!,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF68188B),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.w,
                            vertical: 12.h,
                          ),
                        ),
                        child: Text(
                          'Confirm Order',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }

  List<TableRow> buildDetailsTableRows(List<Map<String, String?>> items) {
    List<TableRow> rows = [];
    for (var i = 0; i < items.length; i += 3) {
      rows.add(
        TableRow(
          children: [
            _buildGridCell(items[i]),
            if (i + 1 < items.length)
              _buildGridCell(items[i + 1])
            else
              const SizedBox(),
            if (i + 2 < items.length)
              _buildGridCell(items[i + 2])
            else
              const SizedBox(),
          ],
        ),
      );
    }
    return rows;
  }

  Widget _buildGridCell(Map<String, String?> item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item['label'] ?? '',
            style: TextStyle(
              fontSize: 11.sp,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            item['value'] ?? '',
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  void confirmOrder() {}
}
