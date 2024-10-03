import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/application/enums/type_action.dart';
import 'package:phu_tho_mobile/domain/models/response/business/business_response.dart';
import 'package:phu_tho_mobile/gen/assets.gen.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_network_image.dart';

class BusinessWidget extends StatelessWidget {
  final BusinessResponse businessResponse;
  final TypeAction typeAction;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  const BusinessWidget(
      {super.key,
      required this.businessResponse,
      this.onDelete,
      this.onEdit,
      required this.typeAction});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r), color: Colors.white),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8.r)),
            child: AppNetworkImage(
              businessResponse.getImagePath(),
              radius: 8.r,
              height: 70.r,
              width: 70.r,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            width: 8.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex:7,
                        child: Text(
                          businessResponse.nameBusiness,
                          style: AppTextStyle.textSm.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary),
                        ),
                      ),
                      if (typeAction == TypeAction.manage)
                        Flexible(
                          flex: 1,
                          child: SizedBox(
                            width: 20.r,
                            height: 24.r,
                            child: PopupMenuButton(
                              padding: EdgeInsets.zero,
                                itemBuilder: (context) => [
                                      PopupMenuItem(
                                        onTap: onEdit,
                                        child: Text(
                                          tr("edit"),
                                          textAlign: TextAlign.center,
                                          style: AppTextStyle.textSm,
                                        ),
                                      ),
                                      PopupMenuItem(
                                        onTap: onDelete,
                                        child: Text(
                                          tr("delete"),
                                          textAlign: TextAlign.center,
                                          style: AppTextStyle.textSm,
                                        ),
                                      )
                                    ]),
                          ),
                        )
                    ]),
                SizedBox(
                  height: 8.h,
                ),
                infoBusiness(
                    value: businessResponse.address,
                    iconPath: Assets.icons.icLocation.path),
                SizedBox(
                  height: 4.h,
                ),
                infoBusiness(
                    value: businessResponse.phone,
                    iconPath: Assets.icons.icPhone.path),
                SizedBox(
                  height: 4.h,
                ),
                infoBusiness(
                    value: "Tax: ${businessResponse.taxCode}",
                    iconPath: Assets.icons.icTaxCode.path),
                SizedBox(
                  height: 4.h,
                ),
                infoBusiness(
                    value: businessResponse.email,
                    iconPath: Assets.icons.icEmailRound.path),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget infoBusiness({required String value, required String iconPath}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 3.h),
          child: SvgPicture.asset(
            iconPath,
            colorFilter: const ColorFilter.mode(
              AppColors.grey73,
              BlendMode.srcIn,
            ),
            width: 14.r,
            height: 14.r,
          ),
        ),
        SizedBox(
          width: 4.w,
        ),
        Expanded(
          child: Text(
            value == "" ? "Chưa có thông tin" : value,
            style: AppTextStyle.textSm
                .copyWith(fontWeight: FontWeight.w400, color: AppColors.grey73),
          ),
        )
      ],
    );
  }
}
