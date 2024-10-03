import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/application/extentions/string_extension.dart';
import 'package:phu_tho_mobile/gen/assets.gen.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_item_filter.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_label_text_field.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_load_more.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_loading_indicator.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_toast.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/appbar_gradient_widget.dart';
import 'package:phu_tho_mobile/presentation/screens/economic_activity/bloc/economic_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/economic_activity/bloc/economic_state.dart';
import 'package:phu_tho_mobile/presentation/screens/economic_activity/widget/item_economic_activity.dart';

class EconomicActivityScreen extends StatefulWidget {
  const EconomicActivityScreen({super.key});

  @override
  State<EconomicActivityScreen> createState() => _EconomicActivityScreenState();
}

class _EconomicActivityScreenState extends State<EconomicActivityScreen> {
  late final EconomicCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<EconomicCubit>(context);
    getAllFilter();
  }

  Future<void> getAllFilter() async {
    await cubit.getAllFilter();
    await cubit.getEconomics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: GradientAppBar(
          title: tr("employmentForEconomicParticipants"),
          leading: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: AppColors.white,
          ),
          leadingAction: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: AppColors.greyFB,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            color: AppColors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<EconomicCubit, EconomicState>(
                  buildWhen: (previous, current) =>
                      previous.searchBy != current.searchBy ||
                      previous.isShowSearch != current.isShowSearch ||
                      previous.request != current.request ||
                      previous.listTypeWork != current.listTypeWork ||
                      previous.listTypeEconomic != current.listTypeEconomic ||
                      previous.typeWork != current.typeWork ||
                      previous.typeEconomic != current.typeEconomic,
                  builder: (BuildContext context, EconomicState state) {
                    if (state.isShowSearch) {
                      return search();
                    }
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(12.r),
                            onTap: () {
                              cubit.changeRequest(reset: true);
                              cubit.getEconomics();
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
                              state.request.position != null &&
                                      state.request.position!.isNotEmpty
                                  ? state.request.position!
                                  : tr("positionEconomic"),
                              tr("positionEconomic")),
                          SizedBox(
                            width: 8.w,
                          ),
                          itemSearch(
                              state.request.location != null &&
                                      state.request.location!.isNotEmpty
                                  ? state.request.location!
                                  : tr("locationEconomic"),
                              tr("locationEconomic")),
                          SizedBox(
                            width: 8.w,
                          ),
                          AppItemFilter(
                            valueDefault: state.request.typeEconomic ?? '',
                            title: state.typeEconomic.isNotEmpty
                                ? state.typeEconomic
                                : tr("typeEconomic"),
                            list: state.listTypeEconomic,
                            onChange: (value) {
                              cubit.changeTitleFilter(
                                  typeEconomic: value.getTitle());
                              cubit.changeRequest(
                                  typeEconomic: value.getValues());
                              cubit.getEconomics();
                            },
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          AppItemFilter(
                            valueDefault: state.request.typeWork ?? '',
                            title: state.typeWork.isNotEmpty
                                ? state.typeWork
                                : tr("typeWork"),
                            list: state.listTypeWork,
                            onChange: (value) {
                              cubit.changeTitleFilter(
                                  typeWork: value.getTitle());
                              cubit.changeRequest(typeWork: value.getValues());
                              cubit.getEconomics();
                            },
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          itemSearch(
                              state.request.timeStart != null &&
                                      state.request.timeStart!.isNotEmpty
                                  ? "${tr("yearStart")}: ${state.request.timeStart!.formatToY()}"
                                  : tr("yearStart"),
                              tr("yearStart")),
                          SizedBox(
                            width: 8.w,
                          ),
                          itemSearch(
                              state.request.timeEnd != null &&
                                      state.request.timeEnd!.isNotEmpty
                                  ? "${tr("yearEnd")}: ${state.request.timeEnd!.formatToY()}"
                                  : tr("yearEnd"),
                              tr("yearEnd")),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: AppLoadMore(
              onRefresh: () {
                cubit.getEconomics();
              },
              onLoadMore: () {
                cubit.getEconomicsMore();
              },
              child: BlocBuilder<EconomicCubit, EconomicState>(
                builder: (context, state) {
                  if (state.status == LoadStatus.loading) {
                    return const AppLoadingIndicator();
                  }
                  return Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                    child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ItemEconomicActivity(
                            economicActivity: state.economics[index],
                          );
                        },
                        separatorBuilder: (context, index) => SizedBox(
                              height: 8.h,
                            ),
                        itemCount: state.economics.length),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> handleDateTime(String dateInit, bool isTimeStart) async {
    DateTime? dateTime = DateTime.tryParse(dateInit);
    final DateTime? pickedYear = await showModalBottomSheet<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300.h,
          padding: EdgeInsets.only(top: 10.h), // Điều chỉnh padding để phù hợp
          child: Column(
            children: [
              Text("Chọn năm",
                  style: AppTextStyle.textBase
                      .copyWith(fontWeight: FontWeight.w600)),
              Expanded(
                child: YearPicker(
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  selectedDate: dateTime,
                  onChanged: (DateTime selectedDate) {
                    if (isTimeStart && cubit.state.request.timeEnd != null) {
                      DateTime date = DateTime.parse(cubit.state.request.timeEnd!);
                      if(selectedDate.isAfter(date)){
                        AppToast.showToastNotify(context,
                            title: "Năm bắt đầu không được lớn hơn năm kết thúc");
                        return;
                      }
                    }
                    if (!isTimeStart && cubit.state.request.timeStart != null) {
                      DateTime date = DateTime.parse(cubit.state.request.timeStart!);
                      if(selectedDate.isBefore(date)){
                        AppToast.showToastNotify(context,
                            title: "Năm bắt đầu không được lớn hơn năm kết thúc");
                        return;
                      }
                    }
                    Navigator.pop(context, selectedDate);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
    if (pickedYear == null) return;
    if (isTimeStart) {
      cubit.changeRequest(timeStart: pickedYear.toString());
    } else {
      cubit.changeRequest(timeEnd: pickedYear.toString());
    }
    cubit.getEconomics();
  }

  Widget itemSearch(String title, String value) {
    return InkWell(
      onTap: () async {
        cubit.changeSearchBy(value);
        if (cubit.state.searchBy == tr("yearStart")) {
          handleDateTime(cubit.state.request.timeStart ?? '', true);
          return;
        }
        if (cubit.state.searchBy == tr("yearEnd")) {
          handleDateTime(cubit.state.request.timeEnd ?? '', false);
          return;
        }
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
            hintText: cubit.state.searchBy == tr("positionEconomic")
                ? tr("positionEconomic")
                : tr("locationEconomic"),
            contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20),
            radius: 16.r,
            colorBorder: AppColors.greyDF,
            textStyleHint: AppTextStyle.textSm,
            maxLine: 1,
            defaultValue: cubit.state.searchBy == tr("positionEconomic")
                ? cubit.state.request.position
                : cubit.state.request.location,
            onSubmit: (value) {
              cubit.changeVisible(false);
              cubit.getEconomics();
            },
            prefixIcon: Assets.icons.search.svg(
                width: 16.r,
                height: 16.r,
                colorFilter:
                    const ColorFilter.mode(AppColors.grey, BlendMode.srcIn)),
            onChanged: (value) {
              if (cubit.state.searchBy == tr("positionEconomic")) {
                return cubit.changeRequest(position: value);
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
            cubit.state.searchBy == tr("positionEconomic")
                ? cubit.changeRequest(position: '')
                : cubit.changeRequest(location: '');
            cubit.getEconomics();
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
