import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:syswash/model/totalOrder.dart';
import 'package:syswash/repositories/sys_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  late TotalOrderModel totalOrderModel;
  SysRepository sysRepository = SysRepository();
  HomeBloc() : super(HomeInitial()) {
    on<FetchHomeEvent>((event, emit) async {
      emit(HomeBlocLoading());
      try {
        totalOrderModel = await sysRepository.totalOrder(event.userId, event.companyCode,event.token);
        emit(HomeBlocLoaded());
      } catch (e) {
        emit(HomeBlocError());
      }
    });
  }
}
