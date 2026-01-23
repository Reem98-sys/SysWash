part of 'adminclosereport_bloc.dart';

@immutable
sealed class AdminclosereportEvent {}
class FetchClosingReportEvent extends AdminclosereportEvent {
  final String token;
  final String companyCode;
  final String startDate;
  final String endDate;
  FetchClosingReportEvent({
    required this.token,
    required this.companyCode,
    required this.startDate,
    required this.endDate,
  });
}