part of 'reportlist_bloc.dart';

@immutable
sealed class ReportlistEvent {}

class FetchUserTypeEvent extends ReportlistEvent {
  final String token;
  final String companyCode;
  FetchUserTypeEvent({required this.token,required this.companyCode});
}