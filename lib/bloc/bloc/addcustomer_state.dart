part of 'addcustomer_bloc.dart';

@immutable
sealed class AddcustomerState {}

final class AddcustomerInitial extends AddcustomerState {}
class AddcustomerLoading extends AddcustomerState {}
class AddcustomerLoaded extends AddcustomerState {}
class AddcustomerError extends AddcustomerState {}