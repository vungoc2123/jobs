import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_deep_link.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/application/enums/extract_worker.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/application/extentions/string_extension.dart';
import 'package:phu_tho_mobile/application/extentions/type_extract_worker.dart';
import 'package:phu_tho_mobile/domain/models/argument/detail_extract_worker_argument.dart';
import 'package:phu_tho_mobile/domain/models/argument/in_app_web_view_argument.dart';
import 'package:phu_tho_mobile/domain/models/request/business/business_request.dart';
import 'package:phu_tho_mobile/domain/models/request/worker/worker_request.dart';
import 'package:phu_tho_mobile/gen/assets.gen.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_bottom_sheet.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_dialog.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_label_text_field.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_load_more.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_loading.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_loading_indicator.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_toast.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/appbar_gradient_widget.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/noti_emty_list.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/woker_item_widget.dart';
import 'package:phu_tho_mobile/presentation/routes/route_name.dart';
import 'package:phu_tho_mobile/presentation/screens/business/widgets/item_tab_widget.dart';
import 'package:phu_tho_mobile/presentation/screens/manage_worker/bloc/manage_worker_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/manage_worker/bloc/manage_worker_state.dart';

class ManageWorkerScreen extends StatefulWidget {
  const ManageWorkerScreen({super.key, required this.type});

  final TypeExtractWorker type;

  @override
  State<ManageWorkerScreen> createState() => _ManageWorkerScreenState();
}

class _ManageWorkerScreenState extends State<ManageWorkerScreen> {
  late ValueNotifier<int> typeSearchOpen;
  late final ManageWorkerCubit _cubit;

  @override
  void initState() {
    super.initState();
    typeSearchOpen = ValueNotifier(0);
    _cubit = BlocProvider.of<ManageWorkerCubit>(context);
    _cubit.getWorkers(widget.type);
    _cubit.getBusiness();
  }

  String handleType(int valueType) {
    switch (valueType) {
      case 1:
        return _cubit.state.request.name ?? "";
      case 2:
        return _cubit.state.request.email ?? "";
      case 3:
        return _cubit.state.request.phoneNumber ?? "";
      default:
        return "";
    }
  }

  String handleUrl() {
    switch (widget.type) {
      case TypeExtractWorker.manageVnInForeign:
        return AppDeepLink.manageNewWorkerVnInForeign;
      case TypeExtractWorker.manageInBusiness:
        return AppDeepLink.manageNewWorkerVnInBusiness;
      default:
        return AppDeepLink.manageNewWorkerForeignInVn;
    }
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
          actions: [
            IconButton(
                onPressed: () async {
                  final handle = handleUrl();
                  final url = await handle.toResourceUrl().withUserToken();
                  if (context.mounted) {
                    Navigator.of(context).pushNamed(RouteName.inAppWebView,
                        arguments: InAppWebViewArgument(
                          label: "Thêm mới người lao động",
                          stringUrl: url,
                        ));
                  }
                },
                icon: Icon(
                  Icons.add,
                  size: 28.r,
                  color: AppColors.white,
                ))
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<ManageWorkerCubit, ManageWorkerState>(
            buildWhen: (previous, current) =>
                previous.request != current.request,
            builder: (context, state) {
              return Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ValueListenableBuilder(
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
                                      _cubit.changeTitleBusiness('');
                                      _cubit
                                          .changeRequest(const WorkerRequest());
                                      _cubit.getWorkers(widget.type);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8.r, vertical: 4.r),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                          border:
                                              Border.all(color: AppColors.blue),
                                          color: Colors.white),
                                      child: Row(
                                        children: [
                                          Assets.icons.icRefresh.svg(
                                              width: 20.r,
                                              height: 20.r,
                                              colorFilter:
                                                  const ColorFilter.mode(
                                                      AppColors.blue,
                                                      BlendMode.srcIn)),
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
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  ItemTabWidget(
                                    label: tr("fullName"),
                                    onPressed: () {
                                      typeSearchOpen.value = 1;
                                    },
                                    value: state.request.name ?? "",
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  ItemTabWidget(
                                    label: tr("email"),
                                    onPressed: () {
                                      typeSearchOpen.value = 2;
                                    },
                                    value: state.request.email ?? "",
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  ItemTabWidget(
                                    label: tr("phoneNumber"),
                                    onPressed: () {
                                      typeSearchOpen.value = 3;
                                    },
                                    value: state.request.phoneNumber ?? "",
                                  ),
                                  if (widget.type ==
                                      TypeExtractWorker.manageInBusiness) ...[
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    filterBusiness(
                                        state.titleBusiness.isNotEmpty
                                            ? state.titleBusiness
                                            : tr(tr('business'))),
                                  ]
                                ],
                              ),
                            );
                          }
                          String inputValue = handleType(valueType);
                          return Row(
                            children: [
                              Expanded(
                                child: CustomLabelTextField(
                                  maxLine: 1,
                                  defaultValue: inputValue,
                                  onSubmit: (valueLabelInput) {
                                    if (valueType == 1) {
                                      _cubit.changeRequest(_cubit.state.request
                                          .copyWith(
                                              name: valueLabelInput,
                                              pageIndex: 1));
                                    }
                                    if (valueType == 2) {
                                      _cubit.changeRequest(_cubit.state.request
                                          .copyWith(
                                              email: valueLabelInput,
                                              pageIndex: 1));
                                    }
                                    if (valueType == 3) {
                                      _cubit.changeRequest(_cubit.state.request
                                          .copyWith(
                                              phoneNumber: valueLabelInput,
                                              pageIndex: 1));
                                    }
                                    _cubit.getWorkers(widget.type);
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
                                    _cubit.changeRequest(
                                        state.request.copyWith(name: ""));
                                  }
                                  if (valueType == 2) {
                                    _cubit.changeRequest(
                                        state.request.copyWith(email: ""));
                                  }
                                  if (valueType == 3) {
                                    _cubit.changeRequest(state.request
                                        .copyWith(phoneNumber: ""));
                                  }
                                  _cubit.getWorkers(widget.type);
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
                  ],
                ),
              );
            },
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 8.h),
            child: AppLoadMore(
              onRefresh: () {
                _cubit
                    .changeRequest(_cubit.state.request.copyWith(pageIndex: 1));
                _cubit.getWorkers(widget.type);
              },
              onLoadMore: () {
                _cubit.getMoreWorkers(widget.type);
              },
              child: BlocConsumer<ManageWorkerCubit, ManageWorkerState>(
                buildWhen: (previous, current) =>
                    previous.workers != current.workers ||
                    previous.loadStatus != current.loadStatus ||
                    previous.loadMoreStatus != current.loadMoreStatus,
                listenWhen: (previous, current) =>
                    previous.statusDelete != current.statusDelete,
                listener: (context, state) {
                  if (state.statusDelete == LoadStatus.success) {
                    _cubit.changeRequest(
                        _cubit.state.request.copyWith(pageIndex: 1));
                    _cubit.getWorkers(widget.type);
                    AppToast.showToastSuccess(context, title: "Xóa thành công");
                    Navigator.pop(context);
                  }
                  if (state.statusDelete == LoadStatus.failure) {
                    Navigator.pop(context);
                    AppToast.showToastSuccess(context, title: "Xóa thất bại");
                  }
                  if (state.statusDelete == LoadStatus.loading) {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return const AppLoading();
                        });
                  }
                },
                builder: (context, state) {
                  if (state.loadStatus == LoadStatus.failure) {
                    return const Center(
                      child: Text("Không có quyền truy cập"),
                    );
                  }
                  if (state.workers.isEmpty &&
                      state.loadStatus == LoadStatus.success) {
                    return AppNotEmptyListWidget(
                      title: tr('noWorker'),
                      icon: Image.asset(
                        Assets.images.folder.path,
                        width: 70.r,
                        height: 70.r,
                      ),
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
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(context,
                                              RouteName.detailExtractWorker,
                                              arguments:
                                                  DetailWorkerExtractArgument(
                                                      idWorker: state
                                                          .workers[index].id,
                                                      type: widget.type));
                                        },
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        child: WorkerItemWidget(
                                          type: widget.type,
                                          onPressDelete: () {
                                            AppDialog.showDialogConfirm(context,
                                                label: "Xác nhận xóa",
                                                onConfirm: () {
                                              _cubit.deleteManageWorker(
                                                  state.workers[index].id);
                                              Navigator.pop(context);
                                            });
                                          },
                                          onPressUpdate: () async {
                                            final handle = handleUrl();
                                            String url = await handle
                                                .toResourceUrl()
                                                .withUserToken();
                                            final urlWithParams = url
                                                .withParam({
                                              "id": state.workers[index].id
                                            });
                                            if (context.mounted) {
                                              Navigator.of(context).pushNamed(
                                                  RouteName.inAppWebView,
                                                  arguments:
                                                      InAppWebViewArgument(
                                                    label:
                                                        "Cập nhập thông tin lao động",
                                                    stringUrl: urlWithParams,
                                                  ));
                                            }
                                          },
                                          workerResponse: state.workers[index],
                                        ),
                                      ),
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

  Widget filterBusiness(String title) {
    return InkWell(
      onTap: () async {
        await AppBottomSheet.showBottomSheet(context,
            isScroll: false,
            child: BlocProvider.value(
              value: _cubit,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16.r),
                    topLeft: Radius.circular(16.r)),
                child: BlocBuilder<ManageWorkerCubit, ManageWorkerState>(
                  buildWhen: (previous, current) =>
                      previous.requestBusiness != current.requestBusiness ||
                      previous.business != current.business ||
                      previous.loadStatusBusiness !=
                          current.loadStatusBusiness ||
                      previous.loadMoreStatusBusiness !=
                          current.loadMoreStatusBusiness,
                  builder: (BuildContext context, ManageWorkerState state) {
                    return Container(
                      color: AppColors.white,
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 20.r,
                                ),
                                Expanded(
                                  child: Text(
                                    tr("business"),
                                    style: AppTextStyle.textBase.copyWith(
                                        color: AppColors.textPrimary,
                                        fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                InkWell(
                                  onTap: () => Navigator.of(context).pop(),
                                  borderRadius: BorderRadius.circular(10.r),
                                  child: Icon(
                                    Icons.close,
                                    size: 20.r,
                                  ),
                                )
                              ],
                            ),
                          ),
                          const Divider(
                            color: AppColors.greyE5,
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 14.w, vertical: 8.h),
                              child: search()),
                          state.loadStatusBusiness == LoadStatus.loading
                              ? const Expanded(child: AppLoadingIndicator())
                              : Flexible(
                                  child: AppLoadMore(
                                    onRefresh: () {
                                      _cubit.onChangeRequestBusiness(state
                                          .requestBusiness
                                          .copyWith(pageIndex: 1));
                                      _cubit.getBusiness();
                                    },
                                    onLoadMore: () {
                                      _cubit.getMoreBusiness();
                                    },
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: state.business.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            int id = int.tryParse(state
                                                    .business[index]
                                                    .getValues()) ??
                                                0;
                                            _cubit.changeTitleBusiness(state
                                                .business[index]
                                                .getTitle());
                                            _cubit.changeRequest(state.request
                                                .copyWith(
                                                    idBusiness: id,
                                                    pageIndex: 1));
                                            _cubit.getWorkers(widget.type);
                                            Navigator.pop(context);
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16.w,
                                                vertical: 8.h),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 24.r,
                                                  height: 24.r,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      color: state.request
                                                                  .idBusiness
                                                                  .toString() ==
                                                              state.business[index]
                                                                  .getValues()
                                                          ? AppColors.blueF8
                                                          : AppColors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.r),
                                                      border: Border.all(
                                                          color: state.request
                                                                      .idBusiness
                                                                      .toString() ==
                                                                  state
                                                                      .business[index]
                                                                      .getValues()
                                                              ? AppColors.blueF8
                                                              : AppColors.greyCC)),
                                                  child: Assets.icons.check.svg(
                                                    width: 12.r,
                                                    height: 12.r,
                                                    colorFilter:
                                                        const ColorFilter.mode(
                                                            AppColors.white,
                                                            BlendMode.srcIn),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10.w,
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    state.business[index]
                                                        .getTitle(),
                                                    style: AppTextStyle.textSm
                                                        .copyWith(
                                                            color: AppColors
                                                                .grey4D),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ));
        _cubit.onChangeRequestBusiness(const BusinessRequest());
        _cubit.getBusiness();
      },
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 4.r),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
                color: _cubit.state.titleBusiness == tr('business') ||
                        _cubit.state.titleBusiness.isEmpty
                    ? AppColors.greyDF
                    : AppColors.blue)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: AppTextStyle.textSm.copyWith(color: AppColors.grey4D),
            ),
          ],
        ),
      ),
    );
  }

  Widget search() {
    return Row(
      children: [
        Expanded(
          child: CustomLabelTextField(
            hintText: tr("name"),
            contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20),
            radius: 16.r,
            colorBorder: AppColors.greyDF,
            textStyleHint: AppTextStyle.textSm,
            maxLine: 1,
            defaultValue: _cubit.state.requestBusiness.nameBusiness,
            onSubmit: (value) {
              _cubit.onChangeRequestBusiness(_cubit.state.requestBusiness
                  .copyWith(pageIndex: 1, nameBusiness: value));
              _cubit.getBusiness();
            },
            prefixIcon: Assets.icons.search.svg(
                width: 16.r,
                height: 16.r,
                colorFilter:
                    const ColorFilter.mode(AppColors.grey, BlendMode.srcIn)),
            suffixIcon: GestureDetector(
              onTap: () {
                _cubit.onChangeRequestBusiness(const BusinessRequest());
                _cubit.getBusiness();
              },
              child: Assets.icons.icCloseRound.svg(width: 16.r, height: 16.r),
            ),
          ),
        ),
      ],
    );
  }
}
