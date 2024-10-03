import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/application/enums/extract_worker.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/domain/models/argument/detail_extract_worker_argument.dart';
import 'package:phu_tho_mobile/domain/models/response/worker/worker_response.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_loading_indicator.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/appbar_gradient_widget.dart';
import 'package:phu_tho_mobile/presentation/screens/extract_worker/detail_worker/detail_extract_worker_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/extract_worker/detail_worker/detail_extract_worker_state.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/visa_widget.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/work_permit_widget.dart';
import 'package:phu_tho_mobile/application/extentions/int_extension.dart';

class DetailExtractWorkerScreen extends StatefulWidget {
  final DetailWorkerExtractArgument argument;

  const DetailExtractWorkerScreen({super.key, required this.argument});

  @override
  State<DetailExtractWorkerScreen> createState() =>
      _DetailExtractWorkerScreenState();
}

class _DetailExtractWorkerScreenState extends State<DetailExtractWorkerScreen> {
  late List<Widget> infoCommon;
  late List<Widget> infoWorking;
  late DetailExtractWorkerCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<DetailExtractWorkerCubit>(context);
    _cubit.getDetailWorker(widget.argument.idWorker, widget.argument.type);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyFB,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: GradientAppBar(
          title: tr("infoWorker"),
          leading: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
          ),
          leadingAction: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocBuilder<DetailExtractWorkerCubit, DetailExtractWorkerState>(
          builder: (context, state) {
        if (state.loadStatus == LoadStatus.failure) {
          return const Center(
            child: Text("Error"),
          );
        }
        if (state.loadStatus == LoadStatus.success) {
          infoCommon = [
            rowInfoWorker(
                "Họ và tên:", state.detailWorkerResponse.objInfo.fullName),
            rowInfoWorker("Ngày sinh:",
                state.detailWorkerResponse.objInfo.dateOfBirthText),
            rowInfoWorker(
                "Giới tính:", state.detailWorkerResponse.objInfo.gender),
            rowInfoWorker("Căn cước công dân:",
                state.detailWorkerResponse.objInfo.identification),
            rowInfoWorker(
                "Địa chỉ:", state.detailWorkerResponse.objInfo.address),
            rowInfoWorker("Số điện thoại:",
                state.detailWorkerResponse.objInfo.phoneNumber),
            rowInfoWorker(
                "Email:", state.detailWorkerResponse.objInfo.nationality),
            rowInfoWorker("Quốc tịch:", "Việt Nam"),
            rowInfoWorker("Ghi chú:", state.detailWorkerResponse.objInfo.note),
          ];
          infoWorking = [
            rowInfoWorker(
                "Doanh nghiệp:",
                checkNameBusiness(
                    widget.argument.type, state.detailWorkerResponse.objInfo)),
            rowInfoWorker(
                "Chức vụ:", state.detailWorkerResponse.objInfo.positionText),
            rowInfoWorker(
                "Chức danh:", state.detailWorkerResponse.objInfo.position),
            rowInfoWorker(
                "Trình độ chuyên môn:",
                state.detailWorkerResponse.objInfo
                    .professionalQualificationText),
            rowInfoWorker("Lĩnh vực nghề nghiệp:",
                state.detailWorkerResponse.objInfo.fieldOfOccupationText),
            rowInfoWorker("Địa chỉ nơi làm việc:",
                state.detailWorkerResponse.objInfo.workingAddress),
            rowInfoWorker(
                "Hệ số/Mức lương:",
                state.detailWorkerResponse.objInfo.salaryMultiplier != null
                    ? state.detailWorkerResponse.objInfo.salaryMultiplier
                        .toString()
                    : tr("noInfo")),
            rowInfoWorker(
                "Lương cơ bản:",
                state.detailWorkerResponse.objInfo.baseSalary != null
                    ? state.detailWorkerResponse.objInfo.baseSalary
                        ?.formatCurrency()
                    : ''),
            rowInfoWorker(
                "Phụ cấp chức vụ:",
                state.detailWorkerResponse.objInfo.positionAllowance != null
                    ? state.detailWorkerResponse.objInfo.positionAllowance
                        .toString()
                    : ""),
            rowInfoWorker(
                "Phụ cấp thêm niên VK(%):",
                state.detailWorkerResponse.objInfo
                            .seniorityAllowanceForPublicEmployees !=
                        null
                    ? state.detailWorkerResponse.objInfo
                        .seniorityAllowanceForPublicEmployees
                        .toString()
                    : ""),
            rowInfoWorker(
                "Phụ cấp thâm niên nghề(%):",
                state.detailWorkerResponse.objInfo.seniorityAllowanceJob != null
                    ? state.detailWorkerResponse.objInfo.seniorityAllowanceJob
                        .toString()
                    : ""),
            rowInfoWorker(
                "Phụ cấp lương:",
                state.detailWorkerResponse.objInfo.salaryAllowance != null
                    ? state.detailWorkerResponse.objInfo.salaryAllowance
                        .toString()
                    : ""),
            rowInfoWorker(
                "Các khoản bổ sung:",
                state.detailWorkerResponse.objInfo.additionalAllowances != null
                    ? state.detailWorkerResponse.objInfo.additionalAllowances
                        .toString()
                    : ""),
            rowInfoWorker("Loại hợp đồng lao động:",
                state.detailWorkerResponse.objInfo.contractTypeText),
            rowInfoWorker(
                "Ngày BĐ lao động vô thời hạn:",
                state.detailWorkerResponse.objInfo
                    .dateStartedPermanentEmploymentContractText),
            rowInfoWorker("Mã số BHXH:",
                state.detailWorkerResponse.objInfo.codeInsurance),
            rowInfoWorker(
                "Ngày BĐ đóng bảo hiểm xã hội:",
                state.detailWorkerResponse.objInfo
                    .dateStartedSocialInsuranceText),
            rowInfoWorker(
                "Ngày KT đóng bảo hiểm xã hội:",
                state
                    .detailWorkerResponse.objInfo.dateEndedSocialInsuranceText),
          ];
          return SingleChildScrollView(
            padding: EdgeInsets.all(12.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Thông tin cơ bản",
                  style:
                      AppTextStyle.textSm.copyWith(fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 12.h,
                ),
                groupContainer(ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => infoCommon[index],
                    separatorBuilder: (_, __) => const Divider(
                          color: AppColors.greyF6,
                        ),
                    itemCount: infoCommon.length)),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Thông tin công việc",
                  style:
                      AppTextStyle.textSm.copyWith(fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 12.h,
                ),
                groupContainer(ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => infoWorking[index],
                    separatorBuilder: (_, __) => const Divider(
                          color: AppColors.greyF6,
                        ),
                    itemCount: infoWorking.length)),
                if (state.detailWorkerResponse.listTheViSa.isNotEmpty) ...[
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "Thông tin thẻ visa",
                    style: AppTextStyle.textSm
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  groupContainer(ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => VisaWidget(
                            visa: state.detailWorkerResponse.listTheViSa[index],
                          ),
                      separatorBuilder: (_, __) => const Divider(
                            color: AppColors.greyF6,
                          ),
                      itemCount:
                          state.detailWorkerResponse.listTheViSa.length)),
                ],
                if (state.detailWorkerResponse.listWorkPermit.isNotEmpty) ...[
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "Thông tin giấy phép lao động",
                    style: AppTextStyle.textSm
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  groupContainer(ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => WorkPermitWidget(
                            doc: state
                                .detailWorkerResponse.listWorkPermit[index],
                          ),
                      separatorBuilder: (_, __) => const Divider(
                            color: AppColors.greyF6,
                          ),
                      itemCount:
                          state.detailWorkerResponse.listWorkPermit.length))
                ]
              ],
            ),
          );
        }
        return const Center(
          child: AppLoadingIndicator(),
        );
      }),
    );
  }

  Widget rowInfoWorker(String label, String? value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.textSm
              .copyWith(color: AppColors.grey52, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          width: 8.w,
        ),
        Expanded(
            child: Text((value == null || value == "") ? tr("noInfo") : value,
                style: AppTextStyle.textSm.copyWith(
                    color: AppColors.grey52, fontWeight: FontWeight.w400)))
      ],
    );
  }

  Widget groupContainer(Widget child) {
    return MediaQuery.removeViewPadding(
      context: context,
      removeTop: true,
      removeBottom: true,
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.greyEF),
            color: AppColors.white),
        child: child,
      ),
    );
  }

  String? checkNameBusiness(
      TypeExtractWorker type, WorkerResponse workerResponse) {
    switch (type) {
      case TypeExtractWorker.manageVnInForeign:
        return workerResponse.businessText;
      case TypeExtractWorker.manageInBusiness:
        return workerResponse.businessText;
      case TypeExtractWorker.manageForeignInVn:
        return workerResponse.businessText;
      case TypeExtractWorker.vnInForeign:
        return workerResponse.nameBusinessForeign;
      default:
        return workerResponse.nameBusiness;
    }
  }
}
