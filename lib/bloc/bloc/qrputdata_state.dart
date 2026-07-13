part of 'qrputdata_bloc.dart';

@immutable
sealed class QrputdataState {}

final class QrputdataInitial extends QrputdataState {}
class QrputdataBlocLoading extends QrputdataState {}
class QrputdataBlocLoaded extends QrputdataState {
  final String message;
  QrputdataBlocLoaded({required this.message});
}
class QrputdataBlocError extends QrputdataState {}