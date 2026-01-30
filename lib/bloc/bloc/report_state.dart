part of 'report_bloc.dart';

@immutable
sealed class ReportState {}

final class ReportInitial extends ReportState {}
class ReportLoading extends ReportState {}
class UsertypeLoaded extends ReportState {
  final UserType userType;
  UsertypeLoaded({required this.userType});
}
class ReportLoaded extends ReportState {
  final OrderReport orderReport;
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
class ReportError extends ReportState {}