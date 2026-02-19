part of 'adminbranch_bloc.dart';

@immutable
sealed class AdminbranchState {}

final class AdminbranchInitial extends AdminbranchState {}
class AdminBranchLoading extends AdminbranchState {}
class AdminBranchLoaded extends AdminbranchState {
  final AdminBranch adminBranch;
  AdminBranchLoaded({
    required this.adminBranch,
    });
}
class AdminBranchError extends AdminbranchState {}