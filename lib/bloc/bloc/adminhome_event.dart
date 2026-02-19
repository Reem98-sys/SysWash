part of 'adminhome_bloc.dart';

@immutable
sealed class AdminhomeEvent {}

class FetchtotalsaleEvent extends AdminhomeEvent {
  final String token;
  final String companyCode;
  var branch;
  FetchtotalsaleEvent({required this.token, required this.companyCode, required this.branch});
}
class FetchcompanyEvent extends AdminhomeEvent {
  final String token;
  final String companyCode;
  FetchcompanyEvent({required this.token, required this.companyCode});
}




