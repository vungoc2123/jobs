import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_link.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/domain/models/response/news.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_network_image.dart';

class ListNewsWidget extends StatelessWidget {
  const ListNewsWidget({super.key});

  @override
  Widget build(BuildContext context) {

    List<News> listNews = [
      News(
          title: AppLink.titleDocument,
          time: "2024-05-20 22:12:41",
          iamge: AppLink.imageJob),
      News(
          title: AppLink.titleDocument1,
          time: "2024-05-20 22:12:41",
          iamge: AppLink.imageJob3),
      News(
          title: AppLink.titleDocument2,
          time: "2024-05-20 22:12:41",
          iamge: AppLink.imageJob2),
      News(
          title: AppLink.titleDocument3,
          time: "2024-05-20 22:12:41",
          iamge: AppLink.imageJob2),
      News(
          title: AppLink.titleDocument4,
          time: "2024-05-20 22:12:41",
          iamge: AppLink.imageJob3),
      News(
          title: AppLink.titleDocument3,
          time: "2024-05-20 22:12:41",
          iamge: AppLink.imageJob),
      News(
          title: AppLink.titleDocument2,
          time: "2024-05-20 22:12:41",
          iamge: AppLink.imageJob3),
      News(
          title: AppLink.titleDocument2,
          time: "2024-05-20 22:12:41",
          iamge: AppLink.imageJob2),
      News(
          title: AppLink.titleDocument1,
          time: "2024-05-20 22:12:41",
          iamge: AppLink.imageJob),
      News(
          title: AppLink.titleDocument4,
          time: "2024-05-20 22:12:41",
          iamge: AppLink.imageJob2),
    ];

    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) => itemWidget(news: listNews[index]),
        separatorBuilder: (context, index) => Divider(
          color: AppColors.greyE5,
          height: 32.h,
        ),
        itemCount: 10);
  }


  Widget itemWidget({required News news}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppNetworkImage(
          news.iamge,
          width: 1.sw / 2.5,
          height: 100.h,
          fit: BoxFit.cover,
        ),
        SizedBox(
          width: 8.w,
        ),
        Expanded(
          child: SizedBox(
            height: 100.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  news.title,
                  style:
                  AppTextStyle.textSm.copyWith(fontWeight: FontWeight.w600),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Ngày đăng: ${news.time}',
                  style:
                  AppTextStyle.textXs.copyWith(fontWeight: FontWeight.w400),
                  maxLines: 1,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
