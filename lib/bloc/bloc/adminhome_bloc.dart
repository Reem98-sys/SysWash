import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:syswash/model/adminBranch.dart';
import 'package:syswash/model/companydetailsModel.dart';
import 'package:syswash/model/expensecategorymodel.dart';
import 'package:syswash/model/totalCountModel.dart';
import 'package:syswash/repositories/sys_repository.dart';

part 'adminhome_event.dart';
part 'adminhome_state.dart';

class AdminhomeBloc extends Bloc<AdminhomeEvent, AdminhomeState> {
  SysRepository sysRepository = SysRepository(); 
  late TotalCount totalCount;
  late CompanyDetails companyDetails;
  late ExpenseCategoryModel expenseCategoryModel;
  AdminhomeBloc() : super(AdminhomeInitial()) {
    on<FetchtotalsaleEvent>((event, emit) async {
      emit(AdmintotalsaleLoading());
      try {
        var result = await sysRepository.admintotalsale(event.token, event.companyCode,event.branch);
        // totalCount = await sysRepository.admintotalcount(event.token, event.companyCode);
        expenseCategoryModel = await sysRepository.expensecategory(event.token, event.companyCode, event.branch);
        companyDetails = await sysRepository.admincompany(event.token,event.companyCode);
        emit(AdmintotalsaleLoaded(
          totalSaleData: result,
          // totalCount: totalCount,
          companyDetails: companyDetails,
          expenseCategoryModel: expenseCategoryModel
          ));
      } catch (e) {
        print(e);
        emit(AdmintotalsaleError());
      }
    });
    on<FetchcompanyEvent>((event, emit) async {
      emit(AdmintotalsaleLoading());
      try {
        companyDetails = await sysRepository.admincompany(event.token,event.companyCode);
        emit(AdmincompanyLoaded(
          companyDetails: companyDetails,
          ));
      } catch (e) {
        print(e);
        emit(AdmintotalsaleError());
      }
    });
  }
}
