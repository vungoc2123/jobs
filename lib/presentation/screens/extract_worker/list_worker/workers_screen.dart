import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/application/enums/extract_worker.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/application/extentions/type_extract_worker.dart';
import 'package:phu_tho_mobile/domain/models/argument/detail_extract_worker_argument.dart';
import 'package:phu_tho_mobile/domain/models/request/worker/worker_request.dart';
import 'package:phu_tho_mobile/gen/assets.gen.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_label_text_field.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_load_more.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_loading_indicator.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/appbar_gradient_widget.dart';
import 'package:phu_tho_mobile/presentation/routes/route_name.dart';
import 'package:phu_tho_mobile/presentation/screens/business/widgets/item_tab_widget.dart';
import 'package:phu_tho_mobile/presentation/screens/extract_worker/list_worker/worker_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/extract_worker/list_worker/workers_state.dart';

import '../../../common_widgets/woker_item_widget.dart';

class WorkersScreen extends StatefulWidget {
  final TypeExtractWorker type;

  const WorkersScreen({super.key, required this.type});

  @override
  State<WorkersScreen> createState() => _WorkersScreenState();
}

class _WorkersScreenState extends State<WorkersScreen> {
  late ValueNotifier<int> typeSearchOpen;
  late WorkerCubit _cubit;

  @override
  void initState() {
    typeSearchOpen = ValueNotifier(0);
    _cubit = BlocProvider.of<WorkerCubit>(context);
    _cubit.changeTypeWorker(widget.type);
    _cubit.getWorkers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyFB,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: GradientAppBar(
          title: widget.type.nameTitle,
          leading: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
          ),
          leadingAction: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<WorkerCubit, WorkerState>(
            buildWhen: (previous, current) =>
                previous.request != current.request,
            builder: (context, state) {
              return Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal:12.w,vertical: 8.h),
                child: ValueListenableBuilder(
                    valueListenable: typeSearchOpen,
                    builder: (context, valueType, _) {
                      if (valueType == 0) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                borderRadius: BorderRadius.circular(12.r),
                                onTap: () {
                                  _cubit.changeRequest(const WorkerRequest());
                                  _cubit.getWorkers();
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.r, vertical: 4.r),
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
                              SizedBox(width: 8.w),
                              ItemTabWidget(
                                label: tr("fullName"),
                                onPressed: () {
                                  typeSearchOpen.value = 1;
                                },
                                value: _cubit.state.request.name ?? "",
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              ItemTabWidget(
                                label: tr("email"),
                                onPressed: () {
                                  typeSearchOpen.value = 2;
                                },
                                value: _cubit.state.request.email ?? "",
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              ItemTabWidget(
                                label: tr("phoneNumber"),
                                onPressed: () {
                                  typeSearchOpen.value = 3;
                                },
                                value: _cubit.state.request.phoneNumber ?? "",
                              ),
                            ],
                          ),
                        );
                      }
                      String inputValue = (valueType == 1)
                          ? _cubit.state.request.name ?? ""
                          : (valueType == 2)
                              ? _cubit.state.request.email ?? ""
                              : (valueType == 3)
                                  ? _cubit.state.request.phoneNumber ?? ""
                                  : "";
                      return Row(
                        children: [
                          Expanded(
                            child: CustomLabelTextField(
                              maxLine: 1,
                              defaultValue: inputValue,
                              onSubmit: (valueLabelInput) {
                                if (valueType == 1) {
                                  _cubit.changeRequest(_cubit.state.request
                                      .copyWith(name: valueLabelInput, pageIndex: 1));
                                }
                                if (valueType == 2) {
                                  _cubit.changeRequest(_cubit.state.request.copyWith(
                                      email: valueLabelInput, pageIndex: 1));
                                }
                                if (valueType == 3) {
                                  _cubit.changeRequest(_cubit.state.request.copyWith(
                                      phoneNumber: valueLabelInput, pageIndex: 1));
                                }
                                _cubit.getWorkers();
                                typeSearchOpen.value = 0;
                              },
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12.r, vertical: 8.r),
                              radius: 16.r,
                              colorBorder: AppColors.greyE5,
                              prefixIcon: Assets.icons.search.svg(
                                  colorFilter: const ColorFilter.mode(
                                      AppColors.grey73, BlendMode.srcIn)),
                              backgroundColor: AppColors.greyFB,
                              hintText: tr("type..."),
                              textStyleHint: AppTextStyle.textSm,
                            ),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          InkWell(
                            onTap: () {
                              if (valueType == 1) {
                                _cubit.changeRequest(state.request
                                    .copyWith(name: "", pageIndex: 1));
                              }
                              if (valueType == 2) {
                                _cubit.changeRequest(state.request
                                    .copyWith(email: "", pageIndex: 1));
                              }
                              if (valueType == 3) {
                                _cubit.changeRequest(state.request
                                    .copyWith(phoneNumber: "", pageIndex: 1));
                              }
                              _cubit.getWorkers();
                              typeSearchOpen.value = 0;
                            },
                            child: Text(
                              "Hủy",
                              style: AppTextStyle.textSm,
                            ),
                          )
                        ],
                      );
                    }),
              );
            },
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 8.h),
            child: AppLoadMore(
              onRefresh: () {
                _cubit.getWorkers();
              },
              onLoadMore: () {
                _cubit.getMoreWorkers();
              },
              child: BlocBuilder<WorkerCubit, WorkerState>(
                buildWhen: (previous, current) =>
                    previous.loadStatus != current.loadStatus ||
                    previous.loadMoreStatus != current.loadMoreStatus,
                builder: (context, state) {
                  if (state.loadStatus == LoadStatus.failure) {
                    return const Center(
                      child: Text("Không có quyền truy cập"),
                    );
                  }
                  if (state.loadStatus == LoadStatus.success) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Column(
                            children: List.generate(
                                state.workers.length,
                                (index) => Padding(
                                      padding: EdgeInsets.only(bottom: 8.h),
                                      child: GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pushNamed(
                                                RouteName.detailExtractWorker,
                                                arguments:
                                                    DetailWorkerExtractArgument(
                                                        idWorker: state
                                                            .workers[index].id,
                                                        type: widget.type));
                                          },
                                          child: WorkerItemWidget(
                                            workerResponse:
                                                state.workers[index],
                                            type: widget.type,
                                          )),
                                    )),
                          ),
                          if (state.loadMoreStatus == LoadStatus.loading)
                            const AppLoadingIndicator()
                        ],
                      ),
                    );
                  }
                  return const Center(
                    child: AppLoadingIndicator(),
                  );
                },
              ),
            ),
          ))
        ],
      ),
    );
  }
}
