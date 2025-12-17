import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:syswash/repositories/sys_repository.dart';

part 'uploadpickup_event.dart';
part 'uploadpickup_state.dart';

class UploadpickupBloc extends Bloc<UploadpickupEvent, UploadpickupState> {
  SysRepository sysRepository = SysRepository(); 

  UploadpickupBloc() : super(UploadpickupInitial()) {
    on<FetchUploadPickupEvent>((event, emit) async {
      emit(UploadpickupLoading());
      try {
        final result = await sysRepository.uploadPickupDatas(
          event.companyCode,
          event.token,
          event.notes,
          event.pickupCustomerArea,
          event.pickupCustomerCode,
          event.pickupCustomerId,
          event.pickupCustomerName,
          event.pickupCustomerPhno,
          event.pickupDate,
          event.pickupDriverid,
          event.pickupDrivername,
          event.remarks,
        );
        if (result) {
          emit(UploadpickupLoaded(message: 'Data Saved Successfully'));
        }
        else if (result!){
          emit(UploadpickupError(message: 'Unable to Upload'));
        }
        
      } catch (e, st) {
        emit(UploadpickupError(message: e.toString()));
      }
    });
  }
}
