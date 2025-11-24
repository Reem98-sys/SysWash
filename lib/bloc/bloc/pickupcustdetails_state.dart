part of 'pickupcustdetails_bloc.dart';

@immutable
sealed class PickupcustdetailsState {}

final class PickupcustdetailsInitial extends PickupcustdetailsState {}
class PickupCustDetailsLoading extends PickupcustdetailsState {}
class PickupCustDetailsLoaded extends PickupcustdetailsState {}
class PickupCustDetailsError extends PickupcustdetailsState {}
