import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/application/enums/extract_worker.dart';
import 'package:phu_tho_mobile/domain/models/response/worker/worker_response.dart';
import 'package:phu_tho_mobile/gen/assets.gen.dart';

class WorkerItemWidget extends StatelessWidget {
  final WorkerResponse workerResponse;
  final TypeExtractWorker type;

  final VoidCallback? onPressDelete;
  final VoidCallback? onPressUpdate;

  const WorkerItemWidget(
      {super.key,
      required this.workerResponse,
      this.onPressDelete,
      this.onPressUpdate,
      required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.greyEF),
          color: AppColors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                workerResponse.fullName ?? tr("noInfo"),
                style: AppTextStyle.textBase.copyWith(
                    fontWeight: FontWeight.w800, color: AppColors.grey26),
              ),
              if (onPressDelete != null && onPressUpdate != null)
                PopupMenuButton(
                    itemBuilder: (context) => [
                          PopupMenuItem(
                            onTap: onPressUpdate,
                            child: Text(
                              tr("edit"),
                              textAlign: TextAlign.center,
                              style: AppTextStyle.textSm,
                            ),
                          ),
                          PopupMenuItem(
                            onTap: onPressDelete,
                            child: Text(
                              tr("delete"),
                              textAlign: TextAlign.center,
                              style: AppTextStyle.textSm,
                            ),
                          )
                        ])
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                  flex: 1,
                  child: rowInfo(
                      value: workerResponse.dateOfBirthText ?? tr("noInfo"),
                      iconPath: Assets.icons.icCalendar.path)),
              Flexible(
                  flex: 1,
                  child: rowInfo(
                      value: workerResponse.gender ?? tr("noInfo"),
                      iconPath: Assets.icons.icGender.path)),
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                child: rowInfo(
                    value: workerResponse.phoneNumber ?? tr("noInfo"),
                    iconPath: Assets.icons.icTelephone.path),
              ),
              Flexible(
                flex: 1,
                child: rowInfo(
                    value: workerResponse.address ?? tr("noInfo"),
                    iconPath: Assets.icons.icMarker.path),
              ),
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
          rowInfo(
              value: workerResponse.email ?? tr("noInfo"),
              iconPath: Assets.icons.icClipMail.path),
          SizedBox(
            height: 8.h,
          ),
          rowInfo(
              value: checkNameBusiness(type) ?? tr("noInfo"),
              iconPath: Assets.icons.company.path),
        ],
      ),
    );
  }

  String? checkNameBusiness(TypeExtractWorker type) {
    switch (type) {
      case TypeExtractWorker.manageVnInForeign:
        return workerResponse.businessText;
      case TypeExtractWorker.manageInBusiness:
        return workerResponse.businessText;
      case TypeExtractWorker.manageForeignInVn:
        return workerResponse.businessText;
      case TypeExtractWorker.vnInForeign:
        return workerResponse.nameBusinessForeign;
      default:
        return workerResponse.nameBusiness;
    }
  }

  Widget rowInfo({required String value, required String iconPath}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          iconPath,
          colorFilter: const ColorFilter.mode(
            AppColors.grey52,
            BlendMode.srcIn,
          ),
          width: 16.r,
          height: 16.r,
        ),
        SizedBox(
          width: 8.w,
        ),
        Expanded(
          child: Text(
            value == "" ? tr("noInfo") : value,
            style: AppTextStyle.textSm
                .copyWith(fontWeight: FontWeight.w400, color: AppColors.grey52),
          ),
        )
      ],
    );
  }
}
