part of 'reportlist_bloc.dart';

@immutable
sealed class ReportlistState {}

final class ReportlistInitial extends ReportlistState {}
class ReportListLoading extends ReportlistState {}
class UsertypeLoaded extends ReportlistState {
  final UserType userType;
  UsertypeLoaded({required this.userType});
}
class ReportListError extends ReportlistState {}