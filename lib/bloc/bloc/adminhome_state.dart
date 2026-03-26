part of 'adminhome_bloc.dart';

@immutable
sealed class AdminhomeState {}

final class AdminhomeInitial extends AdminhomeState {}
class AdmintotalsaleLoading extends AdminhomeState {}
class AdmintotalsaleLoaded extends AdminhomeState {
  final Map<String,dynamic> totalSaleData;
  // final TotalCount totalCount;
  final ExpenseCategoryModel expenseCategoryModel;
  final CompanyDetails companyDetails;
  AdmintotalsaleLoaded({
    required this.totalSaleData,
    // required this.totalCount,
    required this.companyDetails,
    required this.expenseCategoryModel
    });
}
class AdmincompanyLoaded extends AdminhomeState {
  final CompanyDetails companyDetails;
  AdmincompanyLoaded({
    required this.companyDetails,
    });
}
class AdmintotalsaleError extends AdminhomeState {}