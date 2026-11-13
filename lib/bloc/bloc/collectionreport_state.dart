part of 'collectionreport_bloc.dart';

@immutable
sealed class CollectionreportState {}

final class CollectionreportInitial extends CollectionreportState {}
class CollectionreportLoading extends CollectionreportState {}
class CollectionreportLoaded extends CollectionreportState {
  final List<CollectionReportModel> collectionReportModel;
  CollectionreportLoaded({required this.collectionReportModel});
}
class CollectionreportError extends CollectionreportState {}