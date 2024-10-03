import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/application/utils/app_utils.dart';
import 'package:phu_tho_mobile/domain/models/response/document/document_response.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/file_widget.dart';

class VisaWidget extends StatelessWidget {
  final DocumentResponse visa;

  const VisaWidget({super.key, required this.visa});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        rowInfoWorker("Loại thẻ visa:", visa.typeCard),
        SizedBox(
          height: 8.h,
        ),
        rowInfoWorker("Ngày cấp:", visa.dateStart),
        SizedBox(
          height: 8.h,
        ),
        rowInfoWorker("Ngày hết hạn:", visa.dateEnd),
        SizedBox(
          height: 8.h,
        ),
        rowInfoWorker("Số thẻ Visa:", visa.numberCode),
        SizedBox(
          height: 8.h,
        ),
        Text(
          "File đính kèm:",
          style: AppTextStyle.textSm
              .copyWith(color: AppColors.grey52, fontWeight: FontWeight.w600),
        ),
        if (checkHasFile()) ...[
          SizedBox(
            height: 8.w,
          ),
          FileWidget(urlFile: AppUtils.getPath(visa.pathDocument ?? "") ?? "")
        ],
        if (!checkHasFile()) ...[
          SizedBox(
            height: 8.h,
          ),
          Text("Không có file đính kèm",
              style: AppTextStyle.textSm.copyWith(
                  color: AppColors.grey52, fontWeight: FontWeight.w400))
        ]
      ],
    );
  }

  bool checkHasFile() {
    return visa.pathDocument != "" &&
        visa.pathDocument != null &&
        visa.pathDocument != "Uploads/";
  }

  Widget rowInfoWorker(String label, String? value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.textSm
              .copyWith(color: AppColors.grey52, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          width: 8.w,
        ),
        Expanded(
            child: Text((value == null || value == "") ? tr("noInfo") : value,
                style: AppTextStyle.textSm.copyWith(
                    color: AppColors.grey52, fontWeight: FontWeight.w400)))
      ],
    );
  }
}
