import 'package:bloc/bloc.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/application/enums/searchField.dart';
import 'package:phu_tho_mobile/di.dart';
import 'package:phu_tho_mobile/domain/models/request/advise/advise_request.dart';
import 'package:phu_tho_mobile/domain/repositories/advise_repository.dart';
import 'package:phu_tho_mobile/presentation/screens/consulting_job/conslting_state.dart';

class ConsultingCubit extends Cubit<ConsultingState> {
  ConsultingCubit() : super(const ConsultingState());

  final repo = getIt.get<AdviseRepository>();

  Future<void> getAllAdvise() async {
    try {
      emit(state.copyWith(status: LoadStatus.loading));
      final response = await repo.getAllAdvise(state.request);
      if (response.isRight) {
        emit(state.copyWith(
            status: LoadStatus.success,
            hadNextPage: response.right.hasNextPage,
            advises: response.right.listItem));
        return;
      }
      emit(state.copyWith(status: LoadStatus.failure));
    } catch (e) {
      emit(state.copyWith(status: LoadStatus.failure));
    }
  }

  Future<void> getAdviseMore() async {
    if (state.hadNextPage) {
      try {
        emit(state.copyWith(
            status: LoadStatus.loading,
            request: state.request
                .copyWith(pageIndex: state.request.pageIndex + 1)));
        final response = await repo.getAllAdvise(state.request);
        if (response.isRight) {
          emit(state.copyWith(
              status: LoadStatus.success,
              hadNextPage: response.right.hasNextPage,
              advises: [...response.right.listItem, ...state.advises]));
          return;
        }
        emit(state.copyWith(status: LoadStatus.failure));
      } catch (e) {
        emit(state.copyWith(status: LoadStatus.failure));
      }
    }
  }

  void openSearch(SearchField field){
    emit(state.copyWith(openSearch: !state.openSearch, field: field));
  }

  void refreshFilter(){
    emit(state.copyWith(field: SearchField.unknown,request: const AdviseRequest()));
  }

  void changeRequest(
      {int? pageIndex,
      String? nameBusiness,
      String? nameIndustrialPark,
      String? taxCode,
      String? hotline,
      String? address}) {
    emit(state.copyWith(
        request: state.request.copyWith(
            pageIndex: pageIndex,
            nameBusiness: nameBusiness,
            industrialPark: nameIndustrialPark,
            taxCode: taxCode,
            location: address,
            hotlineFilter: hotline)));
  }

  void changeRequestByField(SearchField field, String value){
    switch (field){
      case SearchField.hotline:
        changeRequest(hotline: value);
        break;
      case SearchField.address:
        changeRequest(address: value);
        break;
      case SearchField.taxCode:
        changeRequest(taxCode: value);
        break;
      case SearchField.businessName:
        changeRequest(nameBusiness: value);
        break;
      case SearchField.industrialParkName:
        changeRequest(nameIndustrialPark: value);
        break;
      default:
        break;
    }
  }
  String getValueRequest(SearchField field){
    switch (field){
      case SearchField.hotline:
        return "hotline: ${state.request.hotlineFilter}";
      case SearchField.address:
        return "Địa chỉ: ${state.request.location}";
      case SearchField.taxCode:
        return "Mã số thuế: ${state.request.taxCode}";
      case SearchField.businessName:
        return "Doanh nghiệp: ${state.request.nameBusiness}";
      case SearchField.industrialParkName:
        return "Khu công nghiệp: ${state.request.industrialPark}";
      default:
        return '';
    }
  }
}
