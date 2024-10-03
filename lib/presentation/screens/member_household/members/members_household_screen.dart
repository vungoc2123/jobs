import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/domain/models/argument/detail_household_argument.dart';
import 'package:phu_tho_mobile/domain/models/request/member_household/member_household_request.dart';
import 'package:phu_tho_mobile/domain/models/response/filter_response/filter_response.dart';
import 'package:phu_tho_mobile/gen/assets.gen.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_bottom_sheet.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_button.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_label_text_field.dart';
import 'package:phu_tho_mobile/presentation/screens/list_job/widget/gradian_appbar.dart';
import 'package:phu_tho_mobile/presentation/screens/member_household/members/members_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/member_household/members/members_state.dart';
import 'package:phu_tho_mobile/presentation/screens/member_household/widgets/bottom_sheet_filter_member.dart';
import 'package:phu_tho_mobile/presentation/screens/member_household/widgets/info_common_household_widget.dart';
import 'package:phu_tho_mobile/presentation/screens/member_household/widgets/member_household_widget.dart';
import 'package:skeletons/skeletons.dart';

class MemberHouseHoldScreen extends StatefulWidget {
  final DetailHouseholdArgument argument;

  const MemberHouseHoldScreen({super.key, required this.argument});

  @override
  State<MemberHouseHoldScreen> createState() => _MemberHouseHoldScreenState();
}

class _MemberHouseHoldScreenState extends State<MemberHouseHoldScreen> {
  late MembersCubit _cubit;
  late ValueNotifier<bool> isShowFilter;

  @override
  void initState() {
    super.initState();
    isShowFilter = ValueNotifier(false);
    _cubit = BlocProvider.of<MembersCubit>(context);
    _cubit.getDropDownStart();
    _cubit.onChangeRequest(_cubit.state.request
        .copyWith(idHousehold: widget.argument.householdResponse.id));
    _cubit.getMembers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyFB,
      appBar: GradientAppBar(
          title: Text(
            "Thông tin hộ gia đình",
            style: AppTextStyle.textLg
                .copyWith(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          isOpenSearch: false,
          gradient: const LinearGradient(
              colors: [AppColors.blue44, AppColors.blueF8],
              begin: Alignment.topLeft,
              end: Alignment.topRight)),
      body: Padding(
        padding: EdgeInsets.all(12.r),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Thông tin chung",
                style: AppTextStyle.textBase.copyWith(
                    color: AppColors.grey52, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 12.h,
              ),
              InfoCommonHouseholdWidget(
                  household: widget.argument.householdResponse),
              SizedBox(
                height: 12.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Danh sách thành viên",
                    style: AppTextStyle.textBase.copyWith(
                        color: AppColors.grey52, fontWeight: FontWeight.w600),
                  ),
                  IconButton(
                      onPressed: () {
                        isShowFilter.value = !isShowFilter.value;
                      },
                      icon: const Icon(Icons.filter_alt_outlined))
                ],
              ),
              BlocBuilder<MembersCubit, MembersState>(
                buildWhen: (pre, cur) =>
                    pre.request != cur.request ||
                    pre.loadRelationDistrictEthnicities !=
                        cur.loadRelationDistrictEthnicities ||
                    pre.loadCommunes != cur.loadCommunes,
                builder: (context, state) {
                  return ValueListenableBuilder(
                    valueListenable: isShowFilter,
                    builder: (context, value, _) {
                      return Visibility(
                          visible: value,
                          child: Container(
                            padding: EdgeInsets.all(12.r),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: Colors.white),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Họ và tên",
                                  style: AppTextStyle.textSm
                                      .copyWith(fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                CustomLabelTextField(
                                  hintText: "Họ tên",
                                  maxLine: 1,
                                  defaultValue:
                                      _cubit.state.request.fullName ?? "",
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12.r, vertical: 8.r),
                                  radius: 12.r,
                                  colorBorder: AppColors.greyE5,
                                  prefixIcon: Assets.icons.search.svg(
                                      colorFilter: const ColorFilter.mode(
                                          AppColors.grey73, BlendMode.srcIn)),
                                  backgroundColor: AppColors.white,
                                  textStyleHint: AppTextStyle.textSm,
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      _cubit.onChangeRequest(_cubit
                                          .state.request
                                          .copyWith(fullName: ""));
                                    },
                                    child: Assets.icons.icCloseRound.svg(),
                                  ),
                                  onSubmit: (value) {
                                    _cubit.onChangeRequest(_cubit.state.request
                                        .copyWith(fullName: value));
                                  },
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Text(
                                  "Số CCCD",
                                  style: AppTextStyle.textSm
                                      .copyWith(fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                CustomLabelTextField(
                                  hintText: "Số CCCD",
                                  defaultValue: _cubit.state.request.idCard,
                                  maxLine: 1,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12.r, vertical: 8.r),
                                  radius: 12.r,
                                  colorBorder: AppColors.greyE5,
                                  prefixIcon: Assets.icons.search.svg(
                                      colorFilter: const ColorFilter.mode(
                                          AppColors.grey73, BlendMode.srcIn)),
                                  backgroundColor: AppColors.white,
                                  textStyleHint: AppTextStyle.textSm,
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      _cubit.onChangeRequest(_cubit
                                          .state.request
                                          .copyWith(idCard: ""));
                                    },
                                    child: Assets.icons.icCloseRound.svg(),
                                  ),
                                  onSubmit: (value) {
                                    _cubit.onChangeRequest(_cubit.state.request
                                        .copyWith(idCard: value));
                                  },
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Text(
                                  "Quan hệ với chủ hộ",
                                  style: AppTextStyle.textSm
                                      .copyWith(fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                InkWell(
                                  borderRadius: BorderRadius.circular(12.r),
                                  onTap: () {
                                    AppBottomSheet.showBottomSheet(context,
                                        isScroll: false,
                                        child: BottomSheetFilterMember(
                                          searching: true,
                                          valueDefault: _cubit
                                              .state.relationShipFilter
                                              .getValues(),
                                          title: "Quan hệ với chủ hộ",
                                          list: state.relationshipsWithHeader,
                                          onChange: (itemFilter) {
                                            _cubit.changeRelationShipFilter(
                                                itemFilter);
                                            _cubit.onChangeRequest(
                                                _cubit.state.request.copyWith(
                                                    relationShipWith: itemFilter
                                                        .getValues()));
                                          },
                                        ));
                                  },
                                  child: CustomLabelTextField(
                                    hintText: "Quan hệ với chủ hộ",
                                    enable: false,
                                    defaultValue: _cubit
                                        .state.relationShipFilter
                                        .getTitle(),
                                    maxLine: 1,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 12.r, vertical: 8.r),
                                    radius: 12.r,
                                    colorBorder: AppColors.greyE5,
                                    prefixIcon: Assets.icons.icMutilUser.svg(
                                        colorFilter: const ColorFilter.mode(
                                            AppColors.grey73, BlendMode.srcIn)),
                                    backgroundColor: AppColors.white,
                                    textStyleHint: AppTextStyle.textSm,
                                  ),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Text(
                                  "Giới tính",
                                  style: AppTextStyle.textSm
                                      .copyWith(fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                InkWell(
                                  borderRadius: BorderRadius.circular(12.r),
                                  onTap: () {
                                    AppBottomSheet.showBottomSheet(context,
                                        isScroll: false,
                                        child: BottomSheetFilterMember(
                                          searching: false,
                                          valueDefault: _cubit
                                              .state.gendersFilter
                                              .getValues(),
                                          title: "Giới tính",
                                          list: state.genders,
                                          onChange: (itemFilter) {
                                            _cubit
                                                .changeGenderFilter(itemFilter);
                                            _cubit.onChangeRequest(
                                                _cubit.state.request.copyWith(
                                                    gender: itemFilter
                                                        .getValues()));
                                          },
                                        ));
                                  },
                                  child: CustomLabelTextField(
                                    hintText: "Giới tính",
                                    enable: false,
                                    maxLine: 1,
                                    defaultValue:
                                        _cubit.state.gendersFilter.getTitle(),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 12.r, vertical: 8.r),
                                    radius: 12.r,
                                    colorBorder: AppColors.greyE5,
                                    prefixIcon: Assets.icons.icGender.svg(
                                        colorFilter: const ColorFilter.mode(
                                            AppColors.grey73, BlendMode.srcIn)),
                                    backgroundColor: AppColors.white,
                                    textStyleHint: AppTextStyle.textSm,
                                  ),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Text(
                                  "Dân tộc",
                                  style: AppTextStyle.textSm
                                      .copyWith(fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                InkWell(
                                  borderRadius: BorderRadius.circular(12.r),
                                  onTap: () {
                                    AppBottomSheet.showBottomSheet(context,
                                        isScroll: false,
                                        child: BottomSheetFilterMember(
                                          searching: true,
                                          valueDefault: _cubit
                                              .state.ethnicityFilter
                                              .getValues(),
                                          title: "Dân tộc",
                                          list: state.ethnicities,
                                          onChange: (itemFilter) {
                                            _cubit.changeEthnicityFilter(
                                                itemFilter);
                                            _cubit.onChangeRequest(
                                                _cubit.state.request.copyWith(
                                                    ethnicity: itemFilter
                                                        .getValues()));
                                          },
                                        ));
                                  },
                                  child: CustomLabelTextField(
                                    hintText: "Chọn dân tộc",
                                    enable: false,
                                    defaultValue:
                                        _cubit.state.ethnicityFilter.getTitle(),
                                    maxLine: 1,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 12.r, vertical: 8.r),
                                    radius: 12.r,
                                    colorBorder: AppColors.greyE5,
                                    prefixIcon: Assets.icons.icLanguage.svg(
                                        colorFilter: const ColorFilter.mode(
                                            AppColors.grey73, BlendMode.srcIn)),
                                    backgroundColor: AppColors.white,
                                    textStyleHint: AppTextStyle.textSm,
                                  ),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Text(
                                  "Huyện",
                                  style: AppTextStyle.textSm
                                      .copyWith(fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                InkWell(
                                  borderRadius: BorderRadius.circular(12.r),
                                  onTap: () {
                                    AppBottomSheet.showBottomSheet(context,
                                        isScroll: false,
                                        child: BottomSheetFilterMember(
                                          searching: true,
                                          valueDefault: _cubit
                                              .state.districtFilter
                                              .getValues(),
                                          title: "Huyện",
                                          list: state.districts,
                                          onChange: (itemFilter) {
                                            _cubit.changeDistrictFilter(
                                                itemFilter);
                                            _cubit.onChangeRequest(
                                                _cubit.state.request.copyWith(
                                                    districtFilter: itemFilter
                                                        .getValues()));
                                            _cubit.getCommunes(
                                                itemFilter.getValues());
                                          },
                                        ));
                                  },
                                  child: CustomLabelTextField(
                                    hintText: "Chọn huyện",
                                    enable: false,
                                    defaultValue:
                                        _cubit.state.districtFilter.getTitle(),
                                    maxLine: 1,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 12.r, vertical: 8.r),
                                    radius: 12.r,
                                    colorBorder: AppColors.greyE5,
                                    prefixIcon: Assets.icons.icMarker.svg(
                                        colorFilter: const ColorFilter.mode(
                                            AppColors.grey73, BlendMode.srcIn)),
                                    backgroundColor: AppColors.white,
                                    textStyleHint: AppTextStyle.textSm,
                                  ),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Text(
                                  "Xã",
                                  style: AppTextStyle.textSm
                                      .copyWith(fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                InkWell(
                                  borderRadius: BorderRadius.circular(12.r),
                                  onTap: () {
                                    AppBottomSheet.showBottomSheet(context,
                                        isScroll: false,
                                        child: BottomSheetFilterMember(
                                          searching: true,
                                          valueDefault: _cubit
                                              .state.communesFilter
                                              .getValues(),
                                          title: "Dân tộc",
                                          list: state.communes,
                                          onChange: (itemFilter) {
                                            _cubit.changeCommuneFilter(
                                                itemFilter);
                                            _cubit.onChangeRequest(
                                                _cubit.state.request.copyWith(
                                                    communeFilter: itemFilter
                                                        .getValues()));
                                          },
                                        ));
                                  },
                                  child: CustomLabelTextField(
                                    hintText: "Chọn xã",
                                    enable: false,
                                    defaultValue:
                                        _cubit.state.communesFilter.getTitle(),
                                    maxLine: 1,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 12.r, vertical: 8.r),
                                    radius: 12.r,
                                    colorBorder: AppColors.greyE5,
                                    prefixIcon: Assets.icons.icMarker.svg(
                                        colorFilter: const ColorFilter.mode(
                                            AppColors.grey73, BlendMode.srcIn)),
                                    backgroundColor: AppColors.white,
                                    textStyleHint: AppTextStyle.textSm,
                                  ),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Text(
                                  "Địa chỉ chi tiết",
                                  style: AppTextStyle.textSm
                                      .copyWith(fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                CustomLabelTextField(
                                  hintText: "Địa chỉ",
                                  maxLine: 1,
                                  defaultValue:
                                      _cubit.state.request.detailAddress,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12.r, vertical: 8.r),
                                  radius: 12.r,
                                  colorBorder: AppColors.greyE5,
                                  prefixIcon: Assets.icons.search.svg(
                                      colorFilter: const ColorFilter.mode(
                                          AppColors.grey73, BlendMode.srcIn)),
                                  backgroundColor: AppColors.white,
                                  textStyleHint: AppTextStyle.textSm,
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      _cubit.onChangeRequest(_cubit
                                          .state.request
                                          .copyWith(detailAddress: ""));
                                    },
                                    child: Assets.icons.icCloseRound.svg(),
                                  ),
                                  onSubmit: (value) {
                                    _cubit.onChangeRequest(_cubit.state.request
                                        .copyWith(detailAddress: value));
                                  },
                                ),
                                SizedBox(
                                  height: 12.h,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    Flexible(
                                        flex: 1,
                                        child: AppButton(
                                          title: 'Làm mới',
                                          color: AppColors.blue,
                                          radius: 8.r,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 4.h),
                                          textStyle: AppTextStyle.textSm
                                              .copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600),
                                          onPressed: () {
                                            _cubit.resetFilter();
                                            _cubit.onChangeRequest(
                                                MemberHouseholdRequest(
                                                    pageSize: 100,
                                                    idHousehold: widget.argument
                                                        .householdResponse.id));
                                          },
                                        )),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    Flexible(
                                        flex: 1,
                                        child: AppButton(
                                          title: 'Tìm kiếm',
                                          color: AppColors.white,
                                          borderColor: AppColors.blue,
                                          radius: 8.r,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 4.h),
                                          textStyle: AppTextStyle.textSm
                                              .copyWith(
                                                  color: AppColors.blue,
                                                  fontWeight: FontWeight.w600),
                                          onPressed: () {
                                            _cubit.getMembers();
                                          },
                                        )),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ));
                    },
                  );
                },
              ),
              SizedBox(
                height: 12.h,
              ),
              BlocBuilder<MembersCubit, MembersState>(
                  builder: (context, state) {
                if (state.loadStatus == LoadStatus.failure) {
                  return SizedBox(
                    height: 60.h,
                    child: const Center(
                      child: Text("Không tìm thấy dữ liệu"),
                    ),
                  );
                }
                if (state.loadStatus == LoadStatus.success) {
                  return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => MemberHouseholdWidget(
                            member: state.members[index],
                          ),
                      separatorBuilder: (_, __) => SizedBox(
                            height: 8.h,
                          ),
                      itemCount: state.members.length);
                }

                return SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                        5,
                        (index) => Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              child: skeletonMembers(),
                            )),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  Widget skeletonMembers() {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r), color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SkeletonLine(
            style: SkeletonLineStyle(
              width: 1.sw - 120.w,
              height: 20.h,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          SkeletonAvatar(
            style: SkeletonAvatarStyle(
              shape: BoxShape.circle,
              width: 18.r,
              height: 18.r,
            ),
          ),
        ],
      ),
    );
  }
}
