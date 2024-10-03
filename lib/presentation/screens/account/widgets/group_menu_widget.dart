import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/application/dto/menu_model.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/permission_operator_widget.dart';

class GroupMenuWidget extends StatefulWidget {
  final GroupMenuModel group;

  const GroupMenuWidget({super.key, required this.group});

  @override
  State<GroupMenuWidget> createState() => _GroupMenuWidgetState();
}

class _GroupMenuWidgetState extends State<GroupMenuWidget> {
  Widget _buildMenuItem(MenuModel item) {
    return GestureDetector(
      onTap: () => item.onTap?.call(),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          children: [
            item.icon.svg(width: 16.r, height: 16.r),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                item.title,
                style: AppTextStyle.textSm.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            SizedBox(width: 4.w),
            // Icon(
            //   Icons.arrow_forward_ios_rounded,
            //   color: AppColors.textPrimary,
            //   size: 16.sp,
            // ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.group.title,
            style: AppTextStyle.textSm
                .copyWith(fontWeight: FontWeight.w400, color: AppColors.grey72),
          ),
          SizedBox(height: 8.h),
          MediaQuery.removeViewPadding(
            context: context,
            removeTop: true,
            child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) {
                  if (widget.group.children[index].operator != null) {
                    return PermissionOperatorWidget(
                        operator: widget.group.children[index].operator!,
                        child: _buildMenuItem(widget.group.children[index]));
                  }
                  return _buildMenuItem(widget.group.children[index]);
                },
                separatorBuilder: (_, index) {
                  return Padding(
                    padding: EdgeInsets.only(left: 16.r),
                    child: const Divider(
                      color: AppColors.greyF6,
                    ),
                  );
                },
                itemCount: widget.group.children.length),
          ),
        ],
      ),
    );
  }
}
