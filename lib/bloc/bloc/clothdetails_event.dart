part of 'clothdetails_bloc.dart';

@immutable
sealed class ClothdetailsEvent {}
class FetchClothDetailsEvent extends ClothdetailsEvent {
  final String companyCode;
  final String token;
  final String servicetype;
  FetchClothDetailsEvent({required this.servicetype,required this.token,required this.companyCode,});
}