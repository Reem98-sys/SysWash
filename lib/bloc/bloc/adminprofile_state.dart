part of 'adminprofile_bloc.dart';

@immutable
sealed class AdminprofileState {}

final class AdminprofileInitial extends AdminprofileState {}
class AdminProfileLoading extends AdminprofileState {}
class AdminProfileLoaded extends AdminprofileState {
  final AdminProfile adminProfile;
  AdminProfileLoaded({required this.adminProfile});
}
class UpdateProfileLoaded extends AdminprofileState {}
class ChangePassLoaded extends AdminprofileState {
  final String message;
  ChangePassLoaded({required this.message});
}
class ChangePassError extends AdminprofileState {
  final String message;
  ChangePassError({required this.message});
}
class AdminProfileError extends AdminprofileState {}