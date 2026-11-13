part of 'collectionreport_bloc.dart';

@immutable
sealed class CollectionreportEvent {}
class FetchCollectionreportEvent extends CollectionreportEvent {
  final String userId;
  final String token;
  final String companyCode;
  final String startDate;
  final String endDate;

  FetchCollectionreportEvent({
    required this.userId,
    required this.token,
    required this.companyCode,
    required this.startDate,
    required this.endDate,
  });
}