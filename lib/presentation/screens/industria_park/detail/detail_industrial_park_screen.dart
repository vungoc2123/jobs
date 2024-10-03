import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/application/enums/type_action.dart';
import 'package:phu_tho_mobile/domain/models/response/industrial_park/industrial_park_response.dart';
import 'package:phu_tho_mobile/gen/assets.gen.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_load_more.dart';
import 'package:phu_tho_mobile/presentation/screens/business/widgets/business_widget.dart';
import 'package:phu_tho_mobile/presentation/screens/industria_park/detail/bloc/detail_industrial_park_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/industria_park/detail/bloc/detail_industrial_park_state.dart';
import 'package:phu_tho_mobile/presentation/screens/list_job/widget/gradian_appbar.dart';

class DetailIndustrialParkScreen extends StatefulWidget {
  const DetailIndustrialParkScreen({super.key, required this.industrialPark});

  final IndustrialParkResponse industrialPark;

  @override
  State<DetailIndustrialParkScreen> createState() =>
      _DetailIndustrialParkScreenState();
}

class _DetailIndustrialParkScreenState
    extends State<DetailIndustrialParkScreen> {
  late final DetailIndustrialParkCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<DetailIndustrialParkCubit>(context);
    cubit.onChangeRequest(
        cubit.state.request.copyWith(id: widget.industrialPark.id));
    cubit.getBusiness();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        isOpenSearch: false,
        title: Text(
          tr('industrialPark'),
          style: AppTextStyle.textLg
              .copyWith(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        gradient: const LinearGradient(
            colors: [AppColors.blue44, AppColors.blueF8],
            begin: Alignment.topLeft,
            end: Alignment.topRight),
      ),
      backgroundColor: AppColors.white,
      body: AppLoadMore(
        onRefresh: () {
          cubit.onChangeRequest(cubit.state.request.copyWith(pageIndex: 1));
          cubit.getBusiness();
        },
        onLoadMore: () {
          cubit.getMoreBusiness();
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                child: Text("Thông tin khu công nghiệp",
                    style: AppTextStyle.textLg.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary)),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: const BoxDecoration(color: AppColors.whiteFF),
                child: Column(
                  children: [
                    itemInfo(
                        icon: Assets.icons.markerPin03.path,
                        title: tr('name'),
                        color: AppColors.grey52,
                        content: widget.industrialPark.name),
                    SizedBox(
                      height: 10.h,
                    ),
                    itemInfo(
                        icon: Assets.icons.markerPin03.path,
                        title: tr('locationIndustrialPark'),
                        color: AppColors.grey52,
                        content: widget.industrialPark.location),
                    SizedBox(
                      height: 10.h,
                    ),
                    itemInfo(
                        icon: Assets.icons.markerPin03.path,
                        title: tr('nameCommune'),
                        color: AppColors.grey52,
                        content: widget.industrialPark.nameCommune),
                    SizedBox(
                      height: 10.h,
                    ),
                    itemInfo(
                        icon: Assets.icons.locationArrow.path,
                        title: tr('nameDistrict'),
                        color: AppColors.grey52,
                        content: widget.industrialPark.nameDistrict),
                    SizedBox(
                      height: 10.h,
                    ),
                    itemInfo(
                        icon: Assets.icons.operation.path,
                        title: tr('status'),
                        content: widget.industrialPark.status,
                        color: AppColors.green50),
                  ],
                ),
              ),
              BlocBuilder<DetailIndustrialParkCubit, DetailIndustrialParkState>(
                builder: (BuildContext context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (state.business.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 8.h, horizontal: 16.w),
                          child: Text("Danh sách doanh nghiệp",
                              style: AppTextStyle.textLg.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary)),
                        ),
                      ListView.separated(
                        itemCount: state.business.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => BusinessWidget(
                          businessResponse: state.business[index],
                          typeAction: TypeAction.extract,
                        ),
                        separatorBuilder: (context, index) => const Divider(
                          color: AppColors.greyF6,
                        ),
                      ),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget itemInfo(
      {required String icon,
      required String title,
      required String content,
      Color? color}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 4.h),
          child: SvgPicture.asset(icon,
              height: 16.r,
              width: 16.r,
              colorFilter:
                  const ColorFilter.mode(AppColors.grey52, BlendMode.srcIn)),
        ),
        SizedBox(
          width: 12.w,
        ),
        Expanded(
          child: Text(
              '$title: ${content.isNotEmpty ? content : "Chưa có thông tin"}',
              style: AppTextStyle.textBase
                  .copyWith(fontWeight: FontWeight.w500, color: color)),
        ),
      ],
    );
  }
}
