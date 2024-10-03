import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';

class LayoutWidget extends StatelessWidget {
  const LayoutWidget({super.key, required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyle.textBase.copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8.h,),
        child
      ],
    );
  }
}
