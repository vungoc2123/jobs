import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/domain/models/response/news/news_response.dart';
import 'package:phu_tho_mobile/gen/assets.gen.dart';
import 'package:phu_tho_mobile/presentation/routes/route_name.dart';
import 'package:phu_tho_mobile/presentation/screens/detail_news/bloc/detail_news_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/detail_news/bloc/detail_news_state.dart';
import 'package:phu_tho_mobile/presentation/screens/list_job/widget/gradian_appbar.dart';
import 'package:phu_tho_mobile/presentation/screens/news_communication/widget/news_widget.dart';

class NewsDetailScreen extends StatefulWidget {
  const NewsDetailScreen({super.key, required this.news});

  final NewsResponse news;

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  late DetailNewsCubit cubit;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit = BlocProvider.of<DetailNewsCubit>(context);
    cubit.getNewsSame(widget.news.id);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
          title: Text(
            tr("detailInfo"),
            style: AppTextStyle.textLg
                .copyWith(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          isOpenSearch: false,
          gradient: const LinearGradient(
              colors: [AppColors.blue44, AppColors.blueF8],
              begin: Alignment.topLeft,
              end: Alignment.topRight)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.news.title,
                style:
                    AppTextStyle.textBase.copyWith(fontWeight: FontWeight.w600),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 8.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  rowItem(
                      title: tr("dayPosting"),
                      description: widget.news.datePosting,
                      icon: Assets.icons.calendarClock.svg(
                          width: 12.w,
                          height: 12.w,
                          colorFilter: const ColorFilter.mode(
                            AppColors.textPrimary,
                            BlendMode.srcIn,
                          ))),
                  rowItem(
                      title: tr("views"),
                      description: widget.news.views.toString(),
                      icon: Assets.icons.eye.svg(
                          width: 12.w,
                          height: 12.w,
                          colorFilter: const ColorFilter.mode(
                            AppColors.textPrimary,
                            BlendMode.srcIn,
                          ))),
                ],
              ),
              SizedBox(
                height: 4.h,
              ),
              Html(
                data: widget.news.describe,
                style: {
                  "img": Style(
                    width: Width(1.sw-80.w),
                    height: Height(400),
                  ),
                  "body": Style(
                      textAlign: TextAlign.justify,
                      fontWeight: FontWeight.w200,
                      fontStyle: FontStyle.italic,
                      fontSize: FontSize.medium)
                },
              ),
              Html(
                data: widget.news.content,
                style: {
                  "body": Style(
                      textAlign: TextAlign.justify,
                      fontWeight: FontWeight.w400,
                      fontSize: FontSize.large)
                },
              ),
              Text(
                tr("note"),
                style: AppTextStyle.textSm.copyWith(
                    fontStyle: FontStyle.italic, fontWeight: FontWeight.w600),
              ),
              Html(
                data: widget.news.note,
                style: {
                  "body": Style(
                      textAlign: TextAlign.justify,
                      fontWeight: FontWeight.w400,
                      fontSize: FontSize.large)
                },
              ),
              BlocBuilder<DetailNewsCubit, DetailNewsState>(
                builder: (context, state) {
                  if (state.listSame.isNotEmpty && state.status == LoadStatus.success) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr("related"),
                          style: AppTextStyle.textBase
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 8.h),
                            itemBuilder: (context, index) => InkWell(
                                borderRadius: BorderRadius.circular(16.r),
                                onTap: () => Navigator.pushNamed(
                                    context, RouteName.detailNewsCommon,
                                    arguments: state.listSame[index]),
                                child: NewsItemWidget(
                                    news: state.listSame[index])),
                            separatorBuilder: (context, index) =>
                            const Divider(),
                            itemCount: state.listSame.length)
                      ],
                    );
                  }
                  return const SizedBox();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget rowItem(
      {Widget? icon, required String title, required String description}) {
    return Row(
      children: [
        icon != null
            ? Row(
                children: [
                  icon,
                  SizedBox(
                    width: 4.w,
                  )
                ],
              )
            : const SizedBox(),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: title,
                  style: AppTextStyle.textXs
                      .copyWith(color: AppColors.textPrimary)),
              TextSpan(
                  text: ': $description',
                  style: AppTextStyle.textXs
                      .copyWith(color: AppColors.textPrimary)),
            ],
          ),
        )
      ],
    );
  }
}
