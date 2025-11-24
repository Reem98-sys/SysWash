import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:syswash/model/customer_list_response.dart';
import 'package:syswash/repositories/sys_repository.dart';

part 'customerlist_event.dart';
part 'customerlist_state.dart';

class CustomerlistBloc extends Bloc<CustomerlistEvent, CustomerlistState> {
  SysRepository sysRepository = SysRepository();
  CustomerlistBloc() : super(CustomerlistInitial()) {
    on<FetchCustomerListEvent>((event, emit) async {
      print('===============================');
      emit(CustomerListBlocLoading());
      print('--------------------------------');
      try {
        print('00000000000000000000000000000000000');
        final customerListModel = await sysRepository.customerList(event.token);
        print('1111111111111111111111111111111111111');
        emit(CustomerListBlocLoaded(customerListModel: customerListModel));
      } catch (e) {
        emit(CustomerListBlocError());
      }
    });
  }
}
