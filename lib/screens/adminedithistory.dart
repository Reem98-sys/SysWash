import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:syswash/bloc/bloc/adminhome_bloc.dart';
import 'package:syswash/bloc/bloc/report_bloc.dart';
import 'package:syswash/helper/date_range_popup.dart';
import 'package:syswash/model/adminedithistory.dart';

class Adminedithistory extends StatefulWidget {
  const Adminedithistory({super.key});

  @override
  State<Adminedithistory> createState() => _AdminedithistoryState();
}

class _AdminedithistoryState extends State<Adminedithistory> {
  final storage = const FlutterSecureStorage();
  List<AdminEditHistory> adminEditHistory = [];
  String? username;
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _loadAndFetchData();
  }

  Future<void> _loadAndFetchData() async {
    final userId = await storage.read(key: 'login_id');
    final companyCode = await storage.read(key: 'company_Code');
    final token = await storage.read(key: 'access_Token');
    final storedUsername = await storage.read(key: 'user_name');
    String format(DateTime d) =>
        "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";
    final dateNow = DateTime.now();
    if (mounted) {
      setState(() {
        username = storedUsername ?? 'User';
      });
    }
    print('userId : ${userId}');
    print('companyCode : ${companyCode}');
    print('token : ${token}');
    if (userId != null && companyCode != null && token != null) {
      context.read<AdminhomeBloc>().add(
        FetchcompanyEvent(token: token, companyCode: companyCode),
      );
      context.read<ReportBloc>().add(
        FetchEditHistoryEvent(
          token: token,
          companyCode: companyCode,
          startDate: format(dateNow),
          endDate: format(dateNow),
        ),
      );
    } else {
      debugPrint('Missing userId or companyCode in storage');
    }
  }

  String _apiDateFromUI(String uiDate) {
    final parts = uiDate.split('-'); // dd-MM-yyyy
    return "${parts[2]}-${parts[1]}-${parts[0]}";
  }

  void _openDatePopup() {
    showDateRangePopup(
      context: context,
      startDateController: startDateController,
      endDateController: endDateController,
      onSave: () async {
        final companyCode = await storage.read(key: 'company_Code');
        final token = await storage.read(key: 'access_Token');
  
        if (companyCode != null && token != null) {
          context.read<AdminhomeBloc>().add(
            FetchcompanyEvent(
              token: token,
              companyCode: companyCode,
            ),
          );
  
          context.read<ReportBloc>().add(
            FetchEditHistoryEvent(
              token: token,
              companyCode: companyCode,
              startDate: _apiDateFromUI(startDateController.text),
              endDate: _apiDateFromUI(endDateController.text),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios_new_outlined),
        ),
        backgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello, ${username}!',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Welcome',
              style: TextStyle(
                color: const Color(0xFFBFBFBF),
                fontSize: 14.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        actions: [
          BlocBuilder<AdminhomeBloc, AdminhomeState>(
            builder: (context, state) {
              if (state is AdmincompanyLoaded &&
                  state.companyDetails.imageLightMode != null &&
                  state.companyDetails.imageLightMode!.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Image.network(
                    state.companyDetails.imageLightMode!,
                    width: 115.w,
                    height: 35.h,
                  ),
                );
              }
              return SizedBox();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: BlocBuilder<ReportBloc, ReportState>(
            builder: (context, state) {
              if (state is ReportLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is ReportError) {
                return Center(child: Text('Failed to load data'));
              }
              if (state is EditHistoryLoaded) {
                adminEditHistory = state.admineditHistory;

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: 362.w,
                        child: Column(
                          children: [
                            SizedBox(height: 30.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Edit History',
                                  style: TextStyle(
                                    color: const Color(0xFF150A33),
                                    fontSize: 16.sp,
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.filter_alt_outlined),
                                  onPressed: _openDatePopup,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Item Wise Report
                      Container(
                        width: 362.w,
                        child: Column(
                          children: [
                            
                            SizedBox(height: 10.h),
                            Container(
                              width: 362.w,
                              // height: 230.h,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 1,
                                    color: const Color(0xFFF0F0F0),
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 20,
                                  ),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: ConstrainedBox(
                                      constraints: BoxConstraints(
                                        minWidth: MediaQuery.of(context).size.width,
                                      ),
                                    child: Table(
                                      columnWidths: const {
                                        0: FlexColumnWidth(1.7),
                                        1: FlexColumnWidth(1.7),
                                        2: FlexColumnWidth(1.9),
                                      },
                                      border: TableBorder.all(
                                        color: const Color(0xFFE7E7E7),
                                        width: 1,
                                      ),
                                      children: [
                                        TableRow(
                                          children: [
                                            _tableText('Edited Date'),
                                            _tableText('Edited By'),
                                            _tableText('Edited Details'),
                                          ],
                                        ),
                                        if (adminEditHistory.isEmpty)
                                          TableRow(
                                            children: [
                                              _tableText('-'),
                                              _tableValue('-'),
                                              _tableValue('-'),
                                            ],
                                          ),
                                    
                                        // Data rows
                                        if (adminEditHistory.isNotEmpty)
                                          ...adminEditHistory.map((entry) {
                                            return TableRow(
                                              children: [
                                                _dateTimeCell(entry),
                                                _tableValue(
                                                  entry.editedBy.toString(),
                                                ),
                                                _detailsCell(entry.editedDetails),
                                              ],
                                            );
                                          }).toList(),
                                      ],
                                    ),)
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}

Widget _tableText(String data) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
    child: Text(
      data,
      style: TextStyle(
        color: const Color(0xFF150A33),
        fontSize: 16.sp,
        fontFamily: 'DM Sans',
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

Widget _tableValue(String data) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
    child: Text(
      data,
      style: TextStyle(
        color: const Color(0xFF150A33),
        fontSize: 14.sp,
        fontFamily: 'DM Sans',
      ),
    ),
  );
}

Widget _detailsCell(List<EditedDetails>? details) {
  if (details == null || details.isEmpty) {
    return const Padding(
      padding: EdgeInsets.all(10),
      child: Text('No changes'),
    );
  }

  final List<Widget> children = [];

  children.add(
    const Text(
      'Changes:',
      style: TextStyle(fontWeight: FontWeight.w500),
    ),
  );

  for (final detail in details) {
    _buildEditedDetail(detail, children);
  }

  return Padding(
    padding: const EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    ),
  );
}


Widget _bullet(String text) {
  return Padding(
    padding: const EdgeInsets.only(left: 14, top: 2),
    child: Text(
      '• $text',
      style: const TextStyle(fontSize: 12),
    ),
  );
}

Widget _dateTimeCell(AdminEditHistory entry) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
    child: Text(
      "${entry.editedDate}\n${entry.editedTime}",
      style: TextStyle(
        fontSize: 13.sp,
        fontFamily: 'DM Sans',
      ),
    ),
  );
}

void _buildEditedDetail(EditedDetails detail, List<Widget> children) {
  // Title
  children.add(
    Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Text(
        formatTitle(detail.title),
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
    ),
  );

  final value = detail.value;

  // Map
  if (value is Map) {
    value.forEach((k, v) {
      _renderValue(k, v, children);
    });
  }

  // List
  else if (value is List) {
    for (final item in value) {
      children.add(_bullet(item.toString()));
    }
  }

  // Primitive
  else {
    children.add(_bullet(value.toString()));
  }
}

void _renderValue(String key, dynamic value, List<Widget> children) {
  // Old → New values
  if (value is Map &&
      value.containsKey('old_value') &&
      value.containsKey('new_value')) {
    children.add(
      _bullet('${value['old_value']} → ${value['new_value']}'),
    );
    return;
  }

  // Cloth added / removed / price changes
  if (value is List) {
    for (final item in value) {
      if (item is Map) {
        final name = item['name'];
        final qty = item['quantity'];
        final oldPrice = item['oldPrice'];
        final newPrice = item['newPrice'];

        if (qty != null) {
          children.add(_bullet('$name (Qty: $qty)'));
        } else if (oldPrice != null && newPrice != null) {
          children.add(_bullet(
              '$name : $oldPrice → $newPrice'));
        } else {
          children.add(_bullet(item.values.join(', ')));
        }
      } else {
        children.add(_bullet(item.toString()));
      }
    }
    return;
  }

  // Simple key-value
  children.add(
    _bullet('${formatTitle(key)} : $value'),
  );
}
// to remove underscroces
String formatTitle(String raw) {
  return raw
      .replaceAll('_', ' ')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim()
      .split(' ')
      .map((w) => w.isEmpty
          ? w
          : w[0].toUpperCase() + w.substring(1))
      .join(' ');
}
