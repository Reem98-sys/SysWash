import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:syswash/model/pickupCustomerDetailsModel.dart';
import 'package:syswash/repositories/sys_repository.dart';

part 'pickupcustdetails_event.dart';
part 'pickupcustdetails_state.dart';

class PickupcustdetailsBloc extends Bloc<PickupcustdetailsEvent, PickupcustdetailsState> {
  late PickUpCustomerDetailsModel pickUpCustomerDetailsModel;
  SysRepository sysRepository = SysRepository();
  PickupcustdetailsBloc() : super(PickupcustdetailsInitial()) {
    on<FetchPickipCustDetailsEvent>((event, emit) async {
      emit(PickupCustDetailsLoading());
      try {
        pickUpCustomerDetailsModel = await sysRepository.pickupcustomerdetails(event.pickupassgnId, event.token, event.companyCode);
        emit(PickupCustDetailsLoading());
      } catch (e) {
        emit(PickupCustDetailsError());
      }
    });
  }
}
