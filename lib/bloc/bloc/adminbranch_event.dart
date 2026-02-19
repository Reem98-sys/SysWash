part of 'adminbranch_bloc.dart';

@immutable
sealed class AdminbranchEvent {}
class FetchBranchEvent extends AdminbranchEvent {
  final String token;
  final String companyCode;
  FetchBranchEvent({required this.token, required this.companyCode});
}