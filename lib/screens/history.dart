import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syswash/bloc/bloc/adminhome_bloc.dart';
import 'package:syswash/screens/bottomnav.dart';
import 'package:syswash/screens/historyDetail.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? userName;
  String? token;
  String? companyCode;
  String? userId;
  Future<void> getUserData() async {
    const storage = FlutterSecureStorage();
    final name = await storage.read(key: 'user_name');
    final tokenAccess = await storage.read(key: 'access_Token');
    final companycode = await storage.read(key: 'company_Code');
    final userid = await storage.read(key: 'login_id');
    setState(() {
      userName = name;
      token = tokenAccess;
      companyCode = companycode;
      userId = userid;
    });
    if (token != null && userId != null && companyCode != null) {
      
          context.read<AdminhomeBloc>().add(
        FetchcompanyEvent(token: token!, companyCode: companyCode!)
      );
    }
  }

  @override
  void initState() {
    super.initState();
    // Call it when screen loads
    getUserData();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<AdminhomeBloc, AdminhomeState>(
        builder: (context, state) {
          if (state is AdmincompanyLoaded &&
              state.companyDetails.imageLightMode != null &&
              state.companyDetails.imageLightMode!.isNotEmpty) {
            return Image.network(
              state.companyDetails.imageLightMode!,
              width: 150.w,
              height: 42.h,
              fit: BoxFit.contain,
            );
          }
          return SizedBox();
        },
                  ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 42.w,
              height: 42.w,
              decoration: BoxDecoration(
                color: const Color(0xFFE2E5F4),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.notifications_none_rounded),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight + 60.h), // total height of both widgets
          child: SizedBox(
            // height: 100.h,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 8.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'History',
                        style: TextStyle(
                          color: const Color(0xFF63629C),
                          fontSize: 16.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) =>
                                            const Bottomnav(currentIndex: 2),
                                  ),
                                );
                        },
                        child: SvgPicture.asset('assets/Back.svg'),
                      ),
                    ],
                  ),
                ),
                TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: const Color(0xFF68188B), // active tab background
                  ),
                  labelColor: Colors.white,
                  indicatorSize: TabBarIndicatorSize.tab,
                  unselectedLabelColor: Colors.grey,
                  dividerColor: Colors.transparent,
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                  tabs: const [Tab(text: "Pickup"), Tab(text: "Delivery")],
                ),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,

        children: const [
          Center(child: Historydetail(historyType: 'pickup',)),
          Center(child: Historydetail(historyType: 'delivery',)),
        ],
      ),
    );
  }
}
