import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/application/utils/app_utils.dart';
import 'package:phu_tho_mobile/domain/models/response/document/document_response.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/file_widget.dart';

class WorkPermitWidget extends StatelessWidget {
  final DocumentResponse doc;

  const WorkPermitWidget({super.key, required this.doc});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        rowInfoWorker("Ngày cấp:", doc.dateStart),
        SizedBox(
          height: 8.h,
        ),
        rowInfoWorker("Ngày hết hạn:", doc.dateEnd),
        SizedBox(
          height: 8.h,
        ),
        rowInfoWorker("Số giấy phép lao động:", doc.numberCode),
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
          FileWidget(urlFile: AppUtils.getPath(doc.pathDocument ?? "") ?? "")
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
    return doc.pathDocument != "" &&
        doc.pathDocument != null &&
        doc.pathDocument != "Uploads/";
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
