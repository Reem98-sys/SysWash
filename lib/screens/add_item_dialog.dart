import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syswash/bloc/bloc/clothdetails_bloc.dart';
import 'package:syswash/bloc/bloc/servicedetails_bloc.dart';
import 'package:syswash/model/clothDetailsModel.dart';
import 'package:syswash/model/serviceDetails.dart';

Future<Map<String, dynamic>?> showAddItemDialog(
  BuildContext context,
  String token,
  String companyCode,
) async {
  String? selectedCloth;
  String? selectedService;
  String? billingType;
  TextEditingController quantityController = TextEditingController();

  List<String> billingServices = ['Normal', 'Express'];
  late ClothDetailsModel clothDetailsModel;
  String? arabicName;
  String? billing;
  String? clothImg;
  String? clothPrice;
  String? xprice;
  String? price;
  int? priceId;
  int? qnty;
  String? service;
  String? unit;
  final dropDownKey = GlobalKey<DropdownSearchState>();
  final dropdownTextStyle = TextStyle(
    color: Colors.black,
    fontSize: 14.sp,
    fontFamily: 'DM Sans',
    fontWeight: FontWeight.w400,
  );

  final dropdownHintStyle = TextStyle(
    color: Colors.grey.shade600,
    fontSize: 13.sp,
    fontFamily: 'DM Sans',
    fontWeight: FontWeight.w400,
  );

  return await showDialog<Map<String, dynamic>?>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        content: StatefulBuilder(
          builder: (context, setState) {
            return SingleChildScrollView(
              child: SizedBox(
                width: 402.w,
                height: 431.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Add Items',
                          style: TextStyle(
                            color: const Color(0xFF150B3D),
                            fontSize: 16.sp,
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Icon(Icons.cancel, size: 30.sp),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h),
                    // Service selection
                    Text(
                      'Select Service',
                      style: TextStyle(
                        color: const Color(0xFF150B3D),
                        fontSize: 12.sp,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    BlocBuilder<ServicedetailsBloc, ServicedetailsState>(
                      builder: (context, state) {
                        if (state is ServicedetailsLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (state is ServicedetailsError) {
                          print(state.message);
                          return Center(
                            child: Text(
                              'Failed to load Cloth Details',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 14.sp,
                              ),
                            ),
                          );
                        }
                        if (state is ServicedetailsLoaded) {
                          final List<ServiceDetailsModel> servicelist =
                              state.servicedetailModel;
                          //  Filter only items where posView is true
                          final filteredServices =
                              servicelist
                                  .where((service) => service.posView == true)
                                  .toList();
                          return Container(
                            width: 348.w,
                            height: 50.h,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.06),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                style: dropdownTextStyle,
                                isExpanded: true,
                                dropdownColor: Colors.white,
                                hint: Text(
                                  'Select Service',
                                  style: dropdownHintStyle,
                                ),

                                value: selectedService,

                                icon: Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black87,
                                  ),
                                ),
                                items:
                                    filteredServices.map((service) {
                                      return DropdownMenuItem<String>(
                                        value: service.serviceName,
                                        child: Text(
                                          service.serviceName.toString(),
                                        ),
                                      );
                                    }).toList(),

                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedService = newValue;
                                    // Trigger the cloth API call via Bloc
                                    if (newValue != null) {
                                      context.read<ClothdetailsBloc>().add(
                                        FetchClothDetailsEvent(
                                          token: token,
                                          companyCode: companyCode,
                                          servicetype:
                                              newValue, // Pass selected service code
                                        ),
                                      );
                                    }
                                  });
                                },
                              ),
                            ),
                          );
                        } else {
                          return SizedBox();
                        }
                      },
                    ),

                    SizedBox(height: 30.w),
                    // Cloth selection
                    Text(
                      'Select Cloth',
                      style: TextStyle(
                        color: const Color(0xFF150B3D),
                        fontSize: 12.sp,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 10.h),

                    BlocBuilder<ClothdetailsBloc, ClothdetailsState>(
                      builder: (context, state) {
                        if (state is ClothDetailsLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (state is ClothDetailsError) {
                          print(state.message);
                          return Center(
                            child: Text(
                              'Failed to load Cloth Details',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 14.sp,
                              ),
                            ),
                          );
                        }

                        if (state is ClothDetailsLoaded) {
                          clothDetailsModel = state.clothDetailsModelList;

                          return Container(
                            width: 348.w,
                            height: 50.h,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.06),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: DropdownSearch<String>(
                              key: dropDownKey,

                              items: (filter, _) {
                                final List<String> filtered =
                                    (clothDetailsModel.data ?? [])
                                        .where((e) => e.data?.clothType != null)
                                        .map((e) => e.data!.clothType!)
                                        .where(
                                          (name) => name.toLowerCase().contains(
                                            (filter ?? '').toLowerCase(),
                                          ),
                                        )
                                        .toList();

                                return filtered;
                              },

                              decoratorProps: DropDownDecoratorProps(
                                decoration: InputDecoration(
                                  hintText: 'Search',

                                  hintStyle: dropdownHintStyle,
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                    // left: 16,
                                    top: 13,
                                  ),
                                ),
                              ),
                              popupProps: PopupProps.menu(
                                showSearchBox: true,
                                constraints: const BoxConstraints(
                                  maxHeight: 320,
                                ),
                                menuProps: MenuProps(
                                  backgroundColor: Colors.white,
                                  margin: EdgeInsets.zero,
                                ),
                                searchFieldProps: TextFieldProps(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 10,
                                    ),
                                    hintText: "Search...",
                                    hintStyle: dropdownHintStyle,
                                    prefixIcon: Icon(Icons.search),
                                    border: OutlineInputBorder(),
                                    fillColor: Colors.white,
                                    filled: true,
                                  ),
                                ),
                              ),
                              onChanged: (selectedName) {
                                setState(() {
                                  selectedCloth = selectedName;
                                  // Find the full matching cloth object from the model
                                  final matchedCloth =
                                      (clothDetailsModel.data ?? []).firstWhere(
                                        (e) =>
                                            e.data?.clothType?.toLowerCase() ==
                                            selectedName?.toLowerCase(),
                                      );
                                  arabicName = matchedCloth.clothArabicName;
                                  clothImg = matchedCloth.clothImage;
                                  xprice = matchedCloth.data?.xprice.toString();
                                  price = matchedCloth.data?.price.toString();
                                  priceId = matchedCloth.data?.priceId;
                                  service = matchedCloth.serviceCode;
                                  unit = matchedCloth.data?.unit.toString();
                                });
                              },
                              selectedItem: selectedCloth,
                            ),
                          );
                        }

                        return const SizedBox();
                      },
                    ),

                    SizedBox(height: 30.h),

                    Row(
                      children: [
                        Container(
                          width: 140.w,
                          height: 66.h,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Billing Type',
                                style: TextStyle(
                                  color: const Color(0xFF150B3D),
                                  fontSize: 12.sp,
                                  fontFamily: 'DM Sans',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Container(
                                width: 140.w,
                                height: 40.h,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.06),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    hint: Text('Select'),
                                    style: dropdownTextStyle,
                                    value: billingType,
                                    items:
                                        billingServices.map((String type) {
                                          return DropdownMenuItem<String>(
                                            value: type,
                                            child: Text(type),
                                          );
                                        }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        billingType = newValue;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 15.w),
                        Container(
                          width: 140.w,
                          height: 66.h,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Quantity',
                                style: TextStyle(
                                  color: const Color(0xFF150B3D),
                                  fontSize: 12.sp,
                                  fontFamily: 'DM Sans',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Container(
                                width: 140.w,
                                height: 40.h,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.06),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: TextFormField(
                                  controller: quantityController,
                                  keyboardType: TextInputType.number,
                                  maxLength: 4,
                                  decoration: const InputDecoration(
                                    counterText: '', // hides the "0/4" counter
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: 140.w,
                            height: 50.h,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFFED8CD),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'CLEAR',
                                style: TextStyle(
                                  color: Colors.black.withValues(alpha: 0.54),
                                  fontSize: 14.sp,
                                  fontFamily: 'DM Sans',
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.84,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 15.w),
                        GestureDetector(
                          onTap: () {
                            if (billingType == 'Express') {
                              clothPrice = xprice;
                            } else {
                              clothPrice = price;
                            }
                            Navigator.pop(context, {
                              "arabicName": arabicName,
                              "billing": billingType,
                              "clothImg": clothImg,
                              "clothName": selectedCloth,
                              "clothPrice": clothPrice,
                              "priceId": priceId,
                              "qnty": int.tryParse(quantityController.text.trim()),
                              "service": service,
                              "unit": unit,
                            });
                          },

                          child: Container(
                            width: 140.w,
                            height: 50.h,
                            decoration: ShapeDecoration(
                              color: const Color(0xFF68188B),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              shadows: [
                                BoxShadow(
                                  color: Color(0x2D99AAC5),
                                  blurRadius: 62,
                                  offset: Offset(0, 4),
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                'SAVE',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontFamily: 'DM Sans',
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.84,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
