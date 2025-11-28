part of 'servicedetails_bloc.dart';

@immutable
sealed class ServicedetailsState {}

final class ServicedetailsInitial extends ServicedetailsState {}
class ServicedetailsLoading extends ServicedetailsState {}
class ServicedetailsLoaded extends ServicedetailsState {
  final List<ServiceDetailsModel> servicedetailModel;
  ServicedetailsLoaded({required this.servicedetailModel});
}
class ServicedetailsError extends ServicedetailsState {
  final String message;
  ServicedetailsError(this.message);
}