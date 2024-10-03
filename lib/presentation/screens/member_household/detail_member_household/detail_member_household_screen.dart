import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/application/extentions/string_extension.dart';
import 'package:phu_tho_mobile/domain/models/response/member_household/member_household_response.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/row_infomation_widget.dart';
import 'package:phu_tho_mobile/presentation/screens/list_job/widget/gradian_appbar.dart';
import 'package:phu_tho_mobile/presentation/screens/member_household/detail_member_household/detail_member_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/member_household/detail_member_household/detail_member_state.dart';
import 'package:skeletons/skeletons.dart';

class DetailMemberHouseholdScreen extends StatefulWidget {
  final int idMember;

  const DetailMemberHouseholdScreen({super.key, required this.idMember});

  @override
  State<DetailMemberHouseholdScreen> createState() =>
      _DetailMemberHouseholdScreenState();
}

class _DetailMemberHouseholdScreenState
    extends State<DetailMemberHouseholdScreen> {
  late DetailMemberCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<DetailMemberCubit>(context);
    _cubit.getDetailMember(widget.idMember);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyFB,
      appBar: GradientAppBar(
          title: Text(
            "Thông tin thành viên",
            style: AppTextStyle.textLg
                .copyWith(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          isOpenSearch: false,
          gradient: const LinearGradient(
              colors: [AppColors.blue44, AppColors.blueF8],
              begin: Alignment.topLeft,
              end: Alignment.topRight)),
      body: BlocBuilder<DetailMemberCubit, DetailMemberState>(
        builder: (context, state) {
          if (state.loadStatus == LoadStatus.failure) {
            return const Center(
              child: Text("Error"),
            );
          }
          if (state.loadStatus == LoadStatus.success) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(12.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Thông tin cơ bản",
                    style: AppTextStyle.textBase.copyWith(
                        color: AppColors.grey52, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Container(
                    padding: EdgeInsets.all(12.r),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: AppColors.greyF6)),
                    child: Column(
                      children: [
                        RowInformationWidget(
                            label: "Họ và tên", value: state.member.fullName),
                        Divider(
                          color: AppColors.greyF6,
                          height: 20.h,
                        ),
                        RowInformationWidget(
                            label: "Giới tính", value: state.member.gender),
                        Divider(
                          color: AppColors.greyF6,
                          height: 20.h,
                        ),
                        RowInformationWidget(
                            label: "Ngày sinh",
                            value: state.member.dateOfBirth != null
                                ? state.member.dateOfBirth!.formatToDMY()
                                : ""),
                        Divider(
                          color: AppColors.greyF6,
                          height: 20.h,
                        ),
                        RowInformationWidget(
                            label: "Số CCCD", value: state.member.idCard),
                        Divider(
                          color: AppColors.greyF6,
                          height: 20.h,
                        ),
                        RowInformationWidget(
                            label: "Quan hệ với chủ hộ",
                            value: state.member.relationShipWithHeader),
                        Divider(
                          color: AppColors.greyF6,
                          height: 20.h,
                        ),
                        RowInformationWidget(
                            label: "Tỉnh", value: state.member.nameProvince),
                        Divider(
                          color: AppColors.greyF6,
                          height: 20.h,
                        ),
                        RowInformationWidget(
                            label: "Huyện", value: state.member.districtName),
                        Divider(
                          color: AppColors.greyF6,
                          height: 20.h,
                        ),
                        RowInformationWidget(
                            label: "Xã", value: state.member.communeName),
                        Divider(
                          color: AppColors.greyF6,
                          height: 20.h,
                        ),
                        RowInformationWidget(
                            label: "Địa chỉ",
                            value: state.member.detailAddress),
                        Divider(
                          color: AppColors.greyF6,
                          height: 20.h,
                        ),
                        RowInformationWidget(
                            label: "Dân tộc", value: state.member.ethnicity),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(
                    "Học vấn và bảo hiểm",
                    style: AppTextStyle.textBase.copyWith(
                        color: AppColors.grey52, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Container(
                    padding: EdgeInsets.all(12.r),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: AppColors.greyF6)),
                    child: Column(
                      children: [
                        RowInformationWidget(
                            label: "Thông tin học vấn",
                            value: state.member.education),
                        Divider(
                          color: AppColors.greyF6,
                          height: 20.h,
                        ),
                        RowInformationWidget(
                            label: "Mã số BHXH",
                            value: state.member.socialInsurance),
                        Divider(
                          color: AppColors.greyF6,
                          height: 20.h,
                        ),
                        RowInformationWidget(
                            label: "Mã số BHYT",
                            value: state.member.healthInsurance),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  if (state.member.activities.isNotEmpty) ...[
                    Text(
                      "Hoạt động kinh tế",
                      style: AppTextStyle.textBase.copyWith(
                          color: AppColors.grey52, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => activityEconomic(
                            state.member.activities[index], index),
                        separatorBuilder: (_, __) => SizedBox(
                              height: 8.h,
                            ),
                        itemCount: state.member.activities.length)
                  ]
                ],
              ),
            );
          }
          return ListView.separated(
              padding: EdgeInsets.all(12.r),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (_, __) => groupSkeletonInfo(),
              separatorBuilder: (_, __) => SizedBox(
                    height: 16.h,
                  ),
              itemCount: 3);
        },
      ),
    );
  }

  Widget activityEconomic(ActivityMemberResponse activity, int index) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.greyF6)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Công việc ${index + 1}",
            style: AppTextStyle.textSm
                .copyWith(color: AppColors.grey72, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 16.h,
          ),
          RowInformationWidget(
              label: "Thời gian",
              value: "${activity.startedTime} -> ${activity.endedTime}"),
          Divider(
            color: AppColors.greyF6,
            height: 20.h,
          ),
          RowInformationWidget(label: "Vị trí", value: activity.workPosition),
          Divider(
            color: AppColors.greyF6,
            height: 20.h,
          ),
          RowInformationWidget(
              label: "Địa chỉ làm việc", value: activity.workAdreess),
          Divider(
            color: AppColors.greyF6,
            height: 20.h,
          ),
          RowInformationWidget(
              label: "Mô tả công việc", value: activity.workDescription),
        ],
      ),
    );
  }

  Widget groupSkeletonInfo() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.r),
          child: SkeletonLine(
            style: SkeletonLineStyle(
              width: 1.sw - 160.w,
              height: 20.h,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        SizedBox(
          height: 16.h,
        ),
        Container(
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: Colors.white,
          ),
          child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (_, __) => SkeletonLine(
                    style: SkeletonLineStyle(
                      width: double.infinity,
                      height: 20.h,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
              separatorBuilder: (_, __) => SizedBox(
                    height: 20.h,
                  ),
              itemCount: 5),
        )
      ],
    );
  }

// Widget skeletonInfo() {
//   return Container(
//     padding: EdgeInsets.all(12.r),
//     decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12.r), color: Colors.white),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         SkeletonLine(
//           style: SkeletonLineStyle(
//             width: 1.sw - 120.w,
//             height: 20.h,
//             borderRadius: BorderRadius.circular(8),
//           ),
//         ),
//         SkeletonAvatar(
//           style: SkeletonAvatarStyle(
//             shape: BoxShape.circle,
//             width: 18.r,
//             height: 18.r,
//           ),
//         ),
//       ],
//     ),
//   );
// }
}
