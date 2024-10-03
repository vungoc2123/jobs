import 'package:equatable/equatable.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/application/enums/type_action.dart';
import 'package:phu_tho_mobile/domain/models/common/item_filter.dart';
import 'package:phu_tho_mobile/domain/models/request/job_request/job_request.dart';
import 'package:phu_tho_mobile/domain/models/response/filter_response/filter_response.dart';
import 'package:phu_tho_mobile/domain/models/response/job/job_response.dart';

class ListJobState extends Equatable {
  final JobRequest request;
  final List<JobResponse> jobs;
  final bool hasNextPage;
  final LoadStatus status;
  final LoadStatus statusMore;
  final bool isShowSearch;
  final TypeAction typeAction;
  final LoadStatus loadAction;
  final String message;

  final LoadStatus loadApplyJob;

  final ItemFilter valueProvince;
  final ItemFilter valueDistrict;
  final ItemFilter valueGender;
  final ItemFilter valueExp;
  final ItemFilter valueLevel;
  final ItemFilter valueSalary;
  final ItemFilter valueJob;
  final ItemFilter valuePosition;
  final ItemFilter isApproved;
  final ItemFilter expire;

  final List<FilterResponse> listProvince;
  final List<FilterResponse> listDistrict;
  final List<FilterResponse> listGender;
  final List<FilterResponse> listExp;
  final List<FilterResponse> listLevel;
  final List<FilterResponse> listSalary;
  final List<FilterResponse> listJob;
  final List<FilterResponse> listPosition;
  final List<FilterResponse> listApproved;
  final List<FilterResponse> listExpire;

  const ListJobState(
      {this.loadAction = LoadStatus.initial,
      this.typeAction = TypeAction.extract,
      this.loadApplyJob = LoadStatus.initial,
      this.request = const JobRequest(),
      this.jobs = const [],
      this.status = LoadStatus.initial,
      this.statusMore = LoadStatus.initial,
      this.hasNextPage = false,
      this.isShowSearch = false,
      this.listDistrict = const [FilterResponse(text: "Chọn huyện", value: '')],
      this.listExp = const [
        FilterResponse(text: "Kinh nghiệm làm việc", value: '')
      ],
      this.listGender = const [
        FilterResponse(text: "Chọn giới tính", value: '')
      ],
      this.listJob = const [FilterResponse(text: "Ngành nghề", value: '')],
      this.listLevel = const [
        FilterResponse(text: "Trình độ làm việc", value: '')
      ],
      this.listPosition = const [
        FilterResponse(text: "Chọn vị trí", value: '')
      ],
      this.listProvince = const [FilterResponse(text: "Chọn tỉnh", value: '')],
      this.listSalary = const [FilterResponse(text: "Mức lương", value: '')],
      this.listApproved = const [
        FilterResponse(text: "Tình trạng", value: ''),
        FilterResponse(text: "Đã duyệt", value: 'true'),
        FilterResponse(text: "Chưa duyệt", value: 'false')
      ],
      this.listExpire = const [
        FilterResponse(text: "Tình trạng hết hạn", value: ''),
        FilterResponse(text: "Hết hạn", value: 'true'),
        FilterResponse(text: "Chưa hết hạn", value: 'false')
      ],
      this.isApproved = const FilterResponse(text: "Tình trạng", value: ''),
      this.valueProvince = const FilterResponse(text: "Chọn tỉnh", value: ''),
      this.valueDistrict = const FilterResponse(text: "Chọn huyện", value: ''),
      this.valueGender =
          const FilterResponse(text: "Chọn giới tính", value: ''),
      this.valueExp =
          const FilterResponse(text: "Kinh nghiệm làm việc", value: ''),
      this.valueLevel =
          const FilterResponse(text: "Trình độ làm việc", value: ''),
      this.valueSalary = const FilterResponse(text: "Mức lương", value: ''),
      this.valueJob = const FilterResponse(text: "Ngành nghề", value: ''),
      this.expire = const FilterResponse(text: "Tình trạng hết hạn", value: ''),
      this.valuePosition = const FilterResponse(text: "Chọn vị trí", value: ''),
      this.message = ''});

  ListJobState copyWith(
      {ItemFilter? valueProvince,
      ItemFilter? valueDistrict,
      ItemFilter? valueGender,
      ItemFilter? valueExp,
      ItemFilter? valueLevel,
      ItemFilter? valueSalary,
      ItemFilter? valueJob,
      ItemFilter? valuePosition,
      ItemFilter? isApproved,
      ItemFilter? expire,
      List<FilterResponse>? listProvince,
      List<FilterResponse>? listDistrict,
      List<FilterResponse>? listGender,
      List<FilterResponse>? listExp,
      List<FilterResponse>? listLevel,
      List<FilterResponse>? listSalary,
      List<FilterResponse>? listJob,
      List<FilterResponse>? listPosition,
      List<FilterResponse>? listExpire,
      JobRequest? request,
      List<JobResponse>? jobs,
      bool? hasNextPage,
      LoadStatus? status,
      bool? isShowSearch,
      LoadStatus? statusMore,
      LoadStatus? loadApplyJob,
      TypeAction? typeAction,
      LoadStatus? loadAction,
      String? message}) {
    return ListJobState(
        request: request ?? this.request,
        hasNextPage: hasNextPage ?? this.hasNextPage,
        status: status ?? this.status,
        statusMore: statusMore ?? this.statusMore,
        isShowSearch: isShowSearch ?? this.isShowSearch,
        jobs: jobs ?? this.jobs,
        valueDistrict: valueDistrict ?? this.valueDistrict,
        valueExp: valueExp ?? this.valueExp,
        valueGender: valueGender ?? this.valueGender,
        valueJob: valueJob ?? this.valueJob,
        valueLevel: valueLevel ?? this.valueLevel,
        valuePosition: valuePosition ?? this.valuePosition,
        valueProvince: valueProvince ?? this.valueProvince,
        valueSalary: valueSalary ?? this.valueSalary,
        listDistrict: listDistrict ?? this.listDistrict,
        expire: expire ?? this.expire,
        listExp: listExp ?? this.listExp,
        listGender: listGender ?? this.listGender,
        listJob: listJob ?? this.listJob,
        listLevel: listLevel ?? this.listLevel,
        listExpire: listExpire ?? this.listExpire,
        listPosition: listPosition ?? this.listPosition,
        listProvince: listProvince ?? this.listProvince,
        listSalary: listSalary ?? this.listSalary,
        isApproved: isApproved ?? this.isApproved,
        typeAction: typeAction ?? this.typeAction,
        loadAction: loadAction ?? this.loadAction,
        message: message ?? this.message,
        loadApplyJob: loadApplyJob ?? this.loadApplyJob);
  }

  @override
  List<Object?> get props => [
        request,
        jobs,
        status,
        statusMore,
        isShowSearch,
        hasNextPage,
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
        expire,
        valueSalary,
        valueJob,
        valuePosition,
        listApproved,
        isApproved,
        typeAction,
        loadAction,
        message,
        loadApplyJob
      ];
}
