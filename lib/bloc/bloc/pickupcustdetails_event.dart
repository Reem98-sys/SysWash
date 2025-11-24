part of 'pickupcustdetails_bloc.dart';

@immutable
sealed class PickupcustdetailsEvent {}
class FetchPickipCustDetailsEvent extends PickupcustdetailsEvent{
  final String pickupassgnId;
  final String token;
  final String companyCode;
  FetchPickipCustDetailsEvent({required this.pickupassgnId, required this.token, required this.companyCode});
}