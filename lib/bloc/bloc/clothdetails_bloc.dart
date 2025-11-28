import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:syswash/model/clothDetailsModel.dart';
import 'package:syswash/repositories/sys_repository.dart';

part 'clothdetails_event.dart';
part 'clothdetails_state.dart';

class ClothdetailsBloc extends Bloc<ClothdetailsEvent, ClothdetailsState> {
  // late ClothDetailsModel clothDetailsModel;
  SysRepository sysRepository = SysRepository();
  ClothdetailsBloc() : super(ClothdetailsInitial()) {
    on<FetchClothDetailsEvent>((event, emit) async {
      emit(ClothDetailsLoading());
      try {
        final clothdetailsModel = await sysRepository.clothdetailsList(event.servicetype,event.token,event.companyCode);
         emit(ClothDetailsLoaded(clothDetailsModelList: clothdetailsModel));

      } catch (e,stackTrace) {
        print("❌ Error in Clothdetails: $e");
        print("📜 StackTrace: $stackTrace");
        emit(ClothDetailsError(message: e.toString()));
      }
    });
  }
}
