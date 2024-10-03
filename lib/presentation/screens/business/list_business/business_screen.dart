import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_deep_link.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/application/enums/type_action.dart';
import 'package:phu_tho_mobile/application/extentions/string_extension.dart';
import 'package:phu_tho_mobile/domain/models/argument/detail_business_argument.dart';
import 'package:phu_tho_mobile/domain/models/argument/in_app_web_view_argument.dart';
import 'package:phu_tho_mobile/domain/models/response/filter_response/filter_response.dart';
import 'package:phu_tho_mobile/gen/assets.gen.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_dialog.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_item_filter.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_label_text_field.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_load_more.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_loading.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_loading_indicator.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_toast.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/appbar_gradient_widget.dart';
import 'package:phu_tho_mobile/presentation/routes/route_name.dart';
import 'package:phu_tho_mobile/presentation/screens/business/list_business/business_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/business/list_business/business_state.dart';
import 'package:phu_tho_mobile/presentation/screens/business/widgets/business_widget.dart';
import 'package:phu_tho_mobile/presentation/screens/business/widgets/item_tab_widget.dart';

class BusinessScreen extends StatefulWidget {
  final TypeAction type;

  const BusinessScreen({super.key, required this.type});

  @override
  State<BusinessScreen> createState() => _BusinessScreenState();
}

class _BusinessScreenState extends State<BusinessScreen> {
  late BusinessCubit _cubit;
  late ValueNotifier<int> typeSearchOpen;

  @override
  void initState() {
    typeSearchOpen = ValueNotifier(0);
    super.initState();
    _cubit = BlocProvider.of<BusinessCubit>(context);
    _cubit.getStatusBusiness();
    _cubit.changeTypeAction(widget.type);
    _cubit.getBusiness();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: GradientAppBar(
          title: tr("business"),
          leading: widget.type == TypeAction.manage
              ? const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.white,
                )
              : null,
          leadingAction: () {
            Navigator.pop(context);
          },
          actions: [
            if (widget.type == TypeAction.manage)
              IconButton(
                  onPressed: () async {
                    final url = await AppDeepLink.manageCreateBusiness
                        .toResourceUrl()
                        .withUserToken();
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
                    color: Colors.white,
                  ))
          ],
        ),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal:12.w,vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<BusinessCubit, BusinessState>(
                buildWhen: (previous, current) =>
                    previous.request != current.request,
                builder: (context, state) {
                  return ValueListenableBuilder(
                      valueListenable: typeSearchOpen,
                      builder: (context, valueType, _) {
                        if (valueType == 0) {
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    InkWell(
                                      borderRadius: BorderRadius.circular(12.r),
                                      onTap: () {
                                        _cubit.onChangeFilterStatus(
                                            FilterResponse(
                                                text: tr("status"), value: ""));
                                        _cubit.onChangeRequest(
                                            _cubit.state.request.copyWith(
                                                nameBusiness: '',
                                                taxCode: "",
                                                address: "",
                                                pageIndex: 1,
                                                status: ""));
                                        _cubit.getBusiness();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.r, vertical: 4.r),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12.r),
                                            border: Border.all(
                                                color: AppColors.blue),
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
                                              style: AppTextStyle.textSm
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w400,
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
                                      label: tr("nameBusiness"),
                                      onPressed: () {
                                        typeSearchOpen.value = 1;
                                      },
                                      value: state.request.nameBusiness ?? "",
                                    ),
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    ItemTabWidget(
                                      label: tr("taxCode"),
                                      onPressed: () {
                                        typeSearchOpen.value = 2;
                                      },
                                      value: state.request.taxCode ?? "",
                                    ),
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    ItemTabWidget(
                                      label: tr("address"),
                                      onPressed: () {
                                        typeSearchOpen.value = 3;
                                      },
                                      value: state.request.address ?? "",
                                    ),
                                    SizedBox(
                                      width: 4.w,
                                    ),
                                    BlocBuilder<BusinessCubit, BusinessState>(
                                      buildWhen: (pre, cur) =>
                                          pre.loadStatusBusiness !=
                                              cur.loadStatusBusiness ||
                                          pre.request != cur.request,
                                      builder: (context, state) {
                                        if (state.loadStatusBusiness ==
                                            LoadStatus.failure) {
                                          return ItemTabWidget(
                                              label: tr("error"),
                                              onPressed: () {});
                                        }
                                        if (state.loadStatusBusiness ==
                                            LoadStatus.success) {
                                          return AppItemFilter(
                                            valueDefault:
                                                state.filterResponse.value,
                                            title: state.filterResponse.text,
                                            list: state.statusBusiness,
                                            onChange: (value) {
                                              _cubit
                                                  .onChangeFilterStatus(value);
                                              _cubit.onChangeRequest(
                                                  _cubit.state.request.copyWith(
                                                      status: value.getValues(),
                                                      pageIndex: 1));
                                              _cubit.getBusiness();
                                            },
                                          );
                                        }
                                        return const AppLoadingIndicator();
                                      },
                                    )
                                  ],
                                ),
                              ],
                            ),
                          );
                        }
                        String inputValue = (valueType == 1)
                            ? state.request.nameBusiness ?? ""
                            : (valueType == 2)
                                ? state.request.taxCode ?? ""
                                : (valueType == 3)
                                    ? state.request.address ?? ""
                                    : "";
                        return Row(
                          children: [
                            Expanded(
                              child: CustomLabelTextField(
                                maxLine: 1,
                                defaultValue: inputValue,
                                onSubmit: (valueLabelInput) {
                                  if (valueType == 1) {
                                    _cubit.onChangeRequest(state.request.copyWith(
                                        nameBusiness: valueLabelInput, pageIndex: 1));
                                    _cubit.getBusiness();
                                  }
                                  if (valueType == 2) {
                                    _cubit.onChangeRequest(state.request.copyWith(
                                        taxCode: valueLabelInput, pageIndex: 1));
                                    _cubit.getBusiness();
                                  }
                                  if (valueType == 3) {
                                    _cubit.onChangeRequest(state.request.copyWith(
                                        address: valueLabelInput, pageIndex: 1));
                                    _cubit.getBusiness();
                                  }
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
                                hintText: "Nhập...",
                                textStyleHint: AppTextStyle.textSm,
                              ),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            InkWell(
                              onTap: () {
                                if (valueType == 1) {
                                  _cubit.onChangeRequest(state.request
                                      .copyWith(nameBusiness: "", pageIndex: 1));
                                  _cubit.getBusiness();
                                }
                                if (valueType == 2) {
                                  _cubit.onChangeRequest(state.request
                                      .copyWith(taxCode: "", pageIndex: 1));
                                  _cubit.getBusiness();
                                }
                                if (valueType == 3) {
                                  _cubit.onChangeRequest(state.request
                                      .copyWith(address: "", pageIndex: 1));
                                  _cubit.getBusiness();
                                }
                                typeSearchOpen.value = 0;
                              },
                              child: Text(
                                "Hủy",
                                style: AppTextStyle.textSm,
                              ),
                            )
                          ],
                        );
                      });
                },
              ),
            ],
          ),
        ),
        BlocConsumer<BusinessCubit, BusinessState>(
            listenWhen: (pre, cur) => pre.deleteStatus != cur.deleteStatus,
            listener: (context, state) {
              if (state.deleteStatus == LoadStatus.loading) {
                showDialog(
                    context: context,
                    builder: (context) => const AppLoading(),
                    barrierDismissible: false);
              }
              if (state.loadStatus == LoadStatus.success) {
                AppToast.showToastSuccess(context,
                    title: "Xóa thông tin doanh nghiệp thành công!");
                Navigator.of(context).pop();
                _cubit.getBusiness();
              }
              if (state.loadStatus == LoadStatus.failure) {
                AppToast.showToastError(context,
                    title: "Xóa thông tin doanh nghiệp thất bại");
                Navigator.of(context).pop();
              }
            },
            buildWhen: (previous, current) =>
                previous.loadStatus != current.loadStatus ||
                previous.loadMoreStatus != current.loadMoreStatus,
            builder: (context, state) {
              if (state.loadStatus == LoadStatus.failure) {
                return const Expanded(
                    child: Center(
                  child: Text("Error"),
                ));
              }
              if (state.loadStatus == LoadStatus.success) {
                return Expanded(
                  child: AppLoadMore(
                    onRefresh: () {
                      _cubit.onChangeRequest(
                          state.request.copyWith(pageIndex: 1));
                      _cubit.getBusiness();
                    },
                    onLoadMore: () {
                      _cubit.getMoreBusiness();
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Column(
                            children: List.generate(
                                state.business.length,
                                (index) => Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context).pushNamed(
                                                RouteName.detailBusiness,
                                                arguments:
                                                    DetailBusinessArgument(
                                                        idBusiness: state
                                                            .business[index].id,
                                                        type: state.type));
                                          },
                                          child: BusinessWidget(
                                            businessResponse:
                                                state.business[index],
                                            typeAction: state.type,
                                            onDelete: () {
                                              AppDialog.showDialogConfirm(
                                                  context,
                                                  label: "Xác nhận xóa",
                                                  onConfirm: () {
                                                _cubit.deleteBusiness(
                                                    state.business[index].id);
                                                Navigator.of(context).pop();
                                              });
                                            },
                                            onEdit: () async {
                                              final url = await AppDeepLink
                                                  .manageEditBusiness
                                                  .toResourceUrl()
                                                  .withUserToken();
                                              final urlWithParams = url
                                                  .withParam({
                                                "id": state.business[index].id
                                              });
                                              if (context.mounted) {
                                                Navigator.of(context).pushNamed(
                                                    RouteName.inAppWebView,
                                                    arguments:
                                                        InAppWebViewArgument(
                                                      label: tr('editBusiness'),
                                                      stringUrl: urlWithParams,
                                                    ));
                                              }
                                            },
                                          ),
                                        ),
                                        const Divider(
                                          color: AppColors.greyF6,
                                        )
                                      ],
                                    )),
                          ),
                          if (state.loadMoreStatus == LoadStatus.loading)
                            const AppLoadingIndicator()
                        ],
                      ),
                    ),
                  ),
                );
              }
              return const Expanded(
                  child: Center(
                child: AppLoadingIndicator(),
              ));
            }),
      ]),
    );
  }
}
