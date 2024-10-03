import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/domain/models/response/cadidate/candidate_response.dart';
import 'package:phu_tho_mobile/presentation/screens/home/widget/profile_widget.dart';
import 'package:timelines/timelines.dart';

class InfoPersonalWidget extends StatelessWidget {
  final CandidateResponse profile;

  const InfoPersonalWidget({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      removeBottom: true,
      child: Container(
        color: AppColors.whiteFF,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Timeline.tileBuilder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          theme: TimelineTheme.of(context).copyWith(
            nodePosition: 0,
          ),
          builder: TimelineTileBuilder.connected(
            contentsAlign: ContentsAlign.basic,
            connectorBuilder: (context, index, type) {
              return const DashedLineConnector(color: AppColors.blue);
            },
            indicatorBuilder: (context, index) {
              return DotIndicator(
                size: 10.r,
                color: AppColors.blue,
              );
            },
            contentsBuilder: (context, index) {
              switch (index) {
                case 1:
                  return itemTimeLine(tr('address'), profile.contentApply);
              }
              return null;
            },
            itemCount: 3,
          ),
        ),
      ),
    );
  }

  Widget itemTimeLine(String title, String content) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyle.textSm
                .copyWith(fontWeight: FontWeight.w600, color: AppColors.grey),
          ),
          Text(
            content,
            style: AppTextStyle.textSm.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
