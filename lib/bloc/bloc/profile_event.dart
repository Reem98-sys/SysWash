part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}
class FetchProfileEvent extends ProfileEvent {
  final String userId;
  final String companyCode;
  final String token;
  FetchProfileEvent({required this.userId,required this.companyCode,required this.token});
}