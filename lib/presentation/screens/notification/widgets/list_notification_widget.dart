import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/gen/assets.gen.dart';

class ListNotificationWidget extends StatelessWidget {
  const ListNotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset(Assets.images.imageNoNotification.path),
          Text(tr("notNotification"),style: AppTextStyle.textBase.copyWith(color: AppColors.blueEA,fontWeight: FontWeight.w700),)
        ],
      ),
    );
  }
}
