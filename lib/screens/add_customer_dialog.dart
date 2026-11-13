import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:syswash/bloc/bloc/addcustomer_bloc.dart';
import 'package:syswash/bloc/bloc/customerlist_bloc.dart';
import 'package:syswash/bloc/bloc/report_bloc.dart';
import 'package:syswash/bloc/bloc/uploadpickup_bloc.dart';

Future<Map<String, dynamic>?> showNewCustomerForm(
  BuildContext context,
  String token,
  String companyCode,
) async {
  context.read<ReportBloc>().add(
    FetchAdminAccountTypeEvent(token: token, companyCode: companyCode),
  );

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final openingBalanceController = TextEditingController(text: '0');
  final discountController = TextEditingController(text: '0');
  final hotelController = TextEditingController();
  final roomNoController = TextEditingController();
  final referenceNoController = TextEditingController();
  final areaController = TextEditingController(text: 'Doha');
  final zoneController = TextEditingController();
  final streetController = TextEditingController();
  final villaNoController = TextEditingController();

  String? validationError;
  String accountType = '';
  String deliveryType = 'TAKE AWAY';
  String packingType = '';
  String starch = 'Small';
  DateTime joinDate = DateTime.now();

  final dateFormat = DateFormat('dd-MM-yyyy');

  final result = await showDialog<Map<String, dynamic>>(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      return StatefulBuilder(
        builder: (context, setState) {
          const borderColor = Color(0xFFD6D6D6);
          const primaryColor = Color(0xFF68188B);

          InputDecoration inputDec(String label, {bool required = false}) {
            return InputDecoration(
              labelText: required ? '$label*' : label,
              labelStyle: const TextStyle(
                fontSize: 13,
                color: Color(0xFF666666),
              ),
              floatingLabelStyle: const TextStyle(color: primaryColor),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: borderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: borderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: primaryColor, width: 1.5),
              ),
            );
          }

          Widget buildTextField(
            String label,
            TextEditingController controller, {
            bool required = false,
            bool enabled = true,
            TextInputType keyboardType = TextInputType.text,
          }) {
            return TextField(
              controller: controller,
              enabled: enabled,
              keyboardType: keyboardType,
              style: const TextStyle(fontSize: 14),
              decoration: inputDec(label, required: required),
            );
          }

          Widget buildRadioGroup(
            String label,
            List<String> options,
            String selected,
            ValueChanged<String> onChanged,
          ) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF666666),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 12,
                  runSpacing: 0,
                  children:
                      options.map((option) {
                        return InkWell(
                          onTap: () => onChanged(option),
                          borderRadius: BorderRadius.circular(4),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Radio<String>(
                                value: option,
                                groupValue: selected,
                                activeColor: primaryColor,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                visualDensity: VisualDensity.compact,
                                onChanged:
                                    (val) =>
                                        val != null ? onChanged(val) : null,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                option,
                                style: const TextStyle(fontSize: 13),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                ),
              ],
            );
          }

          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            insetPadding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 850, maxHeight: 700),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 12, 16),
                    child: Row(
                      children: [
                        const Text(
                          'ADD CUSTOMER',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF333333),
                            letterSpacing: 0.5,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () => Navigator.pop(dialogContext),
                          icon: const Icon(Icons.close, size: 20),
                          splashRadius: 20,
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1, thickness: 1),

                  // Form Body
                  Flexible(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final width = constraints.maxWidth;
                        final columns =
                            width >= 700 ? 3 : (width >= 450 ? 2 : 1);
                        const spacing = 14.0;
                        final fieldWidth =
                            (width - (spacing * (columns - 1)) - 40) / columns;

                        return SingleChildScrollView(
                          padding: const EdgeInsets.all(20),
                          child: Wrap(
                            spacing: spacing,
                            runSpacing: 16,
                            children: [
                              // Join Date Picker
                              SizedBox(
                                width: fieldWidth,
                                child: InkWell(
                                  onTap: () async {
                                    final picked = await showDatePicker(
                                      context: context,
                                      initialDate: joinDate,
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2100),
                                    );
                                    if (picked != null) {
                                      setState(() => joinDate = picked);
                                    }
                                  },
                                  borderRadius: BorderRadius.circular(8),
                                  child: InputDecorator(
                                    decoration: inputDec(
                                      'Join Date',
                                      required: true,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          dateFormat.format(joinDate),
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                        const Icon(
                                          Icons.calendar_month_outlined,
                                          size: 16,
                                          color: Color(0xFF666666),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              // Name
                              SizedBox(
                                width: fieldWidth,
                                child: buildTextField(
                                  'Name',
                                  nameController,
                                  required: true,
                                ),
                              ),

                              // Account Type Dropdown (BlocBuilder)
                              SizedBox(
                                width: fieldWidth,
                                child: BlocBuilder<ReportBloc, ReportState>(
                                  builder: (context, state) {
                                    if (state is ReportLoading) {
                                      return const SizedBox(
                                        height: 48,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                          ),
                                        ),
                                      );
                                    }

                                    if (state is AdminAccountTypeLoaded) {
                                      final accountTypes =
                                          state.accountType
                                              .where(
                                                (item) =>
                                                    item.acTypeName != null &&
                                                    item.acTypeName!
                                                        .trim()
                                                        .isNotEmpty &&
                                                    item.trash != true,
                                              )
                                              .toList();

                                      if (accountTypes.isEmpty) {
                                        return InputDecorator(
                                          decoration: inputDec(
                                            'Account Type',
                                            required: true,
                                          ),
                                          child: const Text(
                                            'No types available',
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        );
                                      }

                                      return DropdownButtonFormField<String>(
                                        value:
                                            accountTypes.any(
                                                  (item) =>
                                                      item.acTypeName ==
                                                      accountType,
                                                )
                                                ? accountType
                                                : null,
                                        isExpanded: true,
                                        menuMaxHeight: 250,
                                        decoration: inputDec(
                                          'Account Type',
                                          required: true,
                                        ),
                                        hint: const Text(
                                          'Select Account Type',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        items:
                                            accountTypes.map((item) {
                                              return DropdownMenuItem<String>(
                                                value: item.acTypeName!,

                                                child: Text(
                                                  item.acTypeName!,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              );
                                            }).toList(),
                                        onChanged: (value) {
                                          if (value != null) {
                                            setState(() => accountType = value);
                                          }
                                        },
                                      );
                                    }

                                    return InputDecorator(
                                      decoration: inputDec(
                                        'Account Type',
                                        required: true,
                                      ),
                                      child: const Text(
                                        'Loading...',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    );
                                  },
                                ),
                              ),

                              // Delivery Type Dropdown
                              SizedBox(
                                width: fieldWidth,
                                child: DropdownButtonFormField<String>(
                                  value:
                                      [
                                            'TAKE AWAY',
                                            'PICKUP & DELIVERY',
                                          ].contains(deliveryType)
                                          ? deliveryType
                                          : null,
                                  isExpanded: true,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight:
                                        FontWeight
                                            .normal, // Reduces boldness here
                                  ),
                                  decoration: inputDec(
                                    'Delivery Type',
                                    required: true,
                                  ),
                                  items:
                                      ['TAKE AWAY', 'PICKUP & DELIVERY'].map((
                                        item,
                                      ) {
                                        return DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                  onChanged:
                                      (value) =>
                                          setState(() => deliveryType = value!),
                                ),
                              ),

                              // Opening Balance
                              SizedBox(
                                width: fieldWidth,
                                child: buildTextField(
                                  'Opening Balance',
                                  openingBalanceController,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                        decimal: true,
                                      ),
                                ),
                              ),

                              // Email
                              SizedBox(
                                width: fieldWidth,
                                child: buildTextField(
                                  'Email ID',
                                  emailController,
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),

                              // Mobile
                              SizedBox(
                                width: fieldWidth,
                                child: buildTextField(
                                  'Mobile',
                                  mobileController,
                                  required: true,
                                  keyboardType: TextInputType.phone,
                                ),
                              ),

                              // Discount
                              SizedBox(
                                width: fieldWidth,
                                child: buildTextField(
                                  'Discount (%)',
                                  discountController,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                        decimal: true,
                                      ),
                                ),
                              ),

                              // Hotel
                              SizedBox(
                                width: fieldWidth,
                                child: buildTextField('Hotel', hotelController),
                              ),

                              // Room No
                              SizedBox(
                                width: fieldWidth,
                                child: buildTextField(
                                  'Room NO',
                                  roomNoController,
                                ),
                              ),

                              // Reference No
                              SizedBox(
                                width: fieldWidth,
                                child: buildTextField(
                                  'Reference NO',
                                  referenceNoController,
                                ),
                              ),

                              // Area
                              SizedBox(
                                width: fieldWidth,
                                child: buildTextField(
                                  'Area',
                                  areaController,
                                  required: true,
                                ),
                              ),

                              // Zone
                              SizedBox(
                                width: fieldWidth,
                                child: buildTextField('Zone', zoneController),
                              ),

                              // Street
                              SizedBox(
                                width: fieldWidth,
                                child: buildTextField(
                                  'Street',
                                  streetController,
                                ),
                              ),

                              // Villa No
                              SizedBox(
                                width: fieldWidth,
                                child: buildTextField(
                                  'Villa NO',
                                  villaNoController,
                                ),
                              ),

                              // Packing Type Radios
                              SizedBox(
                                width: fieldWidth,
                                child: buildRadioGroup(
                                  'Packing Type',
                                  ['Folded', 'Packing', 'Hanger'],
                                  packingType,
                                  (value) =>
                                      setState(() => packingType = value),
                                ),
                              ),

                              // Starch Radios
                              SizedBox(
                                width: fieldWidth,
                                child: buildRadioGroup(
                                  'Starch',
                                  ['Full', 'Medium', 'Small'],
                                  starch,
                                  (value) => setState(() => starch = value),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  const Divider(height: 1, thickness: 1),

                  // Footer Actions
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (validationError != null) ...[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Text(
                                validationError!,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        ],

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            OutlinedButton(
                              onPressed: () => Navigator.pop(context),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: const Color(0xFF555555),
                                side: const BorderSide(
                                  color: Color(0xFFCCCCCC),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12,
                                ),
                              ),
                              child: const Text(
                                'Cancel',
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () {
                                String? error;

                                if (nameController.text.trim().isEmpty) {
                                  error = 'Please enter Customer Name';
                                } else if (mobileController.text
                                    .trim()
                                    .isEmpty) {
                                  error = 'Please enter Mobile Number';
                                } else if (areaController.text.trim().isEmpty) {
                                  error = 'Please enter Area';
                                } else if (accountType.isEmpty) {
                                  error = 'Please select Account Type';
                                }

                                if (error != null) {
                                  setState(() {
                                    validationError = error;
                                  });
                                  return;
                                }

                                setState(() {
                                  validationError = null;
                                });

                                final formData = <String, dynamic>{
                                  'name': nameController.text.trim(),
                                  'mobile': mobileController.text.trim(),
                                  'email': emailController.text.trim(),
                                  'acType': accountType,
                                  'deliveryType': deliveryType,
                                  'openingBalance':
                                      double.tryParse(
                                        openingBalanceController.text,
                                      ) ??
                                      0,
                                  'discount':
                                      double.tryParse(
                                        discountController.text,
                                      ) ??
                                      0,
                                  'hotel': hotelController.text.trim(),
                                  'roomNo': roomNoController.text.trim(),
                                  'refNo': referenceNoController.text.trim(),
                                  'area': areaController.text.trim(),
                                  'zone': zoneController.text.trim(),
                                  'streetNo': streetController.text.trim(),
                                  'villaNumber': villaNoController.text.trim(),
                                  'packingType': packingType,
                                  'starch': starch,
                                  'joinDate': DateFormat(
                                    'yyyy-MM-dd',
                                  ).format(joinDate),
                                  'auto_generated': true,
                                  'order_limit': 50,
                                };

                                debugPrint('New Customer Form Data: $formData');

                                Navigator.pop(dialogContext, formData);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                                elevation: 0,
                              ),
                              child: const Text(
                                'Submit',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );

  return result;
}

Future<Map<String, dynamic>?> createNewCustomer({
  required BuildContext context,
  required String token,
  required String username,
  required String name,
  required String mobile,
  required String area,
  required String email,
}) async {
  try {
    final url = Uri.parse(
      'https://be.syswash.net/api/syswash/customerdetails?code=A',
    );

    final Map<String, dynamic> body = {
      "name": name,
      "mobile": mobile,
      "area": area,
      "email": email,
      "acType": "WALK IN CASH",
      "auto_generated": true,
      "cusCode": "",
      "deliveryType": "TAKE AWAY",
      "discount": 0,
      "fragrance": "",
      "hotel": "",
      "joinDate": DateFormat('yyyy-MM-dd').format(DateTime.now()),
      "openingBalance": 0,
      "order_limit": 50,
      "packingType": "",
      "refNo": "",
      "roomNo": "",
      "starch": "",
      "streetNo": "",
      "userName": username,
      "villaNumber": "",
      "wallet": 0,
      "zone": "",
    };

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(body),
    );

    debugPrint("Customer API Status: ${response.statusCode}");
    debugPrint("Customer API Response: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseData = jsonDecode(response.body);

      // Support both direct and nested data responses.
      final customerData =
          responseData is Map && responseData['data'] is Map
              ? Map<String, dynamic>.from(responseData['data'])
              : Map<String, dynamic>.from(responseData);

      return {
        "success": true,
        "name": customerData['name'] ?? name,
        "mobile": customerData['mobile'] ?? mobile,
        "area": customerData['area'] ?? area,
        "customerId":
            customerData['customerId'] ??
            customerData['customer_id'] ??
            customerData['id'] ??
            '',
        "cusCode":
            customerData['cusCode'] ??
            customerData['cus_code'] ??
            customerData['code'] ??
            '',
      };
    }

    return {"success": false, "message": response.body};
  } catch (e) {
    debugPrint("Create Customer Error: $e");

    return {"success": false, "message": e.toString()};
  }
}

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
  final TextEditingController noteController = TextEditingController();
  final TextEditingController remarkController = TextEditingController();
  final TextEditingController dateController = TextEditingController(
    text: DateFormat('dd-MM-yyyy').format(DateTime.now()),
  );

  String? pickupCustomerCode;
  String? pickupCustomerId;
  String? pickupDriverid = userId;
  String? pickupDrivername = username;
  String? pickupCustomerName;

  final dropDownKey = GlobalKey<DropdownSearchState>();

  return showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    // isDismissible: true,
    // enableDrag: true,
    builder: (context) {
      return AnimatedPadding(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Align(
              alignment: Alignment.center,
              child: Material(
                child: Container(
                  width: 402.w,

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: BlocListener<AddcustomerBloc, AddcustomerState>(
                      listener: (context, state) {
                        if (state is AddcustomerLoaded) {
                          // Refresh customer list after successful creation.
                          context.read<CustomerlistBloc>().add(
                            FetchCustomerListEvent(
                              token: token,
                              companyCode: companyCode,
                            ),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Customer added successfully'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }

                        if (state is AddcustomerError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Failed to add customer'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      child: Form(
                        key: _formKey,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: SingleChildScrollView(
                            keyboardDismissBehavior:
                                ScrollViewKeyboardDismissBehavior.manual,
                            padding: EdgeInsets.fromLTRB(
                              16.w,
                              16.h,
                              16.w,
                              16.h,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// HEADER
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Select Customer',
                                      style: TextStyle(
                                        color: const Color(0xFF150B3D),
                                        fontSize: 16.sp,
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

                                /// CUSTOMER
                                Text(
                                  'Customer',
                                  style: TextStyle(
                                    color: const Color(0xFF150B3D),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 10.h),

                                BlocBuilder<
                                  CustomerlistBloc,
                                  CustomerlistState
                                >(
                                  builder: (context, state) {
                                    if (state is CustomerListBlocLoading) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }

                                    if (state is CustomerListBlocError) {
                                      return Center(
                                        child: Text(
                                          'Failed to load Customer',
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
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            8.r,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(
                                                0.06,
                                              ),
                                              blurRadius: 10,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: DropdownSearch<String>(
                                          key: dropDownKey,
                                          items: (filter, infiniteScrollProps) {
                                            return customerList
                                                .where((c) {
                                                  final search =
                                                      filter?.toLowerCase() ??
                                                      '';
                                                  final name =
                                                      c.name?.toLowerCase() ??
                                                      '';
                                                  final phone =
                                                      c.mobile?.toString() ??
                                                      '';

                                                  return name.contains(
                                                        search,
                                                      ) ||
                                                      phone.contains(search);
                                                })
                                                .map(
                                                  (c) =>
                                                      "${c.name} (${c.mobile ?? ''})",
                                                )
                                                .toList();
                                          },
                                          dropdownBuilder: (
                                            context,
                                            selectedItem,
                                          ) {
                                            if (selectedItem == null) {
                                              return Text(
                                                '',
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                ),
                                              );
                                            }

                                            final name =
                                                selectedItem
                                                    .split('(')
                                                    .first
                                                    .trim();

                                            return Text(
                                              name,
                                              style: TextStyle(fontSize: 16.sp),
                                            );
                                          },
                                          decoratorProps:
                                              DropDownDecoratorProps(
                                                decoration: InputDecoration(
                                                  hintText: 'Search',

                                                  border: InputBorder.none,
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 10,
                                                      ),
                                                ),
                                              ),
                                          popupProps: PopupProps.menu(
                                            showSearchBox: true,
                                            constraints: const BoxConstraints(
                                              maxHeight: 420,
                                            ),

                                            menuProps: const MenuProps(
                                              backgroundColor: Colors.white,
                                            ),

                                            searchFieldProps: TextFieldProps(
                                              decoration: const InputDecoration(
                                                hintText: 'Search...',
                                                prefixIcon: Icon(Icons.search),
                                                border: OutlineInputBorder(),
                                                fillColor: Colors.white,
                                                filled: true,
                                              ),
                                            ),

                                            // Show Add Customer when no matching customer exists.
                                            emptyBuilder: (
                                              context,
                                              searchEntry,
                                            ) {
                                              return Padding(
                                                padding: const EdgeInsets.all(
                                                  16,
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    const Text(
                                                      'No customer found',
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                      ),
                                                    ),

                                                    const SizedBox(height: 12),

                                                    ElevatedButton.icon(
                                                      icon: const Icon(
                                                        Icons.person_add,
                                                      ),
                                                      label: const Text(
                                                        'Add New Customer',
                                                      ),

                                                      style:
                                                          ElevatedButton.styleFrom(
                                                            backgroundColor:
                                                                const Color(
                                                                  0xFF68188B,
                                                                ),
                                                            foregroundColor:
                                                                Colors.white,
                                                          ),

                                                      onPressed: () async {
                                                        final formData =
                                                            await showNewCustomerForm(
                                                              context,
                                                              token,
                                                              companyCode,
                                                            );

                                                        if (formData == null ||
                                                            !context.mounted)
                                                          return;

                                                        context
                                                            .read<
                                                              AddcustomerBloc
                                                            >()
                                                            .add(
                                                              FetchAddcustomerEvent(
                                                                token: token,
                                                                username:
                                                                    username,
                                                                companyCode:
                                                                    companyCode,
                                                                customerData:
                                                                    formData,
                                                              ),
                                                            );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                          onChanged: (selectedName) {
                                            if (selectedName == null) return;

                                            final selectedCustomer =
                                                customerList.firstWhere(
                                                  (c) =>
                                                      selectedName ==
                                                      "${c.name} (${c.mobile ?? ''})",
                                                );

                                            pickupCustomerName =
                                                selectedCustomer.name
                                                    ?.toString();

                                            phoneController.text =
                                                selectedCustomer.mobile
                                                    ?.toString() ??
                                                '';

                                            areaController.text =
                                                selectedCustomer.area
                                                    ?.toString() ??
                                                '';

                                            pickupCustomerId =
                                                selectedCustomer.customerId
                                                    ?.toString();

                                            pickupCustomerCode =
                                                selectedCustomer.cusCode
                                                    ?.toString();
                                          },
                                        ),
                                      );
                                    }

                                    return const SizedBox();
                                  },
                                ),

                                SizedBox(height: 20.h),

                                /// PHONE
                                Text(
                                  'Phone Number',
                                  style: TextStyle(
                                    color: const Color(0xFF150B3D),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Container(
                                  width: 348.w,
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
                                    controller: phoneController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: 'Phone number',
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(fontSize: 16.sp),
                                    ),
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                ),

                                SizedBox(height: 20.h),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 140.w,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Area',
                                            style: TextStyle(
                                              color: const Color(0xFF150B3D),
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          SizedBox(height: 10.h),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.06),
                                                  blurRadius: 10,
                                                  offset: const Offset(0, 4),
                                                ),
                                              ],
                                            ),
                                            child: TextFormField(
                                              controller: areaController,
                                              decoration: InputDecoration(
                                                hintText: 'Place',
                                                border: InputBorder.none,
                                                hintStyle: TextStyle(
                                                  fontSize: 16.sp,
                                                ),
                                              ),
                                              style: TextStyle(fontSize: 16.sp),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    SizedBox(
                                      width: 140.w,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Date',
                                            style: TextStyle(
                                              color: const Color(0xFF150B3D),
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          SizedBox(height: 10.h),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.06),
                                                  blurRadius: 10,
                                                  offset: const Offset(0, 4),
                                                ),
                                              ],
                                            ),
                                            child: TextFormField(
                                              controller: dateController,
                                              readOnly: true,
                                              onTap: () async {
                                                DateTime today = DateTime.now();
                                                DateTime lastDate = today.add(
                                                  const Duration(days: 30),
                                                );

                                                DateTime? pickedDate =
                                                    await showDatePicker(
                                                      context: context,
                                                      initialDate: today,
                                                      firstDate: today,
                                                      lastDate: lastDate,
                                                    );

                                                if (pickedDate != null) {
                                                  String formattedDate =
                                                      "${pickedDate.day.toString().padLeft(2, '0')}-"
                                                      "${pickedDate.month.toString().padLeft(2, '0')}-"
                                                      "${pickedDate.year}";
                                                  dateController.text =
                                                      formattedDate;
                                                }
                                              },
                                              decoration: InputDecoration(
                                                hintText: 'Date',
                                                border: InputBorder.none,
                                                hintStyle: TextStyle(
                                                  fontSize: 16.sp,
                                                ),
                                              ),
                                              style: TextStyle(fontSize: 16.sp),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 20.h),

                                /// NOTES
                                Text(
                                  'Notes',
                                  style: TextStyle(
                                    color: const Color(0xFF150B3D),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Container(
                                  width: 348.w,
                                  height: 100.h,
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
                                    controller: noteController,
                                    minLines: 4,
                                    maxLines: 6,
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                      hintText: 'Write Notes here',
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(fontSize: 16.sp),
                                    ),
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                ),

                                SizedBox(height: 20.h),

                                /// REMARK
                                Text(
                                  'Remark',
                                  style: TextStyle(
                                    color: const Color(0xFF150B3D),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Container(
                                  width: 348.w,
                                  height: 100.h,
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
                                    controller: remarkController,
                                    minLines: 4,
                                    maxLines: 6,
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                      hintText: 'Write Remark here',
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(fontSize: 16.sp),
                                    ),
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                ),

                                SizedBox(height: 24.h),

                                /// ACTIONS
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () => Navigator.pop(context),
                                      child: Container(
                                        width: 130.w,
                                        height: 50.h,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFFED8CD),
                                          borderRadius: BorderRadius.circular(
                                            6.r,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'CLEAR',
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        context.read<UploadpickupBloc>().add(
                                          FetchUploadPickupEvent(
                                            companyCode: companyCode,
                                            token: token,
                                            notes: noteController.text.trim(),
                                            pickupCustomerArea:
                                                areaController.text.trim(),
                                            pickupCustomerCode:
                                                pickupCustomerCode ?? '',
                                            pickupCustomerId:
                                                pickupCustomerId ?? '',
                                            pickupCustomerName:
                                                pickupCustomerName ?? '',
                                            pickupCustomerPhno:
                                                phoneController.text.trim(),
                                            pickupDate:
                                                DateTime.now()
                                                    .toIso8601String()
                                                    .split('T')[0],
                                            pickuptime: DateFormat(
                                              'HH:mm',
                                            ).format(DateTime.now()),
                                            pickupDriverid: pickupDriverid,
                                            pickupDrivername: pickupDrivername,
                                            remarks:
                                                remarkController.text.trim(),
                                          ),
                                        );
                                        Navigator.pop(context, true);
                                      },
                                      child: Container(
                                        width: 130.w,
                                        height: 50.h,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF68188B),
                                          borderRadius: BorderRadius.circular(
                                            6.r,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'SAVE',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w700,
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
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
