import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/application/dto/menu_model.dart';
import 'package:phu_tho_mobile/application/enums/extract_worker.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/application/enums/path_news.dart';
import 'package:phu_tho_mobile/application/enums/permission_operator.dart';
import 'package:phu_tho_mobile/application/enums/type_action.dart';
import 'package:phu_tho_mobile/application/enums/type_industrial_park.dart';
import 'package:phu_tho_mobile/domain/models/argument/in_app_web_view_argument.dart';
import 'package:phu_tho_mobile/domain/models/argument/list_job_argument.dart';
import 'package:phu_tho_mobile/gen/assets.gen.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_button.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_dialog.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_loading.dart';
import 'package:phu_tho_mobile/presentation/routes/route_name.dart';
import 'package:phu_tho_mobile/presentation/screens/account/account_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/account/widgets/account_header_widget.dart';
import 'package:phu_tho_mobile/presentation/screens/account/widgets/group_menu_widget.dart';
import 'package:phu_tho_mobile/presentation/screens/home_tab/home_tab.dart';
import 'package:skeletons/skeletons.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  late AccountCubit _cubit;

  late List<GroupMenuModel> groupMenus;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.getUserProfile();
    groupMenus = [
      GroupMenuModel(
        title: tr('account'),
        children: [
          MenuModel(
              icon: Assets.icons.icTagOutline,
              title: 'Thông tin cá nhân',
              onTap: () async {
                await Navigator.of(context)
                    .pushNamed(RouteName.informationAccount);
                _cubit.getUserProfile();
              }),
          MenuModel(
              icon: Assets.icons.icTagOutline,
              title: 'Đổi mật khẩu',
              onTap: () {
                Navigator.of(context).pushNamed(RouteName.changePassword);
              }),
          // MenuModel(
          //     icon: Assets.icons.icTagOutline, title: 'Thông tin cá nhân'),
          // MenuModel(
          //     icon: Assets.icons.icTagOutline, title: 'Thông tin cá nhân'),
        ],
      ),
      GroupMenuModel(
        title: tr('extract'),
        children: [
          MenuModel(
              icon: Assets.icons.icTagOutline,
              title: tr("vietnameseWorkersEmployedAbroad"),
              operator: PermissionOperator.getWorkerVnInForeign,
              onTap: () {
                Navigator.of(context).pushNamed(RouteName.listWorkers,
                    arguments: TypeExtractWorker.vnInForeign);
              }),
          MenuModel(
              icon: Assets.icons.icTagOutline,
              title: tr("foreignWorkersInVietnam"),
              operator: PermissionOperator.getWorkerForeignInVn,
              onTap: () {
                Navigator.of(context).pushNamed(RouteName.listWorkers,
                    arguments: TypeExtractWorker.foreignInVn);
              }),
          MenuModel(
              icon: Assets.icons.icTagOutline,
              title: tr("employeesWorkingInCompany"),
              operator: PermissionOperator.getWorkerInBusiness,
              onTap: () {
                Navigator.of(context).pushNamed(RouteName.listWorkers,
                    arguments: TypeExtractWorker.inBusiness);
              }),
          MenuModel(
              icon: Assets.icons.icTagOutline,
              title: tr("tradingJob"),
              operator: PermissionOperator.getEmploymentTransactionSession,
              onTap: () {
                Navigator.of(context).pushNamed(RouteName.tradingJob);
              }),
          MenuModel(
              icon: Assets.icons.icTagOutline,
              operator: PermissionOperator.getHousehold,
              title: tr('household'),
              onTap: () {
                Navigator.of(context).pushNamed(
                  RouteName.houseHold,
                );
              }),
          MenuModel(
              icon: Assets.icons.icTagOutline,
              operator: PermissionOperator.employmentForEconomicParticipants,
              title: tr('employmentForEconomicParticipants'),
              onTap: () {
                Navigator.of(context).pushNamed(
                  RouteName.economic,
                );
              }),
          MenuModel(
              icon: Assets.icons.icTagOutline,
              operator: PermissionOperator.getCollectAndPayServiceFees,
              title: "Tình hình thu nộp phí dịch vụ",
              onTap: () {
                Navigator.of(context).pushNamed(
                  RouteName.situation,
                );
              }),
          MenuModel(
              icon: Assets.icons.icTagOutline,
              operator: PermissionOperator.reportCommon,
              title: "Báo cáo",
              onTap: () {
                _cubit.getUrlReport();
              }),
        ],
      ),
      GroupMenuModel(
        title: tr("manage"),
        children: [
          MenuModel(
              icon: Assets.icons.icTagOutline,
              title: tr('manageWorker'),
              operator: PermissionOperator.getWorkerInBusiness,
              onTap: () {
                Navigator.of(context).pushNamed(RouteName.manageWorker,
                    arguments: TypeExtractWorker.manageInBusiness);
              }),
          MenuModel(
              icon: Assets.icons.icTagOutline,
              title: tr('manageWorkerForeignInVn'),
              operator: PermissionOperator.getWorkerForeignInVn,
              onTap: () {
                Navigator.of(context).pushNamed(RouteName.manageWorker,
                    arguments: TypeExtractWorker.manageForeignInVn);
              }),
          MenuModel(
              icon: Assets.icons.icTagOutline,
              title: tr('manageWorkerVnInForeign'),
              operator: PermissionOperator.getWorkerVnInForeign,
              onTap: () {
                Navigator.of(context).pushNamed(RouteName.manageWorker,
                    arguments: TypeExtractWorker.manageVnInForeign);
              }),
          MenuModel(
              icon: Assets.icons.icTagOutline,
              title: tr('manageIndustrialPark'),
              operator: PermissionOperator.manageIndustrialPark,
              onTap: () {
                Navigator.of(context).pushNamed(RouteName.industrialPark,
                    arguments: TypeIndustrialPark.manageIndustrialPark);
              }),
          MenuModel(
              icon: Assets.icons.icTagOutline,
              title: tr("manageBusiness"),
              operator: PermissionOperator.manageGetAllEnterprise,
              onTap: () {
                Navigator.of(context).pushNamed(RouteName.listBusiness,
                    arguments: TypeAction.manage);
              }),
          MenuModel(
              icon: Assets.icons.icTagOutline,
              title: "Thông tin tuyển dụng",
              operator: PermissionOperator.manageRecruitmentNeedsOfEnterprise,
              onTap: () {
                Navigator.of(context).pushNamed(RouteName.listJob,
                    arguments:
                        const ListJobArgument(typeAction: TypeAction.manage));
              })
        ],
      ),
      // GroupMenuModel(
      //   title: tr('listNews'),
      //   children: [
      //     MenuModel(
      //         icon: Assets.icons.icTagOutline,
      //         title: tr("advise"),
      //         operator: PermissionOperator.getConsultingActivities,
      //         onTap: () {
      //           Navigator.of(context)
      //               .pushNamed(RouteName.news, arguments: NewsPath.advise);
      //         }),
      //     MenuModel(
      //         icon: Assets.icons.icTagOutline,
      //         title: tr("introduction"),
      //         operator: PermissionOperator.getJobIntroductionActivities,
      //         onTap: () {
      //           Navigator.of(context).pushNamed(RouteName.news,
      //               arguments: NewsPath.introduction);
      //         }),
      //     MenuModel(
      //         icon: Assets.icons.icTagOutline,
      //         title: tr("supply"),
      //         operator: PermissionOperator.getLaborSupplyActivities,
      //         onTap: () {
      //           Navigator.of(context)
      //               .pushNamed(RouteName.news, arguments: NewsPath.supply);
      //         }),
      //     MenuModel(
      //         icon: Assets.icons.icTagOutline,
      //         title: tr("jobSeekers"),
      //         operator: PermissionOperator.getJobEmptyInfoCollectionActivities,
      //         onTap: () {
      //           Navigator.of(context)
      //               .pushNamed(RouteName.news, arguments: NewsPath.jobSeekers);
      //         }),
      //     MenuModel(
      //         icon: Assets.icons.icTagOutline,
      //         title: tr("findingPeople"),
      //         operator: PermissionOperator.getJobSeekerInfoCollectionActivities,
      //         onTap: () {
      //           Navigator.of(context).pushNamed(RouteName.news,
      //               arguments: NewsPath.findingPeople);
      //         }),
      //     MenuModel(
      //         icon: Assets.icons.icTagOutline,
      //         title: tr("employmentStatus"),
      //         operator: PermissionOperator.getEmploymentStatusOfEmployee,
      //         onTap: () {
      //           Navigator.of(context).pushNamed(RouteName.news,
      //               arguments: NewsPath.employmentStatus);
      //         }),
      //     MenuModel(
      //         icon: Assets.icons.icTagOutline,
      //         title: "Dự báo thị trường lao động",
      //         operator: PermissionOperator.getEmploymentStatusOfEmployee,
      //         onTap: () {
      //           Navigator.of(context)
      //               .pushNamed(RouteName.news, arguments: NewsPath.forecast);
      //         }),
      //   ],
      // ),
      GroupMenuModel(
        title: "Khác",
        children: [
          MenuModel(
              icon: Assets.icons.icTagOutline,
              title: tr("contact"),
              operator: PermissionOperator.getContactInformation,
              onTap: () {
                Navigator.of(context).pushNamed(RouteName.informationContact);
              }),
          MenuModel(
              icon: Assets.icons.icTagOutline,
              title: tr("question"),
              operator: PermissionOperator.getQAs,
              onTap: () {
                Navigator.pushNamed(context, RouteName.question);
              }),
          MenuModel(
              icon: Assets.icons.icTagOutline,
              title: tr("terms"),
              operator: PermissionOperator.getQAs,
              onTap: () {
                Navigator.pushNamed(context, RouteName.termOfUse);
              }),
        ],
      ),
    ];
    _cubit.filterActionOfUser(groupMenus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyFB,
      body: BlocListener<AccountCubit, AccountState>(
        listenWhen: (pre, cur) =>
            pre.getUrlReportStatus != cur.getUrlReportStatus,
        listener: (context, state) {
          if (state.getUrlReportStatus == LoadStatus.success) {
            Navigator.pop(context);
            Navigator.of(context).pushNamed(RouteName.inAppWebView,
                arguments: InAppWebViewArgument(
                    label: "Báo cáo", stringUrl: state.urlReport));
          }
          if (state.getUrlReportStatus == LoadStatus.loading) {
            showDialog(
                context: context, builder: (context) => const AppLoading());
          }
          if (state.getUrlReportStatus == LoadStatus.failure) {
            Navigator.of(context).pop();
          }
        },
        child: Column(
          children: [
            BlocBuilder<AccountCubit, AccountState>(
              buildWhen: (prev, curr) =>
                  prev.userProfile != curr.userProfile ||
                  prev.getProfileLoadStatus != curr.getProfileLoadStatus,
              builder: (_, state) {
                return AccountHeaderWidget(
                    userProfile: state.userProfile,
                    loadStatus: state.getProfileLoadStatus);
              },
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: BlocBuilder<AccountCubit, AccountState>(
                builder: (context, state) {
                  if (state.loadActionOfUser == LoadStatus.failure) {
                    return const Center(
                      child: Text("Error"),
                    );
                  }
                  if (state.loadActionOfUser == LoadStatus.success) {
                    return SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        children: [
                          Column(
                            children: state.groupMenus
                                .map((group) => GroupMenuWidget(group: group))
                                .toList(),
                          ),
                          SizedBox(height: 10.h),
                          AppButton(
                            title: tr('logOut'),
                            textStyle: AppTextStyle.textSm.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.white),
                            color: AppColors.blue,
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 10.h),
                            radius: 8.r,
                            onPressed: () {
                              AppDialog.showDialogConfirm(context,
                                  label: "Bạn chắc chắn muốn đăng xuất?",
                                  onConfirm: () {
                                _cubit.logout();
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    RouteName.homeTab, (route) => false,
                                    arguments:
                                        const HomeTabArguments(index: 0));
                              });
                            },
                          ),
                          SizedBox(height: 35.h),
                        ],
                      ),
                    );
                  }
                  return ListView.separated(
                      padding: EdgeInsets.all(12.r),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (_, __) => SkeletonLine(
                            style: SkeletonLineStyle(
                                width: 1.sw,
                                height: 30.h,
                                borderRadius: BorderRadius.circular(8.r)),
                          ),
                      separatorBuilder: (_, __) => SizedBox(
                            height: 10.h,
                          ),
                      itemCount: 20);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
