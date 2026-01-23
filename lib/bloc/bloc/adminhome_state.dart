part of 'adminhome_bloc.dart';

@immutable
sealed class AdminhomeState {}

final class AdminhomeInitial extends AdminhomeState {}
class AdmintotalsaleLoading extends AdminhomeState {}
class AdmintotalsaleLoaded extends AdminhomeState {
  final double totalSale;
  final TotalCount totalCount;
  final CompanyDetails companyDetails;
  AdmintotalsaleLoaded({
    required this.totalSale,
    required this.totalCount,
    required this.companyDetails,
    });
}
class AdmincompanyLoaded extends AdminhomeState {
  final CompanyDetails companyDetails;
  AdmincompanyLoaded({
    required this.companyDetails,
    });
}
class AdmintotalsaleError extends AdminhomeState {}