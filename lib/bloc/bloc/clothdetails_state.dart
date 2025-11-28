part of 'clothdetails_bloc.dart';

@immutable
sealed class ClothdetailsState {}

final class ClothdetailsInitial extends ClothdetailsState {}
class ClothDetailsLoading extends ClothdetailsState {}
class ClothDetailsLoaded extends ClothdetailsState {
 final ClothDetailsModel clothDetailsModelList;

  ClothDetailsLoaded({required this.clothDetailsModelList});
}
class ClothDetailsError extends ClothdetailsState {
  final String message;
  ClothDetailsError({required this.message});
}