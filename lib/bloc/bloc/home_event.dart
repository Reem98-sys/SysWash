part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}
class FetchHomeEvent extends HomeEvent {
  final String userId;
  final String companyCode;
  final String token;
  FetchHomeEvent({required this.userId, required this.companyCode,required this.token});
}