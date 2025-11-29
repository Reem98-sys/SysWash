import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:syswash/model/settingsModel.dart';
import 'package:syswash/repositories/sys_repository.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  
  SysRepository sysRepository = SysRepository();
  SettingsBloc() : super(SettingsInitial()) {
    on<FetchSettingsEvent>((event, emit) async {
      emit(SettingsBlocLoading());
      try {
        final settingsModel = await sysRepository.settingsData(event.companyCode, event.token);
        emit(SettingsBlocLoaded(settingsModel: settingsModel));
      } catch (e) {
        emit(SettingsBlocError());
      }
    });
  }
}
