part of 'report_bloc.dart';

@immutable
sealed class ReportState {}

final class ReportInitial extends ReportState {}
class ReportLoading extends ReportState {}
class ReportLoaded extends ReportState {
  final OrderReport orderReport;
  ReportLoaded({required this.orderReport});
}
class SalesReportLoaded extends ReportState {
  final List<SalesReport> salesReport;
  SalesReportLoaded({required this.salesReport});
}
class CashLedgerReportLoaded extends ReportState {
  final List<CashLedger> cashLedger;
  CashLedgerReportLoaded({required this.cashLedger});
}
class ExpenseReportLoaded extends ReportState {
  final List<ExpenseReport> expenseReport;
  ExpenseReportLoaded({required this.expenseReport});
}
class ReportError extends ReportState {}