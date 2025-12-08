import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:syswash/bloc/bloc/customerlist_bloc.dart';
import 'package:syswash/bloc/bloc/uploadpickup_bloc.dart';

Future<bool?> showAddCustomerDialog(
  BuildContext context,
  String companyCode,
  String token,
  String username,
  String userId,
) {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController remarkController = TextEditingController();
  String? pickupCustomerCode;
  String? pickupCustomerId;
  String? pickupDriverid = userId;
  String? pickupDrivername = username;
  String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  dateController = TextEditingController(text: currentDate);
  final dropDownKey = GlobalKey<DropdownSearchState>();
  return showDialog<bool?>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),

        content: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              width: 402.w,
              height: 630.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Select Customer',
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
                  SizedBox(height: 31.h),
                  Text(
                    'Customer',
                    style: TextStyle(
                      color: const Color(0xFF150B3D),
                      fontSize: 12.sp,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  BlocBuilder<CustomerlistBloc, CustomerlistState>(
                    builder: (context, state) {
                      if (state is CustomerListBlocLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state is CustomerListBlocError) {
                        return Center(
                          child: Text(
                            'Failed to load Customer\n',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 14.sp,
                            ),
                          ),
                        );
                      }
                      if (state is CustomerListBlocLoaded) {
                        final customerList =
                            state.customerListModel?.data ?? [];
                        return Container(
                          width: 348.w,
                          height: 50.h,
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

                            items: (filter, infiniteScrollProps) {
                              // Get names from your customerList data
                              final filtered =
                                  customerList
                                      .where(
                                        (customer) =>
                                            (customer.name
                                                    ?.toLowerCase()
                                                    .contains(
                                                      filter?.toLowerCase() ??
                                                          '',
                                                    ) ??
                                                false),
                                      )
                                      .map((customer) => customer.name ?? '')
                                      .toList();

                              return filtered;
                            },

                            decoratorProps: DropDownDecoratorProps(
                              decoration: InputDecoration(
                                hintText: 'Search',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                  left: 16,
                                  top: 12,
                                ),
                              ),
                            ),

                            popupProps: PopupProps.menu(
                              showSearchBox: true,
                              constraints: BoxConstraints(maxHeight: 420),

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
                                  prefixIcon: Icon(Icons.search),
                                  border: OutlineInputBorder(),
                                  fillColor: Colors.white,
                                  filled: true,
                                ),
                              ),
                            ),
                            onChanged: (selectedName) {
                              final selectedCustomer = customerList.firstWhere(
                                (customer) => customer.name == selectedName,
                              );
                              if (selectedCustomer != null) {
                                //auto fill phone no. and area fields
                                phoneController.text =
                                    selectedCustomer.mobile.toString() ?? '';
                                areaController.text =
                                    selectedCustomer.area.toString() ?? '';
                                pickupCustomerId =
                                    selectedCustomer.customerId.toString();
                                pickupCustomerCode =
                                    selectedCustomer.cusCode.toString();
                              }
                            },
                          ),
                        );
                      } else {
                        return SizedBox();
                      }
                    },
                  ),

                  SizedBox(height: 20.h),
                  Text(
                    'Phone Number',
                    style: TextStyle(
                      color: const Color(0xFF150B3D),
                      fontSize: 12.sp,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Container(
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
                    child: TextFormField(
                      controller: phoneController,
                      decoration: const InputDecoration(
                        hintText: 'Phone number',
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Container(
                        width: 140.w,
                        height: 66.h,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Area',
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
                                controller: areaController,
                                decoration: const InputDecoration(
                                  hintText: 'Place',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Container(
                        width: 140.w,
                        height: 66.h,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Date',
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
                                controller: dateController,
                                readOnly: true, // prevent manual typing
                                decoration: const InputDecoration(
                                  hintText: 'Date',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'Notes',
                    style: TextStyle(
                      color: const Color(0xFF150B3D),
                      fontSize: 12.sp,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    width: 348.w,
                    height: 100.h,
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
                    child: TextFormField(
                      controller: noteController,

                      decoration: const InputDecoration(
                        hintText: 'Write Notes here',
                        border: InputBorder.none,
                      ),
                      minLines: 4,
                      maxLines: 6,
                      keyboardType: TextInputType.multiline,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'Remark',
                    style: TextStyle(
                      color: const Color(0xFF150B3D),
                      fontSize: 12.sp,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    width: 348.w,
                    height: 100.h,
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
                    child: TextFormField(
                      controller: remarkController,

                      decoration: const InputDecoration(
                        hintText: 'Write Remark here',
                        border: InputBorder.none,
                      ),
                      minLines: 4,
                      maxLines: 6,
                      keyboardType: TextInputType.multiline,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: [
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
              SizedBox(width: 12.w),
              GestureDetector(
                onTap: () async {
                  context.read<UploadpickupBloc>().add(
                    FetchUploadPickupEvent(
                      companyCode: companyCode,
                      token: token,
                      notes: noteController.text.trim() ?? '',
                      pickupCustomerArea: areaController.text.trim(),
                      pickupCustomerCode: pickupCustomerCode ?? '',
                      pickupCustomerId: pickupCustomerId ?? '',
                      pickupCustomerName:
                          dropDownKey.currentState?.getSelectedItem ?? "",
                      pickupCustomerPhno: phoneController.text.trim(),
                      pickupDate: DateTime.now().toIso8601String().split('T')[0],
                      pickupDriverid: pickupDriverid,
                      pickupDrivername: pickupDrivername,
                      remarks: remarkController.text.trim() ?? '',
                    ),
                  );
                  
                    Navigator.pop(context,true);
                 
                  // close the dialog after triggering upload
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
      );
    },
  );
}
