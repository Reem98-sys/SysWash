part of 'report_bloc.dart';

@immutable
sealed class ReportEvent {}

class FetchUserTypeEvent extends ReportEvent {
  final String token;
  final String companyCode;
  FetchUserTypeEvent({required this.token,required this.companyCode});
}

class FetchReportEvent extends ReportEvent {
  final String token;
  final String companyCode;
  final String datenow;
  FetchReportEvent({required this.token,required this.companyCode,required this.datenow});
}

class FetchSalesReportEvent extends ReportEvent {
  final String token;
  final String companyCode;
  final String datenow;
  FetchSalesReportEvent({required this.token,required this.companyCode,required this.datenow});
}

class FetchCashLedgerEvent extends ReportEvent {
  final String token;
  final String companyCode;
  final String datenow;
  FetchCashLedgerEvent({required this.token,required this.companyCode,required this.datenow});
}

class FetchExpenseReportEvent extends ReportEvent {
  final String token;
  final String companyCode;
  final String startDate;
  final String endDate;
  FetchExpenseReportEvent({required this.token,required this.companyCode,required this.startDate,required this.endDate});
}

class FetchTransactionReportEvent extends ReportEvent {
  final String token;
  final String companyCode;
  final String startDate;
  final String endDate;
  FetchTransactionReportEvent({required this.token,required this.companyCode,required this.startDate,required this.endDate});
}

class FetchOutstandingReportEvent extends ReportEvent {
  final String token;
  final String companyCode;
  final String startDate;
  final String endDate;
  FetchOutstandingReportEvent({required this.token,required this.companyCode,required this.startDate,required this.endDate});
}

class FetchEmployeeReportEvent extends ReportEvent {
  final String token;
  final String companyCode;
  FetchEmployeeReportEvent({required this.token,required this.companyCode});
}

class FetchDriverReportEvent extends ReportEvent {
  final String token;
  final String companyCode;
  final String startDate;
  final String endDate;
  FetchDriverReportEvent({required this.token,required this.companyCode,required this.startDate,required this.endDate});
}