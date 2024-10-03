import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/domain/models/response/user/user_profile_response.dart';
import 'package:phu_tho_mobile/gen/assets.gen.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_network_image.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/appbar_gradient_widget.dart';
import 'package:phu_tho_mobile/presentation/routes/route_name.dart';
import 'package:skeletons/skeletons.dart';

class AccountHeaderWidget extends StatefulWidget {
  final UserProfileResponse? userProfile;
  final LoadStatus loadStatus;

  const AccountHeaderWidget({super.key, required this.userProfile, required this.loadStatus});

  @override
  State<AccountHeaderWidget> createState() => _AccountHeaderWidgetState();
}

class _AccountHeaderWidgetState extends State<AccountHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180.h,
      child: Stack(
        children: [
          GradientAppBar(barHeight: 100.h),
          Positioned(
            top: 100.h,
            left: 16.w,
            child: Container(
              width: 1.sw - 32.w,
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(149, 157, 165, 0.2),
                    blurRadius: 24,
                    spreadRadius: 0,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Builder(builder: (context) {
                if (widget.loadStatus == LoadStatus.loading) {
                  return Row(
                    children: [
                      SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                          shape: BoxShape.circle,
                          width: 55.r,
                          height: 55.r,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SkeletonLine(
                              style: SkeletonLineStyle(
                                width: double.infinity,
                                height: 20.h,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            SizedBox(height: 8.h),
                            SkeletonLine(
                              style: SkeletonLineStyle(
                                width: double.infinity,
                                height: 16.h,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }

                // final shortName = widget.userProfile?.fullName.split(" ").sublist(0, 2).map((e) => e[0]);
                final nameParts = widget.userProfile?.fullName.split(" ") ?? [];
                final count = nameParts.length >= 2 ? 2 : nameParts.length;
                final shortName = nameParts.sublist(0, count).map((e) => e[0]);

                return Row(
                  children: [
                    AppNetworkImage(
                      widget.userProfile?.avatarUrl ?? '',
                      width: 55.r,
                      height: 55.r,
                      radius: 55.r,
                      errorWidget: Container(
                        padding: EdgeInsets.all(2.r),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.blueFB, width: 2.sp),
                        ),
                        child: SizedBox(
                          width: 55.r,
                          height: 55.r,
                          child: CircleAvatar(
                            backgroundColor: AppColors.blueFB.withOpacity(0.5),
                            child: Text(
                              shortName.join().toUpperCase() ?? '',
                              style: AppTextStyle.textXl.copyWith(
                                color: AppColors.blue44,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.userProfile?.fullName ?? tr('noData'),
                            style: AppTextStyle.textBase.copyWith(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            "Email: ${widget.userProfile?.email ?? tr('noData')}",
                            style: AppTextStyle.textSm.copyWith(color: AppColors.grey73),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 12.w),
                    InkWell(
                      onTap: () => Navigator.of(context).pushNamed(RouteName.qrScanner),
                      child: Container(
                        padding: EdgeInsets.all(5.r),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.grey73, width: 1.r),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Assets.icons.icQrScan.svg(
                          width: 24.r,
                          height: 24.r,
                          colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                        ),
                      ),
                    )
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
