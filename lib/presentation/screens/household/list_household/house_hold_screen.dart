import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/domain/models/argument/detail_household_argument.dart';
import 'package:phu_tho_mobile/domain/models/request/household/household_request.dart';
import 'package:phu_tho_mobile/domain/models/response/filter_response/filter_response.dart';
import 'package:phu_tho_mobile/gen/assets.gen.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_item_filter.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_label_text_field.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_load_more.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_loading_indicator.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/emty_list_data.dart';
import 'package:phu_tho_mobile/presentation/routes/route_name.dart';
import 'package:phu_tho_mobile/presentation/screens/business/widgets/item_tab_widget.dart';
import 'package:phu_tho_mobile/presentation/screens/household/list_household/households_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/household/list_household/list_household_state.dart';
import 'package:phu_tho_mobile/presentation/screens/list_job/widget/gradian_appbar.dart';

import '../widgets/household_widget.dart';

class HouseholdScreen extends StatefulWidget {
  const HouseholdScreen({super.key});

  @override
  State<HouseholdScreen> createState() => _HouseholdScreenState();
}

class _HouseholdScreenState extends State<HouseholdScreen> {
  late HouseholdsCubit _cubit;
  late ValueNotifier<int> typeSearchOpen;

  @override
  void initState() {
    super.initState();
    typeSearchOpen = ValueNotifier(0);
    _cubit = BlocProvider.of<HouseholdsCubit>(context);
    _cubit.getAreas();
    _cubit.getHouseholds();
    _cubit.getDistricts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyFB,
      appBar: GradientAppBar(
        isOpenSearch: false,
        title: Text(
          tr('household'),
          style: AppTextStyle.textBase
              .copyWith(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        gradient: const LinearGradient(
            colors: [AppColors.blue44, AppColors.blueF8],
            begin: Alignment.topLeft,
            end: Alignment.topRight),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            color: Colors.white,
            child: BlocBuilder<HouseholdsCubit, HouseHoldsState>(
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                borderRadius: BorderRadius.circular(12.r),
                                onTap: () {
                                  _cubit.onChangeFilterArea(FilterResponse(
                                      text: tr("areas"), value: ""));
                                  _cubit.onChangeFilterDistrict(FilterResponse(
                                      text: tr("district"), value: ""));
                                  _cubit.onChangeFilterCommune(FilterResponse(
                                      text: tr("nameCommune"), value: ""));
                                  _cubit.onChangeRequest(
                                      const HouseholdRequest());
                                  _cubit.getHouseholds();
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
                              SizedBox(
                                width: 8.w,
                              ),
                              ItemTabWidget(
                                label: tr("householdRegistrationBook"),
                                onPressed: () {
                                  typeSearchOpen.value = 1;
                                },
                                value: _cubit.state.request
                                        .householdRegistrationBook ??
                                    "",
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              ItemTabWidget(
                                label: tr("fullNameOfHouseholdHead"),
                                onPressed: () {
                                  typeSearchOpen.value = 2;
                                },
                                value:
                                    state.request.fullNameOfHouseholdHead ?? "",
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              ItemTabWidget(
                                label: tr("idNumberOfHouseholdHead"),
                                onPressed: () {
                                  typeSearchOpen.value = 3;
                                },
                                value:
                                    state.request.idNumberOfHouseholdHead ?? "",
                              ),
                              SizedBox(
                                width: 4.w,
                              ),
                              BlocBuilder<HouseholdsCubit, HouseHoldsState>(
                                buildWhen: (pre, cur) =>
                                    pre.loadAreas != cur.loadAreas ||
                                    pre.request != cur.request,
                                builder: (context, state) {
                                  if (state.loadAreas == LoadStatus.failure) {
                                    return ItemTabWidget(
                                        label: tr("error"), onPressed: () {});
                                  }
                                  if (state.loadAreas == LoadStatus.success) {
                                    return AppItemFilter(
                                      valueDefault:
                                          state.filterResponseArea.value,
                                      title: state.filterResponseArea.text,
                                      list: state.areas,
                                      onChange: (value) {
                                        _cubit.onChangeFilterArea(value);
                                        _cubit.onChangeRequest(
                                            _cubit.state.request.copyWith(
                                                area: value.getValues(),
                                                pageIndex: 1));
                                        _cubit.getHouseholds();
                                      },
                                    );
                                  }
                                  return SizedBox(
                                      width: 70.w,
                                      child: const AppLoadingIndicator());
                                },
                              ),
                              BlocBuilder<HouseholdsCubit, HouseHoldsState>(
                                buildWhen: (pre, cur) =>
                                    pre.loadDistrictStatus !=
                                        cur.loadDistrictStatus ||
                                    pre.request != cur.request,
                                builder: (context, state) {
                                  if (state.loadDistrictStatus ==
                                      LoadStatus.failure) {
                                    return ItemTabWidget(
                                        label: tr("error"), onPressed: () {});
                                  }
                                  if (state.loadDistrictStatus ==
                                      LoadStatus.success) {
                                    return AppItemFilter(
                                      searching: true,
                                      valueDefault:
                                          state.filterResponseDistrict.value,
                                      title: state.filterResponseDistrict.text,
                                      list: state.districts,
                                      onChange: (value) {
                                        _cubit.onChangeFilterDistrict(value);
                                        _cubit.getCommunes(value.getValues());
                                        _cubit.onChangeRequest(
                                            _cubit.state.request.copyWith(
                                                districtName: value.getValues(),
                                                pageIndex: 1));
                                        _cubit.getHouseholds();
                                      },
                                    );
                                  }
                                  return SizedBox(
                                      width: 70.w,
                                      child: const AppLoadingIndicator());
                                },
                              ),
                              BlocBuilder<HouseholdsCubit, HouseHoldsState>(
                                buildWhen: (pre, cur) =>
                                    pre.loadCommuneStatus !=
                                        cur.loadCommuneStatus ||
                                    pre.request != cur.request,
                                builder: (context, state) {
                                  if (state.loadCommuneStatus ==
                                      LoadStatus.failure) {
                                    return ItemTabWidget(
                                        label: tr("error"), onPressed: () {});
                                  }
                                  if (state.loadCommuneStatus ==
                                      LoadStatus.success) {
                                    return AppItemFilter(
                                      searching: true,
                                      valueDefault:
                                          state.filterResponseCommunes.value,
                                      title: state.filterResponseCommunes.text,
                                      list: state.communes,
                                      onChange: (value) {
                                        _cubit.onChangeFilterCommune(value);
                                        _cubit.onChangeRequest(
                                            _cubit.state.request.copyWith(
                                                communeName: value.getValues(),
                                                pageIndex: 1));
                                        _cubit.getHouseholds();
                                      },
                                    );
                                  }
                                  if (state.loadCommuneStatus ==
                                      LoadStatus.loading) {
                                    return SizedBox(
                                        width: 70.w,
                                        child: const AppLoadingIndicator());
                                  }
                                  return AppItemFilter(
                                    valueDefault:
                                        state.filterResponseCommunes.value,
                                    title: state.filterResponseCommunes.text,
                                    list: state.communes,
                                    onChange: (value) {},
                                  );
                                },
                              )
                            ],
                          ),
                        );
                      }
                      String inputValue = (valueType == 1)
                          ? state.request.householdRegistrationBook ?? ""
                          : (valueType == 2)
                              ? state.request.fullNameOfHouseholdHead ?? ""
                              : (valueType == 3)
                                  ? state.request.idNumberOfHouseholdHead ?? ""
                                  : "";
                      return Row(
                        children: [
                          Expanded(
                            child: CustomLabelTextField(
                              maxLine: 1,
                              defaultValue: inputValue,
                              onSubmit: (valueLabelInput) {
                                if (valueType == 1) {
                                  _cubit.onChangeRequest(_cubit.state.request
                                      .copyWith(
                                          householdRegistrationBook:
                                              valueLabelInput,
                                          pageIndex: 1));
                                }
                                if (valueType == 2) {
                                  _cubit.onChangeRequest(_cubit.state.request
                                      .copyWith(
                                          fullNameOfHouseholdHead:
                                              valueLabelInput,
                                          pageIndex: 1));
                                }
                                if (valueType == 3) {
                                  _cubit.onChangeRequest(_cubit.state.request
                                      .copyWith(
                                          idNumberOfHouseholdHead:
                                              valueLabelInput,
                                          pageIndex: 1));
                                }
                                _cubit.getHouseholds();
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
                                _cubit.onChangeRequest(_cubit.state.request
                                    .copyWith(
                                        householdRegistrationBook: "",
                                        pageIndex: 1));
                              }
                              if (valueType == 2) {
                                _cubit.onChangeRequest(_cubit.state.request
                                    .copyWith(
                                        fullNameOfHouseholdHead: "",
                                        pageIndex: 1));
                              }
                              if (valueType == 3) {
                                _cubit.onChangeRequest(_cubit.state.request
                                    .copyWith(
                                        idNumberOfHouseholdHead: "",
                                        pageIndex: 1));
                              }
                              _cubit.getHouseholds();
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
          ),
          Expanded(
              child: BlocBuilder<HouseholdsCubit, HouseHoldsState>(
            buildWhen: (pre, cur) =>
                pre.loadStatus != cur.loadStatus ||
                pre.loadMoreStatus != cur.loadMoreStatus,
            builder: (context, state) {
              if (state.loadStatus == LoadStatus.failure) {
                return const Center(
                  child: Text("Error"),
                );
              }
              if (state.loadStatus == LoadStatus.success) {
                if (state.households.isEmpty) {
                  return const Center(child: EmptyListData());
                }
                return AppLoadMore(
                  onRefresh: () {
                    _cubit.onChangeRequest(
                        _cubit.state.request.copyWith(pageIndex: 1));
                    _cubit.getHouseholds();
                  },
                  onLoadMore: () {
                    _cubit.getMoreHouseholds();
                  },
                  child: ListView.separated(
                      padding: EdgeInsets.all(12.r),
                      itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  RouteName.membersHousehold,
                                  arguments: DetailHouseholdArgument(
                                      householdResponse:
                                          state.households[index]));
                            },
                            child: HouseholdItemWidget(
                              household: state.households[index],
                            ),
                          ),
                      separatorBuilder: (_, __) => SizedBox(
                            height: 12.h,
                          ),
                      itemCount: state.households.length),
                );
              }
              return const Center(
                child: AppLoadingIndicator(),
              );
            },
          ))
        ],
      ),
    );
  }
}
