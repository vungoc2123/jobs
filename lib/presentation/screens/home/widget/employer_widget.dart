import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/application/enums/type_action.dart';
import 'package:phu_tho_mobile/domain/models/argument/detail_business_argument.dart';
import 'package:phu_tho_mobile/domain/models/response/business/business_response.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_network_image.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_slide_widgets.dart';

import '../../../routes/route_name.dart';

class EmployerModel {
  final String url;
  final String nameEmployer;

  EmployerModel({required this.url, required this.nameEmployer});
}

class EmployerWidget extends StatelessWidget {
  final List<BusinessResponse> business;

  const EmployerWidget({super.key, required this.business});

  @override
  Widget build(BuildContext context) {
    List<Widget> list = business.map((e) => item(e, context)).toList();
    return AppSlideWidget(
      height: 230.h,
      widgets: list,
      isExpandIndicator: false,
      enlargeCenterPage: false,
      autoPlay: false,
      space: 0,
    );
  }

  Widget item(BusinessResponse model, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RouteName.detailBusiness,
            arguments: DetailBusinessArgument(
                type: TypeAction.extract, idBusiness: model.id));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: AppColors.blue.withOpacity(0.5),width: 0.5)),
              child: AppNetworkImage(
                width: double.infinity,
                height: 150.h,
                model.getImagePath(),
                fit: BoxFit.contain,
                radius: 16.r,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              model.nameBusiness,
              textAlign: TextAlign.center,
              style: AppTextStyle.textSm.copyWith(
                  fontWeight: FontWeight.w600, color: AppColors.textPrimary),
            )
          ],
        ),
      ),
    );
  }
}
