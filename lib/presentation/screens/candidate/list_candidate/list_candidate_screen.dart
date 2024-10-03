import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/application/constants/filter_default.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/domain/models/response/cadidate/candidate_response.dart';
import 'package:phu_tho_mobile/gen/assets.gen.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_item_filter.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_label_text_field.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_load_more.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_loading.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_network_image.dart';
import 'package:phu_tho_mobile/presentation/routes/route_name.dart';
import 'package:phu_tho_mobile/presentation/screens/candidate/list_candidate/candidate_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/candidate/list_candidate/candidate_state.dart';

class ListCandidateScreen extends StatefulWidget {
  const ListCandidateScreen({super.key});

  @override
  State<ListCandidateScreen> createState() => _ListCandidateScreenState();
}

class _ListCandidateScreenState extends State<ListCandidateScreen> {
  ValueNotifier<bool> openSearch = ValueNotifier(false);
  late CandidateCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<CandidateCubit>(context);
    cubit.changeRequest(pageIndex: 1);
    cubit.getCandidate();
    cubit.getAllFilter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          padding: EdgeInsets.only(right: 8.w),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.blue44, AppColors.blueF8],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: ValueListenableBuilder<bool>(
            valueListenable: openSearch,
            builder: (context, isSearchOpen, child) {
              return AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
                centerTitle: true,
                elevation: 0,
                leading: !isSearchOpen
                    ? IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 15.w,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    : null,
                leadingWidth: isSearchOpen ? null : 48.w,
                title: isSearchOpen
                    ? CustomLabelTextField(
                        maxLine: 1,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 8.h, horizontal: 8.w),
                        radius: 8.r,
                        onChanged: (values) {
                          cubit.changeRequest(title: values, pageIndex: 1);
                          cubit.getCandidate();
                        },
                        hintText: tr("searchCandidate"),
                        backgroundColor: AppColors.grayF2,
                      )
                    : Text(
                        tr("candidate"),
                        style: AppTextStyle.textBase.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                actions: <Widget>[
                  IconButton(
                    icon: !isSearchOpen
                        ? Assets.icons.search.svg(
                            colorFilter: const ColorFilter.mode(
                              AppColors.white,
                              BlendMode.srcIn,
                            ),
                          )
                        : Text(
                            tr("Cancel"),
                            style: AppTextStyle.textSm
                                .copyWith(color: AppColors.white),
                          ),
                    onPressed: () {
                      openSearch.value = !openSearch.value;
                      if (!openSearch.value) {
                        cubit.changeRequest(pageIndex: 1, title: '');
                        cubit.getCandidate();
                      }
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<CandidateCubit, CandidateState>(
              builder: (context, state) => SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                scrollDirection: Axis.horizontal,
                child: Row(children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(12.r),
                    onTap: () {
                      cubit.changeRequest(
                          pageIndex: 1,
                          positioned: "",
                          jobName: "",
                          district: "",
                          province: "",
                          title: "",
                          exp: "",
                          level: "",
                          salaryFilter: "");
                      cubit.reset();
                      cubit.getCandidate();
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.r, vertical: 4.r),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: AppColors.blue),
                          color: Colors.white),
                      child: Row(
                        children: [
                          Assets.icons.icRefresh.svg(
                              width: 20.r,
                              height: 20.r,
                              colorFilter: const ColorFilter.mode(
                                  AppColors.blue, BlendMode.srcIn)),
                          SizedBox(
                            width: 4.w,
                          ),
                          Text(
                            tr("refresh"),
                            style: AppTextStyle.textSm.copyWith(
                                fontWeight: FontWeight.w400,
                                color: AppColors.blue),
                          )
                        ],
                      ),
                    ),
                  ),
                  AppItemFilter(
                    valueDefault: state.valuePosition.getValues(),
                    title: state.valuePosition.getTitle(),
                    list: state.listPosition,
                    onChange: (value) {
                      cubit.changeValues(positioned: value);
                      cubit.changeRequest(positioned: value.getValues());
                      cubit.getCandidate();
                    },
                  ),
                  AppItemFilter(
                    valueDefault: state.valueJob.getValues(),
                    title: state.valueJob.getTitle(),
                    list: state.listJob,
                    onChange: (value) {
                      cubit.changeValues(jobName: value);
                      cubit.changeRequest(jobName: value.getValues());
                      cubit.getCandidate();
                    },
                  ),
                  AppItemFilter(
                    valueDefault: state.valueProvince.getValues(),
                    title: state.valueProvince.getTitle(),
                    list: state.listProvince,
                    onChange: (value) {
                      cubit.changeValues(province: value);
                      cubit.changeRequest(province: value.getValues());
                      cubit.getFilterDistrict();
                      cubit.getCandidate();
                    },
                  ),
                  AppItemFilter(
                    valueDefault: state.valueDistrict.getValues(),
                    title: state.valueDistrict.getTitle(),
                    list: state.listDistrict,
                    onChange: (value) {
                      cubit.changeValues(district: value);
                      cubit.changeRequest(district: value.getValues());
                      cubit.getCandidate();
                    },
                  ),
                  AppItemFilter(
                    valueDefault: state.valueSalary.getValues(),
                    title: state.valueSalary.getTitle(),
                    list: state.listSalary,
                    onChange: (value) {
                      cubit.changeValues(salaryFilter: value);
                      cubit.changeRequest(salaryFilter: value.getValues());
                      cubit.getCandidate();
                    },
                  ),
                  AppItemFilter(
                    valueDefault: state.valueLevel.getValues(),
                    title: state.valueLevel.getTitle(),
                    list: state.listLevel,
                    onChange: (value) {
                      cubit.changeValues(level: value);
                      cubit.changeRequest(level: value.getValues());
                      cubit.getCandidate();
                    },
                  ),
                  AppItemFilter(
                    valueDefault: state.valueExp.getValues(),
                    title: state.valueExp.getTitle(),
                    list: state.listExp,
                    onChange: (value) {
                      cubit.changeValues(exp: value);
                      cubit.changeRequest(exp: value.getValues());
                      cubit.getCandidate();
                    },
                  ),
                  // AppItemFilter(
                  //   valueDefault: state.valueGender.getValues(),
                  //   title: state.valueGender.getTitle(),
                  //   list: state.listGender,
                  //   onChange: (value) {
                  //     cubit.changeValues(gender: value);
                  //     cubit.changeRequest(
                  //         gender: int.tryParse(value.getValues()) ??
                  //             FilterDefault.valueGender);
                  //     cubit.getCandidate();
                  //   },
                  // ),
                ]),
              ),
            ),
            Expanded(
              child: AppLoadMore(
                onRefresh: () {
                  cubit.changeRequest(pageIndex: 1);
                  cubit.getCandidate();
                },
                onLoadMore: () {},
                child: BlocBuilder<CandidateCubit, CandidateState>(
                  buildWhen: (previous, current) =>
                      previous.status != current.status &&
                      previous.listCandidate != current.listCandidate,
                  builder: (context, state) {
                    if (state.listCandidate.isNotEmpty &&
                        state.status == LoadStatus.success) {
                      return ListView.separated(
                        itemCount: state.listCandidate.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return itemProfile(state.listCandidate[index]);
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(
                          height: 0,
                        ),
                      );
                    }
                    if (state.status == LoadStatus.loading) {
                      return const AppLoading();
                    }

                    if (state.status == LoadStatus.success &&
                        state.listCandidate.isEmpty) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            Assets.images.folder.path,
                            width: 1.sw / 3,
                          ),
                          SizedBox(
                            height: 35.h,
                          ),
                          Text(
                            tr("noData"),
                            style: AppTextStyle.textSm.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemProfile(CandidateResponse profile) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(RouteName.detailCandidate, arguments: profile);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              profile.title,
              style: AppTextStyle.textBase.copyWith(
                  color: AppColors.textPrimary, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 8.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppNetworkImage(
                  profile.getAvatar(),
                  radius: 8.r,
                  height: 100.r,
                  width: 100.r,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  width: 16.w,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profile.fullName,
                        style: AppTextStyle.textSm
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      line(
                          "${tr("yearOfBirth")}:",
                          profile.dateOfBirth != null
                              ? DateFormat.y()
                                  .format(DateTime.parse(profile.dateOfBirth!))
                              : 'chưa biết'),
                      line("${tr("level")}:", profile.level),
                      line("${tr("experience")}:", profile.yearOfExperience),
                    ],
                  ),
                )
              ],
            ),
            lineIcon(Assets.icons.businessPerson.path, "${tr('location')}:",
                profile.currenPosition),
            lineIcon(Assets.icons.briefcase.path, "${tr('career')}:",
                profile.jobName),
            lineIcon(Assets.icons.usdCircle.path, "${tr('salary')}:",
                profile.proposedSalary),
          ],
        ),
      ),
    );
  }

  Widget line(String title, String content) {
    return Container(
      margin: EdgeInsets.only(top: 8.h),
      child: Row(
        children: [
          Text(
            title,
            style: AppTextStyle.textSm.copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 8.w,
          ),
          Expanded(
            child: Text(
              content,
              style: AppTextStyle.textSm.copyWith(
                  fontWeight: FontWeight.w500, overflow: TextOverflow.ellipsis),
            ),
          )
        ],
      ),
    );
  }

  Widget lineIcon(String icon, String title, String content) {
    return Container(
      margin: EdgeInsets.only(top: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(icon,
              width: 20.r,
              height: 20.r,
              colorFilter:
                  const ColorFilter.mode(AppColors.grey, BlendMode.srcIn)),
          SizedBox(
            width: 8.w,
          ),
          Text(
            title,
            style: AppTextStyle.textSm.copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 8.w,
          ),
          Expanded(
            child: Text(
              content,
              style: AppTextStyle.textSm.copyWith(
                  fontWeight: FontWeight.w500, overflow: TextOverflow.ellipsis),
            ),
          )
        ],
      ),
    );
  }
}
