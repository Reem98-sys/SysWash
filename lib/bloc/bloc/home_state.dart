part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}
class HomeBlocLoading extends HomeState {}
class HomeBlocLoaded extends HomeState {
  final TotalOrderModel totalOrderModel;
  HomeBlocLoaded({required this.totalOrderModel});
}
class HomeBlocError extends HomeState {}
