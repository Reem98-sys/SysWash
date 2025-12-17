part of 'forgotpass_bloc.dart';

@immutable
sealed class ForgotpassState {}

final class ForgotpassInitial extends ForgotpassState {}
class ForgotpassLoading extends ForgotpassState {}
class ForgotpassLoaded extends ForgotpassState {
  final String message;
  ForgotpassLoaded(this.message);
}
class ForgotpassError extends ForgotpassState {
  final String message;
  ForgotpassError(this.message);
}
class ResetpassLoaded extends ForgotpassState {
  final String message;
  ResetpassLoaded(this.message);
}