import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:syswash/bloc/bloc/notificationlist_bloc.dart';
import 'package:syswash/model/notificationlist.dart';

class Notificationlist extends StatefulWidget {
  const Notificationlist({super.key});

  @override
  State<Notificationlist> createState() => _NotificationlistState();
}

class _NotificationlistState extends State<Notificationlist> {
  late List<NotificationList> notificationList;
  final storage = const FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    _loadUserAndFetchData(); // run async function
  }

  String formatDate(String? date) {
    if (date == null) return '';

    DateTime parsedDate = DateTime.parse(date);
    return DateFormat('MMM d, hh:mm a').format(parsedDate);
  }

  Future<void> _loadUserAndFetchData() async {
    final userId = await storage.read(key: 'login_id');
    final companyCode = await storage.read(key: 'company_Code');
    final token = await storage.read(key: 'access_Token');
    final storedUsername = await storage.read(key: 'user_name');

    print('userId : ${userId}');
    print('companyCode : ${companyCode}');
    print('token : ${token}');
    if (userId != null && companyCode != null && token != null) {
      context.read<NotificationlistBloc>().add(
        FetchNotificationEvent(
          userId: userId,
          token: token,
          companyCode: companyCode,
        ),
      );
    } else {
      debugPrint('Missing userId or companyCode in storage');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back)),
        title: Text(
                "Notifications",
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              

              SizedBox(height: 15.h),

              Expanded(
                child: BlocBuilder<NotificationlistBloc, NotificationlistState>(
                  builder: (context, state) {
                    if (state is NotificationlistLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is NotificationlistLoaded) {
                      notificationList = state.notificationList;

                      return ListView.builder(
                        itemCount: notificationList.length,
                        itemBuilder: (context, index) {
                          final notification = notificationList[index];

                          return Container(
                            margin: EdgeInsets.only(bottom: 12.h),
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.04),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),

                            child: Row(
                              children: [
                                /// ICON
                                Container(
                                  width: 42.w,
                                  height: 42.h,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF5D5FEF),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: const Icon(
                                    Icons.notifications,
                                    color: Colors.white,
                                  ),
                                ),

                                SizedBox(width: 12.w),

                                /// TEXT SECTION
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children:[ Text(
                                          notification.title ?? '',
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                        Text(
                                      formatDate(notification.createdAt),
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        color: Colors.grey,
                                      ),
                                    ),]
                                      ),

                                      SizedBox(height: 4.h),

                                      Text(
                                        notification.body ?? '',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          color: Colors.grey[600],
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                
                               
                              ],
                            ),
                          );
                        },
                      );
                    }

                    if (state is NotificationlistError) {
                      return const Center(
                        child: Text("Failed to load notifications"),
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
