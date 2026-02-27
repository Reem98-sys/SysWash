import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:syswash/bloc/bloc/pickupcustdetails_bloc.dart';
import 'package:syswash/bloc/bloc/servicedetails_bloc.dart';
import 'package:syswash/helper/gis_qatar_service.dart';
import 'package:syswash/helper/customerdetail_helper.dart';
import 'package:syswash/screens/add_item_dialog.dart';
import 'package:syswash/screens/mapping.dart';

class Pickupdetails extends StatefulWidget {
  final String customerId;
  final dynamic pickupOrderId;
  final int pickupAssignId;
  final String notes;
  final String remarks;
  const Pickupdetails({
    super.key,
    required this.customerId,
    required this.pickupOrderId,
    required this.pickupAssignId,
    required this.notes,
    required this.remarks,
  });

  @override
  State<Pickupdetails> createState() => _PickupdetailsState();
}

class _PickupdetailsState extends State<Pickupdetails> {
  bool showDetails = false;
  // late CustomerDetailsModel customerDetailsModel;
  String? companyCode;
  String? token;
  List<Map<String, dynamic>> _orderItemsList = [];
  int? totalItem = 0;
  int? totalquantity = 0;
  double totalAmount = 0.00;

  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _loadUserAndFetchData(); // run async function
  }

  int getGridCount(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  if (width < 360) return 2;   // very small phones
  if (width < 600) return 3;   // normal phones
  return 4;                   // tablets
}

  Future<void> _loadUserAndFetchData() async {
    final companyCode = await storage.read(key: 'company_Code');
    final token = await storage.read(key: 'access_Token');
    if (companyCode != null && token != null) {
      context.read<PickupcustdetailsBloc>().add(
        FetchFullPickupDetailsEvent(
          customerId: widget.customerId,
          pickupOrderId: widget.pickupOrderId,
          token: token,
          companyCode: companyCode,
        ),
      );
    } else {
      debugPrint('Missing token or companyCode in storage');
    }
  }

  Future<void> _openAddItemDialog(BuildContext context) async {
    final companyCode = await storage.read(key: 'company_Code');
    final token = await storage.read(key: 'access_Token');
    if (companyCode != null && token != null) {
      context.read<ServicedetailsBloc>().add(
        FetchServiceDetailsEvent(
          token: token ?? '',
          companyCode: companyCode ?? '',
        ),
      );

      final newItem = await showAddItemDialog(context, token, companyCode);

      //  If user pressed Save and returned data
      if (newItem != null) {
        setState(() {
          _orderItemsList.add(newItem);
        });
        _recalculateTotals();
      }
    } else {
      debugPrint('Missing token or companyCode in storage');
    }
  }

  void _recalculateTotals() {
    int qty = 0;
    double subtotal = 0.00;

    for (var item in _orderItemsList) {
      final price =
          double.tryParse(item['clothPrice']?.toString() ?? '0') ?? 0;
      final qnty =
          int.tryParse(item['qnty']?.toString() ?? '0') ?? 0;

      qty += qnty;
      subtotal += price * qnty;
    }

    setState(() {
      totalquantity = qty;
      totalItem = _orderItemsList.length;
      totalAmount = subtotal;
    });
  }

  Future<void> _handleNewItemTap(
    BuildContext context,
    double subtotal,
    double discount,
    double totalAmount,
    double totalDiscount,
    double vatAmount
  ) async {
    final companyCode = await storage.read(key: 'company_Code');
    final token = await storage.read(key: 'access_Token');
    if (token != null && companyCode != null) {
      context.read<PickupcustdetailsBloc>().add(
        FetchAddNewPickupEvent(
          token: token,
          companyCode: companyCode,
          pickupassgnId: widget.pickupAssignId.toString(),
          pickupTime: TimeOfDay.now().format(context),
          quantity: totalquantity ?? 0,
          subTotal: subtotal,
          discount: totalDiscount,
          totalAmount: totalAmount,
          paidAmount: 0.0,
          balance: totalAmount,
          clothData: _orderItemsList,
          vatValue: vatAmount
        ),
      );
    }
  }

  Future<void> _handleTap(
    BuildContext context,
    dynamic pickupOrderItems,
    double subtotal,
    double totalamt,
    double blnc,
    int totalDiscount,
    double vatAmount
  ) async {
    final companyCode = await storage.read(key: 'company_Code');
    final token = await storage.read(key: 'access_Token');
    if (token != null && companyCode != null) {
      context.read<PickupcustdetailsBloc>().add(
        FetchAddPickupOrderEvent(
          token: token,
          companyCode: companyCode,
          pickupOrderId: widget.pickupOrderId,
          balance: blnc.toString(),
          clothData: _orderItemsList,
          customerDiscount: pickupOrderItems.customerDiscount ?? 0,
          discount: totalDiscount,
          lastModifiedTime: TimeOfDay.now().format(context),
          lastModifieddate: DateTime.now().toIso8601String().split('T').first,
          paidAmount: double.parse(pickupOrderItems.paidAmount).toInt() ?? 0,
          quantity: totalquantity ?? 0,
          subTotal: subtotal.toString(),
          totalAmount: totalamt.toString(),
          userName: pickupOrderItems.customerName ?? '',
          vatValue: vatAmount
        ),
      );
    }
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
      if (villano != null && villano.trim().isNotEmpty) address += 'Villa  $villano, ';
      if (street != null && street.trim().isNotEmpty) address += 'Street $street, ';
      if (zone != null && zone.trim().isNotEmpty) address += 'Zone $zone, ';
      if (area != null && area.trim().isNotEmpty) address += '$area, ';
    address += 'Qatar';

    return address;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_rounded),
        ),
        title: Text(
          'Pickup Order',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22.sp,
            fontFamily: 'DM Sans',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      // bottomNavigationBar: Bottomnav(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: BlocConsumer<PickupcustdetailsBloc, PickupcustdetailsState>(
            listener: (context, state) async {
              if (state is PickupCustDetailsError) {
                Navigator.pop(context);
                print('❌ Bloc Error: ${state.message}');
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
              if (state is PickupCustDetailsLoaded) {
                //  Update local list when new data arrives
                _orderItemsList =
                    state.pickupOrderItemsModel.clothData?.map((cloth) {
                      return {
                        "arabicName": cloth.arabicName,
                        "billing": cloth.billing,
                        "clothImg": cloth.clothImg,
                        "clothName": cloth.clothName,
                        "clothPrice": cloth.clothPrice,
                        "priceId": cloth.priceId,
                        "qnty": cloth.qnty,
                        "service": cloth.service,
                        "unit": cloth.unit,
                      };
                    }).toList() ??
                    [];

                _recalculateTotals();
              }
              if (state is AddPickupOrderLoaded) {
                final companyCode = await storage.read(key: 'company_Code');
                final token = await storage.read(key: 'access_Token');

                if (token != null && companyCode != null) {
                  context.read<PickupcustdetailsBloc>().add(
                    FetchStatusPickupEvent(
                      pickupAssignId: widget.pickupAssignId,
                      token: token,
                      companyCode: companyCode,
                      status: 'Received'
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('❌ Missing token or company code'),
                    ),
                  );
                }
              }
              if (state is AddNewPickupOrderLoaded) {
                final companyCode = await storage.read(key: 'company_Code');
                final token = await storage.read(key: 'access_Token');

                if (token != null && companyCode != null) {
                  context.read<PickupcustdetailsBloc>().add(
                    FetchStatusPickupEvent(
                      pickupAssignId: widget.pickupAssignId,
                      token: token,
                      companyCode: companyCode,
                      status: 'Collected'
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('❌ Missing token or company code'),
                    ),
                  );
                }
              }

              if (state is StatusPickupLoaded) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Order picked up successfully'),
                    backgroundColor: Colors.green,
                  ),
                );
                Navigator.pop(context, true);
              }
            },
            builder: (context, state) {
              if (state is PickupCustDetailsLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is PickupCustDetailsLoaded) {
                final customerDetailsModel = state.customerDetailsModel;
                final pickupOrderItems = state.pickupOrderItemsModel;
                final settingsData = state.settingsModel;
                final gridItems = [
                  {'label': 'Area', 'value': customerDetailsModel.area},
                  {'label': 'Zone', 'value': customerDetailsModel.zone},
                  {'label': 'Street No', 'value': customerDetailsModel.streetNo},
                  {'label': 'Villa No', 'value': customerDetailsModel.villaNumber},
                  {'label': 'Hotel', 'value': customerDetailsModel.hotel},
                  {'label': 'Room No', 'value': customerDetailsModel.roomNo},
                  {'label': 'Fragrance', 'value': customerDetailsModel.fragrance},
                  {'label': 'Reference No', 'value': customerDetailsModel.refNo},
                  {'label': 'Note', 'value': widget.notes},
                  {'label': 'Remark', 'value': widget.remarks},
                  {'label': 'Order No', 'value': widget.pickupOrderId?.toString() ?? ''},
                  {'label': 'Pickup Id', 'value': widget.pickupAssignId.toString()},
                ];
                return Column(
                  children: [
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${customerDetailsModel.name} [${customerDetailsModel.cusCode}]',
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
                                        height: 1.17,
                                        letterSpacing: 0.20,
                                      ),
                                    ),
                                    Text(
                                      customerDetailsModel.discount.toString(),
                                      style: TextStyle(
                                        color: const Color(0xFF68188B),
                                        fontSize: 12.sp,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        height: 1.17,
                                        letterSpacing: 0.20,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.h),
                                Row(
                                  children: [
                                    Icon(Icons.phone_in_talk, size: 18.sp),
                                    Text(
                                      customerDetailsModel.mobile.toString(),
                                      style: TextStyle(
                                        color: const Color(0xFF0A0A0A),
                                        fontSize: 14.sp,
                                        fontFamily: 'DM Sans',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Icon(Icons.location_on_sharp, size: 18.sp),
                                    Text(
                                      customerDetailsModel.area.toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12.sp,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        height: 1.17,
                                        letterSpacing: 0.20,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Spacer(),
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    
                                      final zone = customerDetailsModel.zone?.toString();
                                      final street = customerDetailsModel.streetNo?.toString();
                                      final villano = customerDetailsModel.villaNumber?.toString();
                                    if (zone == null || street == null || villano == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Address details incomplete')),
                                    );
                                    return;
                                  }
                                  final coords = await GisQatarService.getLatLng(
                                    zone: zone,
                                    street: street,
                                    building: villano,
                                  );
                                  if (coords == null) {
                                    final fullAddress = buildFullAddress(
                                      hotel: customerDetailsModel.hotel,
                                      area:
                                          customerDetailsModel.area,
                                      zone:
                                          customerDetailsModel.zone,
                                      street:
                                          customerDetailsModel.streetNo,
                                      villano:
                                          customerDetailsModel.villaNumber,
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
                                  }
                                  else {
                                    await openRouteLatLng(coords['lat']!, coords['lng']!);
                                  }

                                  
                                  },
                                  child: Container(
                                    width: 100.w,
                                    height: 30.h,
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFF68188B),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(3),
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
                                          height: 1.17,
                                          letterSpacing: 0.20,
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
                    // Expandable details container
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
                          child: 
                             Table(
                            columnWidths: const {
                              0: FlexColumnWidth(1),
                              1: FlexColumnWidth(1),
                              2: FlexColumnWidth(1),
                            },
                            children: buildDetailsTableRows(gridItems),
                          )
                            
                            
                          
                        ),
                      ),
                      // secondChild: Container(
                      //   width: 384.w,
                      //   decoration: ShapeDecoration(
                      //     color: Colors.white,
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(10.r),
                      //     ),
                      //   ),
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(15.0),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Text(
                      //               'Area',
                      //               style: TextStyle(
                      //                 color: const Color(0xFFA9A5B8),
                      //                 fontSize: 14.sp,
                      //                 fontFamily: 'DM Sans',
                      //                 fontWeight: FontWeight.w500,
                      //                 height: 1.17,
                      //               ),
                      //             ),
                      //             Text(
                      //               customerDetailsModel.area.toString(),
                      //               style: TextStyle(
                      //                 color: Colors.black,
                      //                 fontSize: 12.sp,
                      //                 fontFamily: 'DM Sans',
                      //                 fontWeight: FontWeight.w500,
                      //                 height: 1.17,
                      //               ),
                      //             ),
                      //             SizedBox(height: 17.h),
                      //             Text(
                      //               'Villa No',
                      //               style: TextStyle(
                      //                 color: const Color(0xFFA9A5B8),
                      //                 fontSize: 14.sp,
                      //                 fontFamily: 'DM Sans',
                      //                 fontWeight: FontWeight.w500,
                      //                 height: 1.17,
                      //               ),
                      //             ),
                      //             Text(
                      //               customerDetailsModel.villaNumber.toString(),
                      //               style: TextStyle(
                      //                 color: Colors.black,
                      //                 fontSize: 12.sp,
                      //                 fontFamily: 'DM Sans',
                      //                 fontWeight: FontWeight.w500,
                      //                 height: 1.17,
                      //               ),
                      //             ),
                      //             SizedBox(height: 17.h),
                      //             Text(
                      //               'Fragrance',
                      //               style: TextStyle(
                      //                 color: const Color(0xFFA9A5B8),
                      //                 fontSize: 14.sp,
                      //                 fontFamily: 'DM Sans',
                      //                 fontWeight: FontWeight.w500,
                      //                 height: 1.17,
                      //               ),
                      //             ),
                      //             Text(
                      //               customerDetailsModel.fragrance.toString(),
                      //               style: TextStyle(
                      //                 color: Colors.black,
                      //                 fontSize: 12.sp,
                      //                 fontFamily: 'DM Sans',
                      //                 fontWeight: FontWeight.w500,
                      //                 height: 1.17,
                      //               ),
                      //             ),
                      //             SizedBox(height: 17.h),
                      //             Text(
                      //               'Remark',
                      //               style: TextStyle(
                      //                 color: const Color(0xFFA9A5B8),
                      //                 fontSize: 14.sp,
                      //                 fontFamily: 'DM Sans',
                      //                 fontWeight: FontWeight.w500,
                      //                 height: 1.17,
                      //               ),
                      //             ),
                      //             Text(
                      //               widget.remarks,
                      //               style: TextStyle(
                      //                 color: Colors.black,
                      //                 fontSize: 12.sp,
                      //                 fontFamily: 'DM Sans',
                      //                 fontWeight: FontWeight.w500,
                      //                 height: 1.17,
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //         Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Text(
                      //               'Zone',
                      //               style: TextStyle(
                      //                 color: const Color(0xFFA9A5B8),
                      //                 fontSize: 14.sp,
                      //                 fontFamily: 'DM Sans',
                      //                 fontWeight: FontWeight.w500,
                      //                 height: 1.17,
                      //               ),
                      //             ),
                      //             Text(
                      //               customerDetailsModel.zone.toString(),
                      //               style: TextStyle(
                      //                 color: Colors.black,
                      //                 fontSize: 12.sp,
                      //                 fontFamily: 'DM Sans',
                      //                 fontWeight: FontWeight.w500,
                      //                 height: 1.17,
                      //               ),
                      //             ),
                      //             SizedBox(height: 17.h),
                      //             Text(
                      //               'Hotel',
                      //               style: TextStyle(
                      //                 color: const Color(0xFFA9A5B8),
                      //                 fontSize: 14.sp,
                      //                 fontFamily: 'DM Sans',
                      //                 fontWeight: FontWeight.w500,
                      //                 height: 1.17,
                      //               ),
                      //             ),
                      //             Text(
                      //               customerDetailsModel.hotel.toString(),
                      //               style: TextStyle(
                      //                 color: Colors.black,
                      //                 fontSize: 12.sp,
                      //                 fontFamily: 'DM Sans',
                      //                 fontWeight: FontWeight.w500,
                      //                 height: 1.17,
                      //               ),
                      //             ),
                      //             SizedBox(height: 17.h),
                      //             Text(
                      //               'Reference No',
                      //               style: TextStyle(
                      //                 color: const Color(0xFFA9A5B8),
                      //                 fontSize: 14.sp,
                      //                 fontFamily: 'DM Sans',
                      //                 fontWeight: FontWeight.w500,
                      //                 height: 1.17,
                      //               ),
                      //             ),
                      //             Text(
                      //               customerDetailsModel.refNo.toString(),
                      //               style: TextStyle(
                      //                 color: Colors.black,
                      //                 fontSize: 12.sp,
                      //                 fontFamily: 'DM Sans',
                      //                 fontWeight: FontWeight.w500,
                      //                 height: 1.17,
                      //               ),
                      //             ),
                      //             SizedBox(height: 17.h),
                      //             Text(
                      //               'Order No',
                      //               style: TextStyle(
                      //                 color: const Color(0xFFA9A5B8),
                      //                 fontSize: 14.sp,
                      //                 fontFamily: 'DM Sans',
                      //                 fontWeight: FontWeight.w500,
                      //                 height: 1.17,
                      //               ),
                      //             ),
                      //             Text(
                      //               widget.pickupOrderId != null &&
                      //               widget.pickupOrderId != 'null' ? widget.pickupOrderId : '',
                      //               style: TextStyle(
                      //                 color: Colors.black,
                      //                 fontSize: 12.sp,
                      //                 fontFamily: 'DM Sans',
                      //                 fontWeight: FontWeight.w500,
                      //                 height: 1.17,
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //         Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Text(
                      //               'Street No',
                      //               style: TextStyle(
                      //                 color: const Color(0xFFA9A5B8),
                      //                 fontSize: 14.sp,
                      //                 fontFamily: 'DM Sans',
                      //                 fontWeight: FontWeight.w500,
                      //                 height: 1.17,
                      //               ),
                      //             ),
                      //             Text(
                      //               customerDetailsModel.streetNo.toString(),
                      //               style: TextStyle(
                      //                 color: Colors.black,
                      //                 fontSize: 12.sp,
                      //                 fontFamily: 'DM Sans',
                      //                 fontWeight: FontWeight.w500,
                      //                 height: 1.17,
                      //               ),
                      //             ),
                      //             SizedBox(height: 17.h),
                      //             Text(
                      //               'Room No',
                      //               style: TextStyle(
                      //                 color: const Color(0xFFA9A5B8),
                      //                 fontSize: 14.sp,
                      //                 fontFamily: 'DM Sans',
                      //                 fontWeight: FontWeight.w500,
                      //                 height: 1.17,
                      //               ),
                      //             ),
                      //             Text(
                      //               customerDetailsModel.roomNo.toString(),
                      //               style: TextStyle(
                      //                 color: Colors.black,
                      //                 fontSize: 12.sp,
                      //                 fontFamily: 'DM Sans',
                      //                 fontWeight: FontWeight.w500,
                      //                 height: 1.17,
                      //               ),
                      //             ),
                      //             SizedBox(height: 17.h),
                      //             Text(
                      //               'Note',
                      //               style: TextStyle(
                      //                 color: const Color(0xFFA9A5B8),
                      //                 fontSize: 14.sp,
                      //                 fontFamily: 'DM Sans',
                      //                 fontWeight: FontWeight.w500,
                      //                 height: 1.17,
                      //               ),
                      //             ),
                      //             Text(
                      //               widget.notes,
                      //               style: TextStyle(
                      //                 color: Colors.black,
                      //                 fontSize: 12.sp,
                      //                 fontFamily: 'DM Sans',
                      //                 fontWeight: FontWeight.w500,
                      //                 height: 1.17,
                      //               ),
                      //             ),
                      //             SizedBox(height: 17.h),
                      //             Text(
                      //               'Pickup Id',
                      //               style: TextStyle(
                      //                 color: const Color(0xFFA9A5B8),
                      //                 fontSize: 14.sp,
                      //                 fontFamily: 'DM Sans',
                      //                 fontWeight: FontWeight.w500,
                      //                 height: 1.17,
                      //               ),
                      //             ),
                      //             Text(
                      //               widget.pickupAssignId.toString(),
                      //               style: TextStyle(
                      //                 color: Colors.black,
                      //                 fontSize: 12.sp,
                      //                 fontFamily: 'DM Sans',
                      //                 fontWeight: FontWeight.w500,
                      //                 height: 1.17,
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      crossFadeState:
                          showDetails
                              ? CrossFadeState.showSecond
                              : CrossFadeState.showFirst,
                      duration: const Duration(milliseconds: 300),
                    ),

                    SizedBox(height: 21.h),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Order Items',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w700,
                              height: 0.87,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _openAddItemDialog(context),
                            child: Container(
                              width: 110.w,
                              height: 40.h,
                              decoration: ShapeDecoration(
                                color: const Color(0xFF68188B),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3),
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
                                  'ADD ITEMS',
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
                        ],
                      ),
                    ),
                    SizedBox(height: 17.h),
                    if (widget.pickupOrderId != null &&
                        widget.pickupOrderId.toString().isNotEmpty &&
                        _orderItemsList.isNotEmpty)
                      Expanded(
                        child: ListView.builder(
                          itemCount: _orderItemsList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Container(
                                width: 364.w,
                                // height: 64.h,
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    // borderRadius: BorderRadius.circular(10.r),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Row(
                                    children: [
                                      Image.network(
                                        _orderItemsList[index]['clothImg']
                                            .toString(),
                                        width: 46.w,
                                        height: 44.h,
                                        fit : BoxFit.cover,
                                        loadingBuilder: (context, child, loadingProgress) {
                                        if (loadingProgress == null) return child;
                                         return const Center(child: CircularProgressIndicator());
                                        },
                                        errorBuilder: (context, error, stackTrace) {
                                          return const Icon(
                                          Icons.broken_image,
                                          color: Colors.grey,
                                          size: 40,
                                        );}
                                      ),
                                      SizedBox(width: 10.w),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 2.h),
                                          Text(
                                            _orderItemsList[index]['clothName']
                                                .toString(),
                                            style: TextStyle(
                                              color: const Color(0xFF150B3D),
                                              fontSize: 16.sp,
                                              fontFamily: 'DM Sans',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Text(
                                            '${_orderItemsList[index]['qnty']} QTY',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14.sp,
                                              fontFamily: 'DM Sans',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(height: 2.h),
                                          Text(
                                            _orderItemsList[index]['service']
                                                .toString(),
                                            style: TextStyle(
                                              color: const Color(0xFF150B3D),
                                              fontSize: 16.sp,
                                              fontFamily: 'DM Sans',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Text(
                                            _orderItemsList[index]['billing']
                                                .toString(),
                                            style: TextStyle(
                                              color: const Color(0xFF68188B),
                                              fontSize: 14.sp,
                                              fontFamily: 'DM Sans',
                                              fontWeight: FontWeight.w700,
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
                    // Spacer(),
                    Container(
                      // width: 380.w,
                      // height: 76.h,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          // borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Total Amount :',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17.sp,
                                        fontFamily: 'DM Sans',
                                        fontWeight: FontWeight.w700,
                                        height: 1,
                                      ),
                                    ),
                                    Text(
                                      totalAmount.toStringAsFixed(2),
                                      style: TextStyle(
                                        color: const Color(0xFF68188B),
                                        fontSize: 15.sp,
                                        fontFamily: 'DM Sans',
                                        fontWeight: FontWeight.w700,
                                        height: 1,
                                        letterSpacing: 1.20,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.h),
                                Row(
                                  children: [
                                    Text(
                                      'Total Quantity : ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17.sp,
                                        fontFamily: 'DM Sans',
                                        fontWeight: FontWeight.w700,
                                        height: 1,
                                      ),
                                    ),
                                    Text(
                                      totalquantity.toString(),
                                      style: TextStyle(
                                        color: const Color(0xFF68188B),
                                        fontSize: 15.sp,
                                        fontFamily: 'DM Sans',
                                        fontWeight: FontWeight.w700,
                                        height: 1,
                                        letterSpacing: 1.20,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () async {
                                double subtotal = 0.0;
                                double totalamt = 0.0;
                                double totalDiscount = 0.0;
                                double vatAmount = 0.0;

                                for (var item in _orderItemsList) {
                                  final price =
                                      double.tryParse(
                                        item['clothPrice']?.toString() ?? '0',
                                      ) ??
                                      0;
                                  final qty =
                                      int.tryParse(
                                        item['qnty']?.toString() ?? '0',
                                      ) ??
                                      0;
                                  subtotal += price * qty;
                                }
                                if (settingsData.vat == "Enable") {
                                  vatAmount =  subtotal * ((settingsData.vatAmount??0)/100);
                                }
                                
                                final companyCode = await storage.read(
                                  key: 'company_Code',
                                );
                                final token = await storage.read(
                                  key: 'access_Token',
                                );

                                if (token == null || companyCode == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        '❌ Missing token or company code',
                                      ),
                                    ),
                                  );
                                  return;
                                }
                                // case 1 : new order (no pickupOrderId)
                                if ((widget.pickupOrderId == null ||
                                        widget.pickupOrderId
                                            .toString()
                                            .isEmpty ||
                                        widget.pickupOrderId
                                                .toString()
                                                .toLowerCase() ==
                                            "null") &&
                                    _orderItemsList.isNotEmpty) {
                                  totalDiscount =
                                      subtotal *
                                      ((double.tryParse(
                                                customerDetailsModel.discount
                                                        ?.toString() ??
                                                    '0',
                                              ) ??
                                              0.0) /
                                          100);
                                  
                                  totalamt =
                                      subtotal -
                                      totalDiscount.ceilToDouble() +
                                      vatAmount +
                                      (double.tryParse(
                                            customerDetailsModel.openingBalance
                                                    ?.toString() ??
                                                '0',
                                          ) ??
                                          0.0);
                                  await _handleNewItemTap(
                                    context,
                                    subtotal,
                                    double.tryParse(
                                          customerDetailsModel.discount
                                                  ?.toString() ??
                                              '0',
                                        ) ??
                                        0.0,
                                    totalamt,
                                    totalDiscount.ceil().toDouble(),
                                    vatAmount
                                  );
                                }
                                //case 2 Adding items to existing ordered items
                                else {
                                  if (pickupOrderItems.customerDiscount != 0) {
                                    totalDiscount =
                                        subtotal *
                                        ((pickupOrderItems.customerDiscount ??
                                            0 )/ 100);       
                                    totalamt =
                                        subtotal -
                                        totalDiscount.ceilToDouble() -
                                        (double.tryParse(pickupOrderItems.paidAmount?.toString() ?? '0') ?? 0.0) +
                                        vatAmount +
                                        (pickupOrderItems.openingBalance ??
                                            0.0);
                                  } else {
                                    totalamt =
                                        subtotal -
                                        (double.tryParse(pickupOrderItems.discount?.toString() ?? '0') ?? 0.0) +
                                        vatAmount +
                                        (pickupOrderItems.openingBalance ??
                                            0.0);
                                  }
                                  double blnc =
                                      totalamt -
                                      (double.tryParse(pickupOrderItems.paidAmount?.toString() ?? '0') ?? 0.0);

                                  // Check if new items were added
                                  if (_orderItemsList.isNotEmpty &&
                                      pickupOrderItems.clothData != null &&
                                      _orderItemsList.length !=
                                          pickupOrderItems.clothData!.length) {
                                    // Items added → call AddPickupOrder API first
                                    await _handleTap(
                                      context,
                                      pickupOrderItems,
                                      subtotal,
                                      totalamt,
                                      blnc,
                                      totalDiscount != 0.0 ? totalDiscount.ceil() : (double.tryParse(pickupOrderItems.discount?.toString() ?? '0') ?? 0.0).ceil(),
                                      vatAmount
                                    );
                                  } else {
                                    // no new items → directly call FetchStatusPickupEvent
                                    if (_orderItemsList.length != 0) {
                                      context.read<PickupcustdetailsBloc>().add(
                                        FetchStatusPickupEvent(
                                          pickupAssignId: widget.pickupAssignId,
                                          token: token,
                                          companyCode: companyCode,
                                          status: 'Received'
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text('Please add Items'),
                                        ),
                                      );
                                    }
                                  }
                                }
                              },
                              child: Container(
                                width: 125.w,
                                height: 40.h,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFF68188B),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'Collect now',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.sp,
                                      fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return SizedBox();
              }
            },
          ),
        ),
      ),
      // bottomSheet: Padding(
      //   padding: const EdgeInsets.all(15.0),
      //   child:
      // ),
    );
  }
}
