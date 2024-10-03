import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/presentation/routes/route_name.dart';
import 'package:phu_tho_mobile/presentation/screens/discover/widget/item_news.dart';
import 'package:phu_tho_mobile/presentation/screens/news/bloc/news_common_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/news/bloc/news_common_state.dart';
import 'package:skeletons/skeletons.dart';

import '../../../../application/enums/path_news.dart';

class NewsGroup extends StatefulWidget {
  const NewsGroup({super.key, required this.path});

  final NewsPath path;

  @override
  State<NewsGroup> createState() => _NewsGroupState();
}

class _NewsGroupState extends State<NewsGroup> {
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

  late NewsCommonCubit cubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit = BlocProvider.of<NewsCommonCubit>(context);
    cubit.getNameScreen(nameScreen: widget.path);
    cubit.changeRequest(pageIndex: 1, pageSize: 5);
    cubit.getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              getTitle(nameScreen: widget.path),
              style: AppTextStyle.textBase.copyWith(
                  fontWeight: FontWeight.w600, color: AppColors.textPrimary),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, RouteName.news,
                    arguments: widget.path);
              },
              borderRadius: BorderRadius.circular(16.r),
              child: Ink(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                child: Text(
                  "Xem thêm",
                  style: AppTextStyle.textXs.copyWith(color: AppColors.blue),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 8.h,
        ),
        BlocBuilder<NewsCommonCubit, NewsCommonState>(
            builder: (context, state) {
          if (state.status == LoadStatus.loading) {
            return SizedBox(
              height: 150.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: SizedBox(
                    width: (1.sw - 64) / 2,
                    child: simmerLoading(),
                  ),
                ),
              ),
            );
          }
          if (state.status == LoadStatus.success) {
            return SizedBox(
              height: 150.h,
              child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => SizedBox(
                      width: (1.sw - 64) / 2,
                      child: InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                RouteName.detailNewsCommon,
                                arguments: state.listNews[index]);
                          },
                          child: ItemNews(news: state.listNews[index]))),
                  separatorBuilder: (context, index) => SizedBox(
                        width: 12.w,
                      ),
                  itemCount: state.listNews.length),
            );
          }
          return const SizedBox();
        }),
      ],
    );
  }

  Widget simmerLoading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SkeletonLine(
          style: SkeletonLineStyle(
            width: double.infinity,
            height: 67,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        SizedBox(height: 8.h),
        SkeletonLine(
          style: SkeletonLineStyle(
            width: double.infinity,
            height: 16.h,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        SizedBox(height: 4.h),
        SkeletonLine(
          style: SkeletonLineStyle(
            width: 0.7 * (1.sw - 64) / 2,
            height: 16.h,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }
}
