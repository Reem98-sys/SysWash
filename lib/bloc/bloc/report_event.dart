part of 'report_bloc.dart';

@immutable
sealed class ReportEvent {}



class FetchReportEvent extends ReportEvent {
  final String token;
  final String companyCode;
  final String startDate;
  final String endDate;
  FetchReportEvent({required this.token,required this.companyCode,required this.startDate,required this.endDate});
}

class FetchSalesReportEvent extends ReportEvent {
  final String token;
  final String companyCode;
  final String startDate;
  final String endDate;
  FetchSalesReportEvent({required this.token,required this.companyCode,required this.startDate,required this.endDate});
}

class FetchCashLedgerEvent extends ReportEvent {
  final String token;
  final String companyCode;
  final String startDate;
  final String endDate;
  FetchCashLedgerEvent({required this.token,required this.companyCode,required this.startDate,required this.endDate});
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

class FetchItemWiseReportEvent extends ReportEvent {
  final String token;
  final String companyCode;
  final String startDate;
  final String endDate;
  FetchItemWiseReportEvent({required this.token,required this.companyCode,required this.startDate,required this.endDate});
}

class FetchCloseEvent extends ReportEvent {
  final String token;
  final String companyCode;
  final String startDate;
  final String endDate;
  FetchCloseEvent({required this.token,required this.companyCode,required this.startDate,required this.endDate});
}

class FetchEditHistoryEvent extends ReportEvent {
  final String token;
  final String companyCode;
  final String startDate;
  final String endDate;
  FetchEditHistoryEvent({required this.token,required this.companyCode,required this.startDate,required this.endDate});
}