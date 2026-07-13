part of 'logout_bloc.dart';

@immutable
sealed class LogoutState {}

final class LogoutInitial extends LogoutState {}
class LogoutBlocLoading extends LogoutState {}
class LogoutBlocLoaded extends LogoutState {
  final String message;
  LogoutBlocLoaded({required this.message});
}
class LogoutBlocError extends LogoutState {}