part of 'adminclosereport_bloc.dart';

@immutable
sealed class AdminclosereportState {}

final class AdminclosereportInitial extends AdminclosereportState {}
class AdminClosingReportLoading extends AdminclosereportState {}
class AdminClosingReportLoaded extends AdminclosereportState {
  final ClosingReport closingReport;
  AdminClosingReportLoaded({
    required this.closingReport,
    });
}
class AdminClosingReportError extends AdminclosereportState {}