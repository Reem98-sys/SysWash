import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:syswash/model/collectionReportModel.dart';
import 'package:syswash/repositories/sys_repository.dart';

part 'collectionreport_event.dart';
part 'collectionreport_state.dart';

class CollectionreportBloc extends Bloc<CollectionreportEvent, CollectionreportState> {
  SysRepository sysRepository = SysRepository();
  late List<CollectionReportModel> collectionReportModel;
  CollectionreportBloc() : super(CollectionreportInitial()) {
    on<FetchCollectionreportEvent>((event, emit) async {
      emit(CollectionreportLoading());
      try {
        collectionReportModel = await sysRepository.collectionreportapi(
          event.userId,
          event.token,
          event.companyCode,
          event.startDate,
          event.endDate
        );
        emit(CollectionreportLoaded(collectionReportModel: collectionReportModel));
      } catch (e) {
        print(e);
        emit(CollectionreportError());
      }
    });
  }
}
