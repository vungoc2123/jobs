import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_deep_link.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/application/constants/filter_default.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/application/enums/type_action.dart';
import 'package:phu_tho_mobile/application/extentions/string_extension.dart';
import 'package:phu_tho_mobile/domain/models/argument/detail_job_argument.dart';
import 'package:phu_tho_mobile/domain/models/argument/in_app_web_view_argument.dart';
import 'package:phu_tho_mobile/domain/models/argument/list_job_argument.dart';
import 'package:phu_tho_mobile/gen/assets.gen.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_dialog.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_item_filter.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_label_text_field.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_load_more.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_loading.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_loading_indicator.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_toast.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_widget_job.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/appbar_gradient_widget.dart';
import 'package:phu_tho_mobile/presentation/routes/route_name.dart';
import 'package:phu_tho_mobile/presentation/screens/list_job/bloc/list_job_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/list_job/bloc/list_job_state.dart';

class ListJobScreen extends StatefulWidget {
  // final int? idBusiness;
  final ListJobArgument argument;

  const ListJobScreen({super.key, required this.argument});

  @override
  State<ListJobScreen> createState() => _ListJobScreenState();
}

class _ListJobScreenState extends State<ListJobScreen> {
  late final ListJobCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<ListJobCubit>(context);
    if (widget.argument.idBusiness != null) {
      cubit.changeRequest(idBusiness: widget.argument.idBusiness);
    }
    cubit.onChangeTypeAction(widget.argument.typeAction);
    cubit.getJobs();
    cubit.getAllFilter();
  }

  List<String> listFilter = [
    'Địa Điểm',
    "Ngành Nghề",
    "Lĩnh Vực Công Ty",
    "Cấp Bậc",
    "Loại Hình Công Việc"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: GradientAppBar(
          title: tr("Thông tin tuyển dụng"),
          leading: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: AppColors.white,
          ),
          leadingAction: () {
            Navigator.pop(context);
          },
          actions: [
            widget.argument.typeAction == TypeAction.manage
                ? IconButton(
                    onPressed: () async {
                      final url = await AppDeepLink.manageRecruitmentNeeds
                          .toResourceUrl()
                          .withUserToken();
                      if (context.mounted) {
                        Navigator.of(context).pushNamed(RouteName.inAppWebView,
                            arguments: InAppWebViewArgument(
                              label: "Thêm mới tin tuyển dụng",
                              stringUrl: url,
                            ));
                      }
                    },
                    icon: Icon(
                      Icons.add,
                      size: 28.r,
                      color: AppColors.white,
                    ))
                : const SizedBox()
          ],
        ),
      ),
      body: SafeArea(
        child: BlocListener<ListJobCubit, ListJobState>(
          listenWhen: (pre, cur) => pre.loadAction != cur.loadAction,
          listener: (context, state) {
            if (state.loadAction == LoadStatus.loading) {
              showDialog(
                  context: context, builder: (context) => const AppLoading());
            }
            if (state.loadAction == LoadStatus.success) {
              Navigator.of(context).pop();
              AppToast.showToastSuccess(context, title: state.message);
              cubit.getJobs();
            }
            if (state.loadAction == LoadStatus.failure) {
              Navigator.of(context).pop();
              AppToast.showToastError(context, title: state.message);
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<ListJobCubit, ListJobState>(
                buildWhen: (previous, current) =>
                    previous.isShowSearch != current.isShowSearch,
                builder: (BuildContext context, state) {
                  return SingleChildScrollView(
                    scrollDirection:
                        state.isShowSearch ? Axis.vertical : Axis.horizontal,
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 8.h),
                        child: state.isShowSearch ? search() : filter()),
                  );
                },
              ),
              Expanded(
                child: AppLoadMore(
                  onLoadMore: () {
                    cubit.getJobsMore();
                  },
                  onRefresh: () {
                    cubit.getJobs();
                  },
                  child: BlocBuilder<ListJobCubit, ListJobState>(
                    buildWhen: (previous, current) =>
                        previous.jobs != current.jobs ||
                        previous.status != current.status ||
                        previous.statusMore != current.statusMore,
                    builder: (BuildContext context, state) {
                      if (state.status == LoadStatus.loading) {
                        return const AppLoadingIndicator();
                      }
                      if (state.status == LoadStatus.success &&
                          state.jobs.isEmpty) {
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
                      return ListView.separated(
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
                                    typeAction: widget.argument.typeAction,
                                    job: state.jobs[index]));
                          },
                          child: AppWidgetJob(
                            job: state.jobs[index],
                            typeAction: widget.argument.typeAction,
                            onDelete: () {
                              AppDialog.showDialogConfirm(
                                context,
                                label: "Bạn có muốn xóa không?",
                                onConfirm: () {
                                  Navigator.of(context).pop();
                                  cubit.deleteJob(state.jobs[index].id);
                                },
                              );
                            },
                            onEdit: () async {
                              final url = await AppDeepLink
                                  .manageRecruitmentNeeds
                                  .toResourceUrl()
                                  .withUserToken();
                              final urlWithParams =
                                  url.withParam({"id": state.jobs[index].id});
                              if (context.mounted) {
                                Navigator.of(context).pushNamed(
                                    RouteName.inAppWebView,
                                    arguments: InAppWebViewArgument(
                                      label: "Chỉnh sửa thông tin tuyển dụng",
                                      stringUrl: urlWithParams,
                                    ));
                              }
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget filter() {
    return BlocBuilder<ListJobCubit, ListJobState>(
      builder: (context, state) => Row(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(12.r),
            onTap: () {
              cubit.reset();
              if (widget.argument.idBusiness != null) {
                cubit.changeRequest(idBusiness: widget.argument.idBusiness);
              }
              cubit.onChangeTypeAction(widget.argument.typeAction);
              cubit.getJobs();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 4.r),
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
                        fontWeight: FontWeight.w400, color: AppColors.blue),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: 8.w,
          ),
          InkWell(
            onTap: () {
              cubit.changeVisible(true);
            },
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                      color: state.request.titleFilter.isNotEmpty
                          ? AppColors.blue
                          : AppColors.greyDF)),
              child: Text(
                state.request.titleFilter.isNotEmpty
                    ? state.request.titleFilter
                    : "Tên",
                style: AppTextStyle.textSm.copyWith(color: AppColors.grey4D),
              ),
            ),
          ),
          SizedBox(
            width: 4.w,
          ),
          AppItemFilter(
            valueDefault: state.valuePosition.getValues(),
            title: state.valuePosition.getTitle(),
            list: state.listPosition,
            onChange: (value) {
              cubit.changeValues(positioned: value);
              cubit.changeRequest(positioned: value.getValues());
              cubit.getJobs();
            },
          ),
          AppItemFilter(
            valueDefault: state.valueJob.getValues(),
            title: state.valueJob.getTitle(),
            list: state.listJob,
            onChange: (value) {
              cubit.changeValues(jobName: value);
              cubit.changeRequest(jobName: value.getValues());
              cubit.getJobs();
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
              cubit.getJobs();
            },
          ),
          AppItemFilter(
            valueDefault: state.valueDistrict.getValues(),
            title: state.valueDistrict.getTitle(),
            list: state.listDistrict,
            onChange: (value) {
              cubit.changeValues(district: value);
              cubit.changeRequest(district: value.getValues());
              cubit.getJobs();
            },
          ),
          AppItemFilter(
            valueDefault: state.valueSalary.getValues(),
            title: state.valueSalary.getTitle(),
            list: state.listSalary,
            onChange: (value) {
              cubit.changeValues(salaryFilter: value);
              cubit.changeRequest(salaryFilter: value.getValues());
              cubit.getJobs();
            },
          ),
          AppItemFilter(
            valueDefault: state.valueLevel.getValues(),
            title: state.valueLevel.getTitle(),
            list: state.listLevel,
            onChange: (value) {
              cubit.changeValues(level: value);
              cubit.changeRequest(level: value.getValues());
              cubit.getJobs();
            },
          ),
          AppItemFilter(
            valueDefault: state.valueExp.getValues(),
            title: state.valueExp.getTitle(),
            list: state.listExp,
            onChange: (value) {
              cubit.changeValues(exp: value);
              cubit.changeRequest(exp: value.getValues());
              cubit.getJobs();
            },
          ),
          AppItemFilter(
            valueDefault: state.valueGender.getValues(),
            title: state.valueGender.getTitle(),
            list: state.listGender,
            onChange: (value) {
              cubit.changeValues(gender: value);
              cubit.changeRequest(
                  gender: int.tryParse(value.getValues()) ??
                      FilterDefault.valueGender);
              cubit.getJobs();
            },
          ),
          AppItemFilter(
            valueDefault: state.isApproved.getValues(),
            title: state.isApproved.getTitle(),
            list: state.listApproved,
            onChange: (value) {
              cubit.changeValues(isApproved: value);
              cubit.changeRequest(isApproved: value.getValues());
              cubit.getJobs();
            },
          ),
          if (widget.argument.typeAction == TypeAction.manage)
            AppItemFilter(
              valueDefault: state.expire.getValues(),
              title: state.expire.getTitle(),
              list: state.listExpire,
              onChange: (value) {
                cubit.changeValues(expire: value);
                cubit.changeRequest(expire: value.getValues());
                cubit.getJobs();
              },
            ),
        ],
      ),
    );
  }

  Widget search() {
    return Row(
      children: [
        Expanded(
          child: CustomLabelTextField(
            hintText: "Nhập tên",
            contentPadding:
                EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.w),
            radius: 16.r,
            colorBorder: AppColors.greyDF,
            textStyleHint: AppTextStyle.textSm,
            maxLine: 1,
            defaultValue: cubit.state.request.titleFilter,
            prefixIcon: Assets.icons.search.svg(
                width: 16.r,
                height: 16.r,
                colorFilter:
                    const ColorFilter.mode(AppColors.grey, BlendMode.srcIn)),
            onSubmit: (value) {
              cubit.changeVisible(false);
              cubit.getJobs();
            },
            onChanged: (value) {
              cubit.changeRequest(title: value);
            },
          ),
        ),
        SizedBox(
          width: 8.w,
        ),
        InkWell(
          onTap: () {
            cubit.changeRequest(title: '');
            cubit.changeVisible(false);
            cubit.getJobs();
          },
          child: Text(
            "Hủy",
            style: AppTextStyle.textSm,
          ),
        )
      ],
    );
  }
}
