part of 'uploadpickup_bloc.dart';

@immutable
sealed class UploadpickupState {}

final class UploadpickupInitial extends UploadpickupState {}
class UploadpickupLoading extends UploadpickupState {}
class UploadpickupLoaded extends UploadpickupState {
  final String message;
  UploadpickupLoaded({required this.message});
}
class UploadpickupError extends UploadpickupState {
  final String message;
  UploadpickupError({required this.message});
}