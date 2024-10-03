import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/application/extentions/string_extension.dart';
import 'package:phu_tho_mobile/gen/assets.gen.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_label_text_field.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_load_more.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_loading_indicator.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/appbar_gradient_widget.dart';
import 'package:phu_tho_mobile/presentation/screens/trading_job/bloc/trading_job_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/trading_job/bloc/trading_job_state.dart';
import 'package:phu_tho_mobile/presentation/screens/trading_job/widget/item_trading_job.dart';

class TradingJobScreen extends StatefulWidget {
  const TradingJobScreen({super.key});

  @override
  State<TradingJobScreen> createState() => _TradingJobScreenState();
}

class _TradingJobScreenState extends State<TradingJobScreen> {
  late final TradingJobCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<TradingJobCubit>(context);
    cubit.getTradingJobs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: GradientAppBar(
          title: tr("tradingJob"),
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
      body: Column(children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          color: AppColors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<TradingJobCubit, TradingJobState>(
                buildWhen: (previous, current) =>
                    previous.searchBy != current.searchBy ||
                    previous.isShowSearch != current.isShowSearch ||
                    previous.request != current.request,
                builder: (BuildContext context, TradingJobState state) {
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
                            cubit.getTradingJobs();
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
                            state.request.name != null &&
                                    state.request.name!.isNotEmpty
                                ? state.request.name!
                                : tr("name"),
                            tr("name")),
                        SizedBox(
                          width: 8.w,
                        ),
                        itemSearch(
                            state.request.code != null &&
                                    state.request.code!.isNotEmpty
                                ? state.request.code!
                                : tr("codeTradingJob"),
                            tr("codeTradingJob")),
                        SizedBox(
                          width: 8.w,
                        ),
                        itemSearch(
                            state.request.timeStart != null &&
                                    state.request.timeStart!.isNotEmpty
                                ? "${tr("timeStart")}: ${state.request.timeStart!.formatToDMY()}"
                                : tr("timeStart"),
                            tr("timeStart")),
                        SizedBox(
                          width: 8.w,
                        ),
                        itemSearch(
                            state.request.timeEnd != null &&
                                    state.request.timeEnd!.isNotEmpty
                                ? "${tr("timeEnd")}: ${state.request.timeEnd!.formatToDMY()}"
                                : tr("timeEnd"),
                            tr("timeEnd")),
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
              cubit.getTradingJobs();
            },
            onLoadMore: () {
              cubit.getTradingJobsMore();
            },
            child: BlocBuilder<TradingJobCubit, TradingJobState>(
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
                        return ItemTradingJob(
                          tradingJob: state.tradingJobs[index],
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                            height: 8.h,
                          ),
                      itemCount: state.tradingJobs.length),
                );
              },
            ),
          ),
        )
      ]),
    );
  }

  Future<void> handleDateTime(String dateInit, bool isTimeStart) async {
    DateTime? dateTime = DateTime.tryParse(dateInit);
    final DateTime? selectedDay = await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(3000),
      selectableDayPredicate: (DateTime day) {
        if (isTimeStart && cubit.state.request.timeEnd != null) {
          DateTime date = DateTime.parse(cubit.state.request.timeEnd!);
          return day.isBefore(date) || day.isAtSameMomentAs(date);
        }
        if (!isTimeStart && cubit.state.request.timeStart != null) {
          DateTime date = DateTime.parse(cubit.state.request.timeStart!);
          return day.isAfter(date.subtract(const Duration(days: 1)));
        }
        return true;
      },
    );
    if (selectedDay == null) return;
    if (isTimeStart) {
      cubit.changeRequest(timeStart: selectedDay.toString());
    } else {
      final DateTime selectedDayWithTime = DateTime(
        selectedDay.year,
        selectedDay.month,
        selectedDay.day,
        23,
        59,
        59,
      );
      cubit.changeRequest(timeEnd: selectedDayWithTime.toString());
    }
    cubit.getTradingJobs();
  }

  Widget itemSearch(String title, String value) {
    return InkWell(
      onTap: () async {
        cubit.changeSearchBy(value);
        if (cubit.state.searchBy == tr("timeStart")) {
          handleDateTime(cubit.state.request.timeStart ?? '', true);
          return;
        }
        if (cubit.state.searchBy == tr("timeEnd")) {
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
            hintText: cubit.state.searchBy == tr("name")
                ? tr("writeName")
                : tr("writeCodeTradingJob"),
            contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20),
            radius: 16.r,
            colorBorder: AppColors.greyDF,
            textStyleHint: AppTextStyle.textSm,
            maxLine: 1,
            defaultValue: cubit.state.searchBy == tr("name")
                ? cubit.state.request.name
                : cubit.state.request.code,
            onSubmit: (value) {
              cubit.changeVisible(false);
              cubit.getTradingJobs();
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
              cubit.changeRequest(code: value);
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
                : cubit.changeRequest(code: '');
            cubit.getTradingJobs();
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
