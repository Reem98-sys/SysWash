part of 'servicedetails_bloc.dart';

@immutable
sealed class ServicedetailsEvent {}
class FetchServiceDetailsEvent extends ServicedetailsEvent {
  final String token;
  final String companyCode;
  FetchServiceDetailsEvent({required this.token,required this.companyCode});
}