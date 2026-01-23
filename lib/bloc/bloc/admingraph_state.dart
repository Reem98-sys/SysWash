part of 'admingraph_bloc.dart';

@immutable
sealed class AdmingraphState {}

final class AdmingraphInitial extends AdmingraphState {}
class AdmingraphLoading extends AdmingraphState {}
class AdmingraphLoaded extends AdmingraphState {
  final List<SalesGraph> salesGraph;
  AdmingraphLoaded({
    required this.salesGraph
    });
}
class AdmingraphError extends AdmingraphState {}