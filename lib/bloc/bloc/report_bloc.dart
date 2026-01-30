import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:syswash/model/accounttype.dart';
import 'package:syswash/model/cashLedger.dart';
import 'package:syswash/model/expCategory.dart';
import 'package:syswash/model/expenseReport.dart';
import 'package:syswash/model/orderReport.dart';
import 'package:syswash/model/salesReport.dart';
import 'package:syswash/model/userType.dart';
import 'package:syswash/repositories/sys_repository.dart';

part 'report_event.dart';
part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  SysRepository sysRepository = SysRepository();
  late UserType userType;
  late List<ExpCategory> expCategory;
  late OrderReport orderReport;
  late List<AccountType> accountType;
  late List<SalesReport> salesReport;
  late List<CashLedger> cashLedger;
  late List<ExpenseReport> expenseReport;
  ReportBloc() : super(ReportInitial()) {
    on<FetchReportEvent>((event, emit) async {
      emit(ReportLoading());
      try {
        accountType = await sysRepository.adminaccounttype(event.token, event.companyCode);
        orderReport = await sysRepository.adminorderreport(event.token, event.companyCode,event.datenow);
        emit(ReportLoaded(orderReport: orderReport, accountType: accountType));
      } catch (e) {
        print(e);
        emit(ReportError());
      }
    });

    on<FetchSalesReportEvent>((event, emit) async {
      emit(ReportLoading());
      try {
        accountType = await sysRepository.adminaccounttype(event.token, event.companyCode);
        salesReport = await sysRepository.adminsalesreport(event.token, event.companyCode,event.datenow);
        emit(SalesReportLoaded(salesReport: salesReport, accountType: accountType));
      } catch (e) {
        print(e);
        emit(ReportError());
      }
    });

    on<FetchCashLedgerEvent>((event, emit) async {
      emit(ReportLoading());
      try {
        cashLedger = await sysRepository.Admincashlegder(event.token, event.companyCode,event.datenow);
        emit(CashLedgerReportLoaded(cashLedger: cashLedger));
      } catch (e) {
        print(e);
        emit(ReportError());
      }
    });

    on<FetchExpenseReportEvent>((event, emit) async {
      emit(ReportLoading());
      try {
        expCategory = await sysRepository.adminexpCategory(event.token, event.companyCode);
        expenseReport = await sysRepository.adminexpense(event.token, event.companyCode,event.startDate,event.endDate);
        emit(ExpenseReportLoaded(expenseReport: expenseReport,expCategory: expCategory));
      } catch (e) {
        print(e);
        emit(ReportError());
      }
    });

    on<FetchUserTypeEvent>((event, emit) async {
      emit(ReportLoading());
      try {
        userType = await sysRepository.adminusertype(event.token, event.companyCode);
        emit(UsertypeLoaded(userType: userType));
      } catch (e) {
        print(e);
        emit(ReportError());
      }
    });
  }
}
