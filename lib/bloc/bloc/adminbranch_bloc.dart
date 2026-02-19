import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:syswash/model/adminBranch.dart';
import 'package:syswash/repositories/sys_repository.dart';

part 'adminbranch_event.dart';
part 'adminbranch_state.dart';

class AdminbranchBloc extends Bloc<AdminbranchEvent, AdminbranchState> {
  AdminbranchBloc() : super(AdminbranchInitial()) {
    SysRepository sysRepository = SysRepository();
    late AdminBranch adminBranch;
    on<FetchBranchEvent>((event, emit) async {
      emit(AdminBranchLoading());
      try {
        adminBranch = await sysRepository.adminBranch(event.token,event.companyCode);
        emit(AdminBranchLoaded(
          adminBranch: adminBranch,
          ));
      } catch (e) {
        print(e);
        emit(AdminBranchError());
      }
    });
  }
}
