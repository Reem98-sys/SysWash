part of 'admingraph_bloc.dart';

@immutable
sealed class AdmingraphEvent {}

class FetchSalesGraphEvent extends AdmingraphEvent {
  final String token;
  final String companyCode;
  var branch;
  FetchSalesGraphEvent({required this.token, required this.companyCode, required this.branch});
}
