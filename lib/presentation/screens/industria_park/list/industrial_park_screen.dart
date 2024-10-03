import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_deep_link.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/application/enums/type_industrial_park.dart';
import 'package:phu_tho_mobile/application/extentions/string_extension.dart';
import 'package:phu_tho_mobile/domain/models/argument/in_app_web_view_argument.dart';
import 'package:phu_tho_mobile/gen/assets.gen.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_dialog.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_label_text_field.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_load_more.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_loading.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_loading_indicator.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_toast.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/appbar_gradient_widget.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/noti_emty_list.dart';
import 'package:phu_tho_mobile/presentation/routes/route_name.dart';
import 'package:phu_tho_mobile/presentation/screens/industria_park/list/bloc/industrial_park_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/industria_park/list/bloc/industrial_park_state.dart';
import 'package:phu_tho_mobile/presentation/screens/industria_park/list/widget/item_industrial_park.dart';

class IndustrialPark extends StatefulWidget {
  const IndustrialPark({super.key, required this.type});

  final TypeIndustrialPark type;

  @override
  State<IndustrialPark> createState() => _IndustrialParkState();
}

class _IndustrialParkState extends State<IndustrialPark> {
  late final IndustrialParkCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<IndustrialParkCubit>(context);
    cubit.getIndustrialParks(widget.type);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: GradientAppBar(
          title: tr("industrialPark"),
          leading: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: AppColors.white,
          ),
          leadingAction: () {
            Navigator.pop(context);
          },
          actions: [
            widget.type == TypeIndustrialPark.manageIndustrialPark
                ? IconButton(
                    onPressed: () async {
                      final url = await AppDeepLink.manageCreateIndustrialPark
                          .toResourceUrl()
                          .withUserToken();
                      if (context.mounted) {
                        Navigator.of(context).pushNamed(RouteName.inAppWebView,
                            arguments: InAppWebViewArgument(
                              label: tr('createIndustrialPark'),
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
      backgroundColor: AppColors.greyFB,
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          color: AppColors.white,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          child: Column(
            children: [
              BlocBuilder<IndustrialParkCubit, IndustrialParkState>(
                buildWhen: (previous, current) =>
                    previous.searchBy != current.searchBy ||
                    previous.isShowSearch != current.isShowSearch ||
                    previous.request != current.request,
                builder: (BuildContext context, IndustrialParkState state) {
                  if (state.isShowSearch) {
                    return search();
                  }
                  return Row(
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(12.r),
                        onTap: () {
                          cubit.changeRequest(
                              pageIndex: 1, pageSize: 10, location: '', name: '');
                          cubit.getIndustrialParks(widget.type);
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
                      itemSearch(
                          state.request.name.isNotEmpty
                              ? state.request.name
                              : tr("name"),
                          tr("name")),
                      SizedBox(
                        width: 8.w,
                      ),
                      itemSearch(
                          state.request.location.isNotEmpty
                              ? state.request.location
                              : tr("locationIndustrialPark"),
                          tr("locationIndustrialPark")),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
        Expanded(
          child: AppLoadMore(
            onRefresh: () {
              cubit.getIndustrialParks(widget.type);
            },
            onLoadMore: () {
              cubit.getIndustrialParksMore(widget.type);
            },
            child: BlocConsumer<IndustrialParkCubit, IndustrialParkState>(
              buildWhen: (previous, current) =>
                  previous.industrialParks != current.industrialParks ||
                  previous.status != current.status ||
                  previous.statusMore != current.statusMore,
              listenWhen: (previous, current) =>
                  previous.statusDelete != current.statusDelete,
              listener: (context, state) {
                if (state.statusDelete == LoadStatus.success) {
                  cubit.changeRequest(pageIndex: 1);
                  cubit.getIndustrialParks(widget.type);
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
              builder: (BuildContext context, IndustrialParkState state) {
                if (state.status == LoadStatus.loading) {
                  return const AppLoadingIndicator();
                }
                if (state.status == LoadStatus.success &&
                    state.industrialParks.isEmpty) {
                  return AppNotEmptyListWidget(
                      title: tr("noIndustrialPark"),
                      icon: Image.asset(
                        Assets.images.folder.path,
                        width: 70.r,
                        height: 70.r,
                      ));
                }
                return SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Column(
                      children: [
                        ListView.separated(
                          itemCount: state.industrialParks.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return ItemIndustrialPark(
                              industrialPark: state.industrialParks[index],
                              onPressDelete: widget.type ==
                                      TypeIndustrialPark.manageIndustrialPark
                                  ? () {
                                      AppDialog.showDialogConfirm(context,
                                          label: "Xác nhận xóa", onConfirm: () {
                                        cubit.deleteIndustrialPark(
                                            state.industrialParks[index].id);
                                        Navigator.pop(context);
                                      });
                                    }
                                  : null,
                              onPressUpdate: widget.type ==
                                      TypeIndustrialPark.manageIndustrialPark
                                  ? () async {
                                      final url = await AppDeepLink
                                          .manageEditIndustrialPark
                                          .toResourceUrl()
                                          .withUserToken();
                                      final urlWithParams = url.withParam({
                                        "id": state.industrialParks[index].id
                                      });
                                      if (context.mounted) {
                                        Navigator.of(context).pushNamed(
                                          RouteName.inAppWebView,
                                          arguments: InAppWebViewArgument(
                                              label: tr('updateIndustrialPark'),
                                              stringUrl: urlWithParams),
                                        );
                                      }
                                    }
                                  : null,
                            );
                          },
                          separatorBuilder: (context, index) => SizedBox(
                            height: 8.h,
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ]),
    );
  }

  Widget itemSearch(String title, String value) {
    return InkWell(
      onTap: () {
        cubit.changeSearchBy(value);
        cubit.changeVisible(true);
      },
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
                color: title == value ? AppColors.greyDF : AppColors.blue)),
        child: Text(
          title,
          style: AppTextStyle.textSm
              .copyWith(color: AppColors.grey4D, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }

  Widget search() {
    return Row(
      children: [
        Expanded(
          child: CustomLabelTextField(
            hintText: cubit.state.searchBy == tr("name")
                ? tr("writeName")
                : tr("writeLocation"),
            contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20),
            radius: 16.r,
            colorBorder: AppColors.greyDF,
            textStyleHint: AppTextStyle.textSm,
            maxLine: 1,
            defaultValue: cubit.state.searchBy == tr("name")
                ? cubit.state.request.name
                : cubit.state.request.location,
            onSubmit: (value) {
              cubit.changeVisible(false);
              cubit.getIndustrialParks(widget.type);
            },
            prefixIcon: Assets.icons.search.svg(
                width: 16.r,
                height: 16.r,
                colorFilter:
                    const ColorFilter.mode(AppColors.grey, BlendMode.srcIn)),
            onChanged: (value) {
              if (cubit.state.searchBy == tr("name")) {
                return cubit.changeRequest(name: value);
              }
              cubit.changeRequest(location: value);
            },
          ),
        ),
        SizedBox(
          width: 8.w,
        ),
        InkWell(
          onTap: () {
            cubit.changeVisible(false);
            cubit.state.searchBy == tr("name")
                ? cubit.changeRequest(name: '')
                : cubit.changeRequest(location: '');
            cubit.getIndustrialParks(widget.type);
          },
          child: Text(
            tr("Cancel"),
            style: AppTextStyle.textSm,
          ),
        )
      ],
    );
  }
}
