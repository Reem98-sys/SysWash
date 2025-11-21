part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}
class LoginBlocLoading extends LoginState {} 
class LoginBlocLoaded extends LoginState {} 
class LoginBlocError extends LoginState {
  final String message;
  LoginBlocError(this.message);
} 