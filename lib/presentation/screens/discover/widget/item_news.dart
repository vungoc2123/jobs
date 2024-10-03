import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/application/extentions/string_extension.dart';
import 'package:phu_tho_mobile/domain/models/response/news/news_response.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_network_image.dart';

class ItemNews extends StatelessWidget {
  const ItemNews({super.key, required this.news});

  final NewsResponse news;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SizedBox(
            child: AppNetworkImage(
              news.avatar.toResourceUrl(),
              width: (1.sw -32) / 2,
              fit: BoxFit.fill,
            ),
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
        Text(
          "${news.title}\n",
          style: AppTextStyle.textXs.copyWith(
              fontWeight: FontWeight.w500, color: AppColors.textPrimary),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }
}
