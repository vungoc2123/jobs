import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/application/enums/path_news.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_load_more.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_loading_indicator.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/emty_list_data.dart';
import 'package:phu_tho_mobile/presentation/routes/route_name.dart';
import 'package:phu_tho_mobile/presentation/screens/list_job/widget/gradian_appbar.dart';
import 'package:phu_tho_mobile/presentation/screens/news/bloc/news_common_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/news/bloc/news_common_state.dart';
import 'package:phu_tho_mobile/presentation/screens/news_communication/widget/news_widget.dart';

import '../../../gen/assets.gen.dart';
import '../../common_widgets/app_label_text_field.dart';

class NewsCommonScreen extends StatefulWidget {
  const NewsCommonScreen({super.key, required this.nameScreen});

  final NewsPath nameScreen;

  @override
  State<NewsCommonScreen> createState() => _NewsCommonScreenState();
}

class _NewsCommonScreenState extends State<NewsCommonScreen> {
  late NewsCommonCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<NewsCommonCubit>(context);
    cubit.getNameScreen(nameScreen: widget.nameScreen);
    cubit.changeRequest(pageIndex: 1);
    cubit.getNews();
  }

  String getTitle({required NewsPath nameScreen}) {
    switch (nameScreen) {
      case NewsPath.advise:
        return tr("advise");
      case NewsPath.findingPeople:
        return tr("findingPeople");
      case NewsPath.introduction:
        return tr("introduction");
      case NewsPath.jobSeekers:
        return tr("jobSeekers");
      case NewsPath.supply:
        return tr("supply");
      case NewsPath.employmentStatus:
        return tr("employmentStatus");
      case NewsPath.forecast:
        return "Dự báo thị trường lao động";
      default:
        return tr("listNews");
    }
  }

  String _formatDate({String? date, required String values}) {
    if (date != '' && date != null) {
      return "$values: $date";
    }

    return values;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyFB,
      appBar: GradientAppBar(
          title: Text(
            getTitle(nameScreen: widget.nameScreen),
            style: AppTextStyle.textLg
                .copyWith(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          isOpenSearch: false,
          gradient: const LinearGradient(
              colors: [AppColors.blue44, AppColors.blueF8],
              begin: Alignment.topLeft,
              end: Alignment.topRight)),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: 1.sw,
              color: AppColors.white,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              child: BlocBuilder<NewsCommonCubit, NewsCommonState>(
                  builder: (context, state) {
                if (state.openSearch) {
                  return search();
                }
                return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            cubit.resetRequest();
                            cubit.getNews();
                          },
                          borderRadius: BorderRadius.circular(20.r),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 4.h),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                border: Border.all(color: AppColors.blue)),
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
                                      color: AppColors.blue,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        itemSearch(
                            title: tr("name"),
                            value: state.request.titleFilter ?? tr("name"),
                            callback: () => cubit.openSearch()),
                        // SizedBox(
                        //   width: 8.w,
                        // ),
                        // itemSearch(
                        //     title: "Ngày đăng",
                        //     value: _formatDate(
                        //         values: "Ngày đăng",
                        //         date: state.request.datePost),
                        //     callback: () async {
                        //       final DateTime? selectDay = await showDatePicker(
                        //         context: context,
                        //         initialDate: DateTime.now(),
                        //         firstDate: DateTime(2000),
                        //         lastDate: DateTime(3000),
                        //       );
                        //       if (selectDay != null) {
                        //         cubit.changeRequest(
                        //             dayPost: selectDay, pageIndex: 1);
                        //         cubit.getNews();
                        //       }
                        //     }),
                        SizedBox(
                          width: 8.w,
                        ),
                        itemSearch(
                            title: "Theo thời gian",
                            value: _formatDate(
                                values: "Theo thời gian",
                                date: state.request.timeFilter),
                            callback: () async {
                              final DateTime? selectDay = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(3000),
                              );

                              if (selectDay != null) {
                                cubit.changeRequest(
                                    timeFilter: selectDay, pageIndex: 1);
                                cubit.getNews();
                              }
                            }),
                        // SizedBox(
                        //   width: 8.w,
                        // ),
                        // itemSearch(
                        //     title: "Ngày hết hạn",
                        //     value: _formatDate(
                        //         values: "Ngày hết hạn",
                        //         date: state.request.dateExpiration),
                        //     callback: () async {
                        //       final DateTime? selectDay = await showDatePicker(
                        //         context: context,
                        //         initialDate: DateTime.now(),
                        //         firstDate: DateTime(2000),
                        //         lastDate: DateTime(3000),
                        //       );
                        //
                        //       if (selectDay != null) {
                        //         cubit.changeRequest(
                        //             dayExpiration: selectDay, pageIndex: 1);
                        //         cubit.getNews();
                        //       }
                        //     }),
                      ],
                    ));
              }),
            ),
            Expanded(
              child: AppLoadMore(
                onLoadMore: () {
                  cubit.getNewsMore();
                },
                onRefresh: () {
                  cubit.changeRequest(pageIndex: 1);
                  cubit.getNews();
                },
                child: BlocBuilder<NewsCommonCubit, NewsCommonState>(
                    builder: (context, state) {
                  if (state.status == LoadStatus.success) {
                    return ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 8.h),
                        itemBuilder: (context, index) => InkWell(
                            borderRadius: BorderRadius.circular(8.r),
                            onTap: () => Navigator.pushNamed(
                                context, RouteName.detailNewsCommon,
                                arguments: state.listNews[index]),
                            child: Ink(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 8.h),
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(8.r)),
                              child: NewsItemWidget(
                                news: state.listNews[index],
                                isShowDate: false,
                              ),
                            )),
                        separatorBuilder: (context, index) => SizedBox(
                              height: 8.h,
                            ),
                        itemCount: state.listNews.length);
                  }
                  if (state.status == LoadStatus.failure) {
                    return const EmptyListData();
                  }

                  if (state.status == LoadStatus.success &&
                      state.listNews.isEmpty) {
                    return const EmptyListData();
                  }

                  if (state.status == LoadStatus.loading) {
                    return const AppLoadingIndicator();
                  }
                  return const SizedBox();
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemSearch(
      {required String title, required String value, VoidCallback? callback}) {
    return InkWell(
      onTap: () {
        callback?.call();
      },
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
                color: (title == value || value.isEmpty)
                    ? AppColors.greyDF
                    : AppColors.blue)),
        child: Text(
          value.isNotEmpty ? value.toString() : title,
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
            defaultValue: cubit.state.request.titleFilter ?? "",
            hintText: tr("inputName"),
            contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20),
            radius: 20.r,
            colorBorder: AppColors.greyDF,
            textStyleHint: AppTextStyle.textSm,
            maxLine: 1,
            onSubmit: (value) {
              cubit.changeRequest(title: value, pageIndex: 1);
              cubit.getNews();
              cubit.openSearch();
            },
            prefixIcon: Assets.icons.search.svg(
                width: 16.r,
                height: 16.r,
                colorFilter:
                    const ColorFilter.mode(AppColors.grey, BlendMode.srcIn)),
            onChanged: (value) {},
          ),
        ),
        SizedBox(
          width: 8.w,
        ),
        InkWell(
          onTap: () {
            cubit.changeRequest(title: "", pageIndex: 1);
            cubit.getNews();
            cubit.openSearch();
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
