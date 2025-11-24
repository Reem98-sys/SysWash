part of 'customerlist_bloc.dart';

@immutable
sealed class CustomerlistState {}

final class CustomerlistInitial extends CustomerlistState {}
class CustomerListBlocLoading extends CustomerlistState {}
class CustomerListBlocLoaded extends CustomerlistState {
  final CustomerListResponse? customerListModel;
  CustomerListBlocLoaded({required this.customerListModel});
}
class CustomerListBlocError extends CustomerlistState {}
