import 'package:equatable/equatable.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/domain/models/common/item_filter.dart';
import 'package:phu_tho_mobile/domain/models/request/candidate_profile_request/candidate_profile_request.dart';
import 'package:phu_tho_mobile/domain/models/response/cadidate/candidate_response.dart';
import 'package:phu_tho_mobile/domain/models/response/filter_response/filter_response.dart';

class CandidateState extends Equatable {
  final LoadStatus status;
  final List<CandidateResponse> listCandidate;
  final bool canLoad;
  final String errorMess;
  final CandidateProFileRequest request;

  final ItemFilter valueProvince;
  final ItemFilter valueDistrict;
  final ItemFilter valueGender;
  final ItemFilter valueExp;
  final ItemFilter valueLevel;
  final ItemFilter valueSalary;
  final ItemFilter valueJob;
  final ItemFilter valuePosition;

  final List<FilterResponse> listProvince;
  final List<FilterResponse> listDistrict;
  final List<FilterResponse> listGender;
  final List<FilterResponse> listExp;
  final List<FilterResponse> listLevel;
  final List<FilterResponse> listSalary;
  final List<FilterResponse> listJob;
  final List<FilterResponse> listPosition;

  const CandidateState({
    this.request = const CandidateProFileRequest(),
    this.status = LoadStatus.initial,
    this.canLoad = false,
    this.errorMess = '',
    this.listCandidate = const [],
    this.listDistrict = const [FilterResponse(text: "Chọn huyện", value: '')],
    this.listExp = const [
      FilterResponse(text: "Kinh nghiệm làm việc", value: '')
    ],
    this.listGender = const [FilterResponse(text: "Chọn giới tính", value: '')],
    this.listJob = const [FilterResponse(text: "Ngành nghề", value: '')],
    this.listLevel = const [
      FilterResponse(text: "Trình độ làm việc", value: '')
    ],
    this.listPosition = const [FilterResponse(text: "Chọn vị trí", value: '')],
    this.listProvince = const [FilterResponse(text: "Chọn tỉnh", value: '')],
    this.listSalary = const [FilterResponse(text: "Mức lương", value: '')],
    this.valueProvince = const FilterResponse(text: "Chọn tỉnh", value: ''),
    this.valueDistrict = const FilterResponse(text: "Chọn huyện", value: ''),
    this.valueGender = const FilterResponse(text: "Chọn giới tính", value: ''),
    this.valueExp =
        const FilterResponse(text: "Kinh nghiệm làm việc", value: ''),
    this.valueLevel =
        const FilterResponse(text: "Trình độ làm việc", value: ''),
    this.valueSalary = const FilterResponse(text: "Mức lương", value: ''),
    this.valueJob = const FilterResponse(text: "Ngành nghề", value: ''),
    this.valuePosition = const FilterResponse(text: "Chọn vị trí", value: ''),
  });

  CandidateState copyWith({
    LoadStatus? status,
    ItemFilter? valueProvince,
    ItemFilter? valueDistrict,
    ItemFilter? valueGender,
    ItemFilter? valueExp,
    ItemFilter? valueLevel,
    ItemFilter? valueSalary,
    ItemFilter? valueJob,
    ItemFilter? valuePosition,
    List<FilterResponse>? listProvince,
    List<FilterResponse>? listDistrict,
    List<FilterResponse>? listGender,
    List<FilterResponse>? listExp,
    List<FilterResponse>? listLevel,
    List<FilterResponse>? listSalary,
    List<FilterResponse>? listJob,
    List<FilterResponse>? listPosition,
    LoadStatus? loadMoreStatus,
    List<CandidateResponse>? listCandidate,
    bool? canLoad,
    String? errorMess,
    CandidateProFileRequest? request,
  }) {
    return CandidateState(
        valueDistrict: valueDistrict ?? this.valueDistrict,
        valueExp: valueExp ?? this.valueExp,
        valueGender: valueGender ?? this.valueGender,
        valueJob: valueJob ?? this.valueJob,
        valueLevel: valueLevel ?? this.valueLevel,
        valuePosition: valuePosition ?? this.valuePosition,
        valueProvince: valueProvince ?? this.valueProvince,
        valueSalary: valueSalary ?? this.valueSalary,
        status: status ?? this.status,
        listCandidate: listCandidate ?? this.listCandidate,
        canLoad: canLoad ?? this.canLoad,
        errorMess: errorMess ?? this.errorMess,
        request: request ?? this.request,
        listDistrict: listDistrict ?? this.listDistrict,
        listExp: listExp ?? this.listExp,
        listGender: listGender ?? this.listGender,
        listJob: listJob ?? this.listJob,
        listLevel: listLevel ?? this.listLevel,
        listPosition: listPosition ?? this.listPosition,
        listProvince: listProvince ?? this.listProvince,
        listSalary: listSalary ?? this.listSalary);
  }

  @override
  List<Object?> get props => [
        status,
        listCandidate,
        canLoad,
        errorMess,
        request,
        listProvince,
        listDistrict,
        listGender,
        listExp,
        listLevel,
        listSalary,
        listJob,
        listPosition,
        valueProvince,
        valueDistrict,
        valueGender,
        valueExp,
        valueLevel,
        valueSalary,
        valueJob,
        valuePosition,
      ];
}
