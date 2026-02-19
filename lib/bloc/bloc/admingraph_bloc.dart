import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:syswash/model/salesgraph.dart';
import 'package:syswash/repositories/sys_repository.dart';

part 'admingraph_event.dart';
part 'admingraph_state.dart';

class AdmingraphBloc extends Bloc<AdmingraphEvent, AdmingraphState> {
  late List<SalesGraph> salesGraph;
  SysRepository sysRepository = SysRepository();
  AdmingraphBloc() : super(AdmingraphInitial()) {
    on<FetchSalesGraphEvent>((event, emit) async {
      emit(AdmingraphLoading());
      try {
        salesGraph = await sysRepository.adminsalesgraph(event.token,event.companyCode,event.branch);
        emit(AdmingraphLoaded(
          salesGraph: salesGraph
          ));
      } catch (e,stackTrace) {
        print('AdmingraphBloc ERROR: $e');
  print('STACKTRACE: $stackTrace');
        emit(AdmingraphError());
      }
    });
  }
}
