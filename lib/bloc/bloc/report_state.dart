part of 'report_bloc.dart';

@immutable
sealed class ReportState {}

final class ReportInitial extends ReportState {}
class ReportLoading extends ReportState {}
class ReportLoaded extends ReportState {
  final List<OrderReport> orderReport;
  final List<AccountType> accountType;
  ReportLoaded({required this.orderReport,required this.accountType});
}
class SalesReportLoaded extends ReportState {
  final List<SalesReport> salesReport;
  final List<AccountType> accountType;
  SalesReportLoaded({required this.salesReport,required this.accountType});
}
class CashLedgerReportLoaded extends ReportState {
  final List<CashLedger> cashLedger;
  CashLedgerReportLoaded({required this.cashLedger});
}
class ExpenseReportLoaded extends ReportState {
  final List<ExpenseReport> expenseReport;
  final List<ExpCategory> expCategory;
  ExpenseReportLoaded({required this.expenseReport,required this.expCategory});
}
class TransactionReportLoaded extends ReportState {
  final List<TransactionModel> transactionModel;
  TransactionReportLoaded({required this.transactionModel});
}
class OutstandingReportLoaded extends ReportState {
  final List<OutstandingModel> outstandingModel;
  final List<AccountType> accountType;
  OutstandingReportLoaded({required this.outstandingModel,required this.accountType});
}
class EmployeeReportLoaded extends ReportState {
  final EmployeeReport employeeReport;
  EmployeeReportLoaded({required this.employeeReport});
}
class DriverReportLoaded extends ReportState {
  final DriverReport driverReport;
  DriverReportLoaded({required this.driverReport});
}
class ItemWiseLoaded extends ReportState {
  final List<ItemWise> itemWise;
  ItemWiseLoaded({required this.itemWise});
}
class ClosingReportLoaded extends ReportState {
  final AdminClosingReport adminClosingReport;
  final List<ServiceDetailsModel> servicedetail;
  ClosingReportLoaded({required this.adminClosingReport,required this.servicedetail});
}
class EditHistoryLoaded extends ReportState {
  final List<AdminEditHistory> admineditHistory;
  EditHistoryLoaded({required this.admineditHistory});
}
class ReportError extends ReportState {}