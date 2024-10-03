import 'package:animated_read_more_text/animated_read_more_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/domain/models/response/business/business_response.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_network_image.dart';
import 'package:phu_tho_mobile/presentation/screens/business/widgets/item_support_widget.dart';
import 'package:phu_tho_mobile/presentation/screens/list_employers/widgtes/item_employer_widget.dart';

class InformationWidget extends StatelessWidget {
  final BusinessResponse businessResponse;

  const InformationWidget({super.key, required this.businessResponse});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tr("headQuarters"),
            style: AppTextStyle.textBase.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            businessResponse.address != ""
                ? businessResponse.address
                : tr("noInfo"),
            style: AppTextStyle.textSm,
          ),
          SizedBox(
            height: 12.h,
          ),
          Text(
            tr("typeBusiness"),
            style: AppTextStyle.textBase.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            businessResponse.typeBusiness != ""
                ? businessResponse.typeBusiness
                : tr("noInfo"),
            style: AppTextStyle.textSm,
          ),
          SizedBox(
            height: 12.h,
          ),
          Text(
            tr("scale"),
            style: AppTextStyle.textBase.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            businessResponse.scale != ''
                ? businessResponse.scale
                : tr("noInfo"),
            style: AppTextStyle.textSm,
          ),
          SizedBox(
            height: 12.h,
          ),
          Text(
            tr("field"),
            style: AppTextStyle.textBase.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            businessResponse.businessProfession != ""
                ? businessResponse.businessProfession
                : tr("noInfo"),
            style: AppTextStyle.textSm,
          ),
          SizedBox(
            height: 12.h,
          ),
          Text(
            tr("introduce"),
            style: AppTextStyle.textBase.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5.h,
          ),
          Container(
            width: 1.sw,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: AppColors.greyF6,
            ),
            padding: EdgeInsets.all(10.r),
            child: AnimatedReadMoreText(
              businessResponse.introduce != ''
                  ? businessResponse.introduce
                  : tr("noInfo"),
              maxLines: 3,
              readMoreText: tr("read_more"),
              readLessText: tr("hide_less"),
              textStyle: AppTextStyle.textSm,
              buttonTextStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14.sp,
                  color: const Color(0xff004EEB)),
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Text(
            tr("email"),
            style: AppTextStyle.textBase.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            businessResponse.email != ""
                ? businessResponse.email
                : tr("noInfo"),
            style: AppTextStyle.textSm,
          ),
          SizedBox(
            height: 12.h,
          ),
          Text(
            tr("phoneNumber"),
            style: AppTextStyle.textBase.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            businessResponse.phone != ""
                ? businessResponse.phone
                : tr("noInfo"),
            style: AppTextStyle.textSm,
          ),
          SizedBox(
            height: 12.h,
          ),
          Text(
            tr("nameUserContact"),
            style: AppTextStyle.textBase.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            businessResponse.nameConatact != ""
                ? businessResponse.nameConatact
                : tr("noInfo"),
            style: AppTextStyle.textSm,
          ),
          SizedBox(
            height: 12.h,
          ),
          Text(
            tr("phoneContact"),
            style: AppTextStyle.textBase.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            businessResponse.phoneContact != ""
                ? businessResponse.phoneContact
                : tr("noInfo"),
            style: AppTextStyle.textSm,
          ),
          SizedBox(
            height: 12.h,
          ),
          SizedBox(
            height: 10.h,
          )
        ],
      ),
    );
  }
}

Widget listImages(Employer employer) {
  var listImages = employer.images.split(';');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
              listImages.length,
              (index) => Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: AppNetworkImage(
                      fit: BoxFit.cover,
                      listImages[index],
                      width: 150.r,
                      height: 150.r,
                      radius: 8.r,
                    ),
                  )),
        ),
      ),
    ),
  );
}

Widget listVideo(Employer employer) {
  var listImages = employer.images.split(';');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
              listImages.length,
              (index) => Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: Stack(alignment: Alignment.center, children: [
                      AppNetworkImage(
                        fit: BoxFit.cover,
                        listImages[index],
                        width: 150.r,
                        height: 150.r,
                        radius: 8.r,
                      ),
                      Icon(
                        Icons.play_circle_outline_outlined,
                        color: Colors.white,
                        size: 50.r,
                      )
                    ]),
                  )),
        ),
      ),
    ),
  );
}

Widget support(Employer employer) {
  List<Support> supports = [];
  for (var item in employer.welfare) {
    supports
        .add(Support(icon: const Icon(Icons.shopping_bag_rounded), name: item));
  }
  return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ItemSupportWidget(item: supports[index]);
      },
      separatorBuilder: (_, __) => SizedBox(
            height: 5.h,
          ),
      itemCount: supports.length);
}
