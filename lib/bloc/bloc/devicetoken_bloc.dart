import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:syswash/repositories/sys_repository.dart';

part 'devicetoken_event.dart';
part 'devicetoken_state.dart';

class DevicetokenBloc extends Bloc<DevicetokenEvent, DevicetokenState> {
  SysRepository sysRepository = SysRepository();
  DevicetokenBloc() : super(DevicetokenInitial()) {
    on<FetchDeviceTokenEvent>((event, emit) async {
      emit(DeviceTokenLoading());
      try {
        final result = await sysRepository.adddevicetoken(event.userID, event.companyCode, event.token, event.devicetoken);
        if (result != '') {
          emit(DeviceTokenLoaded(message: result));
        }
        else {
          emit(DeviceTokenError(message: 'Unable to register'));
        }
      } catch (e) {
        emit(DeviceTokenError(message: e.toString()));
      }
    });
    on<FetchAdminDeviceTokenEvent>((event, emit) async {
      emit(DeviceTokenLoading());
      try {
        final result = await sysRepository.adminadddevicetoken(event.userID, event.companyCode, event.token, event.devicetoken);
        if (result != '') {
          emit(AdminDeviceTokenLoaded(message: result));
        }
        else {
          emit(DeviceTokenError(message: 'Unable to register'));
        }
      } catch (e) {
        emit(DeviceTokenError(message: e.toString()));
      }
    });
  }
}
