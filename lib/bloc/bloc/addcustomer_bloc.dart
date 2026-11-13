import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:syswash/repositories/sys_repository.dart';

part 'addcustomer_event.dart';
part 'addcustomer_state.dart';

class AddcustomerBloc extends Bloc<AddcustomerEvent, AddcustomerState> {
  SysRepository sysRepository = SysRepository();
  AddcustomerBloc() : super(AddcustomerInitial()) {
    on<FetchAddcustomerEvent>((event, emit) async {
      emit(AddcustomerLoading());
      try {
        await sysRepository.addCustomer(
          event.token,
          event.username,
          event.companyCode,
          event.customerData,
        );
        emit(AddcustomerLoaded());
      } catch (e) {
        emit(AddcustomerError());
      }
    });
  }
}
