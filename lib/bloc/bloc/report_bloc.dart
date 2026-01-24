import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:syswash/model/cashLedger.dart';
import 'package:syswash/model/expenseReport.dart';
import 'package:syswash/model/orderReport.dart';
import 'package:syswash/model/salesReport.dart';
import 'package:syswash/repositories/sys_repository.dart';

part 'report_event.dart';
part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  SysRepository sysRepository = SysRepository();
  late OrderReport orderReport;
  late List<SalesReport> salesReport;
  late List<CashLedger> cashLedger;
  late List<ExpenseReport> expenseReport;
  ReportBloc() : super(ReportInitial()) {
    on<FetchReportEvent>((event, emit) async {
      emit(ReportLoading());
      try {
        orderReport = await sysRepository.adminorderreport(event.token, event.companyCode,event.datenow);
        emit(ReportLoaded(orderReport: orderReport));
      } catch (e) {
        print(e);
        emit(ReportError());
      }
    });

    on<FetchSalesReportEvent>((event, emit) async {
      emit(ReportLoading());
      try {
        salesReport = await sysRepository.adminsalesreport(event.token, event.companyCode,event.datenow);
        emit(SalesReportLoaded(salesReport: salesReport));
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
        expenseReport = await sysRepository.Adminexpense(event.token, event.companyCode,event.datenow);
        emit(ExpenseReportLoaded(expenseReport: expenseReport));
      } catch (e) {
        print(e);
        emit(ReportError());
      }
    });
  }
}
