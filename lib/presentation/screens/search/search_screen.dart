import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/application/enums/type_action.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_loading.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/emty_list_data.dart';
import 'package:phu_tho_mobile/presentation/screens/search/search_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/search/search_state.dart';

import '../../../application/constants/app_text_style.dart';
import '../../../domain/models/argument/detail_job_argument.dart';
import '../../../domain/models/response/cadidate/candidate_response.dart';
import '../../../gen/assets.gen.dart';
import '../../common_widgets/app_label_text_field.dart';
import '../../common_widgets/app_network_image.dart';
import '../../common_widgets/app_widget_job.dart';
import '../../routes/route_name.dart';
import '../business/widgets/business_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final FocusNode _searchFocusNode = FocusNode();
  late SearchCubit cubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit = BlocProvider.of<SearchCubit>(context);
    cubit.getBusiness();
    cubit.getCandidate();
    cubit.getJobs();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_searchFocusNode);
    });
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.white,
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
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            elevation: 0,
            leadingWidth: null,
            title: BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) => CustomLabelTextField(
                maxLine: 1,
                defaultValue: state.searchQuery,
                focusNode: _searchFocusNode,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                radius: 99.r,
                onSubmit: (values) {
                  cubit.changeQuery(values);
                  cubit.getBusiness();
                  cubit.getCandidate();
                  cubit.getJobs();
                },
                prefixIcon: Assets.icons.search.svg(width: 15.r,height: 15.r, colorFilter: const ColorFilter.mode(AppColors.grey86, BlendMode.srcIn)),
                hintText: "Doanh nghiệp, công việc, ứng viên...",
                textStyleHint: AppTextStyle.textSm.copyWith(),
                textStyleInput: AppTextStyle.textSm.copyWith(),
                backgroundColor: AppColors.grayF2,
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: Text(
                  tr("Cancel"),
                  style: AppTextStyle.textSm.copyWith(color: AppColors.white),
                ),
                onPressed: () {
                  cubit.changeQuery('');
                  cubit.getBusiness();
                  cubit.getCandidate();
                  cubit.getJobs();
                  FocusScope.of(context).unfocus();
                },
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            if (state.business.isEmpty &&
                state.listCandidate.isEmpty &&
                state.jobs.isEmpty &&
                (state.statusCandidate == LoadStatus.success &&
                    state.statusJobs == LoadStatus.success &&
                    state.statusBusiness == LoadStatus.success)) {
              return const Center(child: EmptyListData());
            }

            if (state.statusCandidate == LoadStatus.loading &&
                state.statusJobs == LoadStatus.loading &&
                state.statusBusiness == LoadStatus.loading) {
              return const Center(
                child: AppLoading(),
              );
            }

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              child: Column(
                children: [
                  if (state.business.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Doanh nghiệp",
                          style: AppTextStyle.textLg.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) => BusinessWidget(
                                  businessResponse: state.business[index],
                                  typeAction: TypeAction.extract,
                                ),
                            separatorBuilder: (context, index) => const Divider(
                                  height: 0,
                                ),
                            itemCount: state.business.length),
                      ],
                    ),
                  SizedBox(
                    height: 16.h,
                  ),
                  if (state.listCandidate.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ứng viên",
                          style: AppTextStyle.textLg.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        ListView.separated(
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
                        ),
                      ],
                    ),
                  SizedBox(
                    height: 16.h,
                  ),
                  if (state.jobs.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Việc làm",
                          style: AppTextStyle.textLg.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          itemCount: state.jobs.length,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) => SizedBox(
                            height: 10.h,
                          ),
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, RouteName.detailJob,
                                  arguments: DetailJobArgument(
                                      typeAction: TypeAction.extract,
                                      job: state.jobs[index]));
                            },
                            child: AppWidgetJob(
                              job: state.jobs[index],
                              typeAction: TypeAction.extract,
                            ),
                          ),
                        ),
                      ],
                    )
                ],
              ),
            );
          },
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
