import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/application/extentions/string_extension.dart';
import 'package:phu_tho_mobile/domain/models/argument/detail_business_argument.dart';
import 'package:phu_tho_mobile/domain/models/argument/detail_job_argument.dart';
import 'package:phu_tho_mobile/gen/assets.gen.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_button.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_loading.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_network_image.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_see_more.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_toast.dart';
import 'package:phu_tho_mobile/presentation/routes/route_name.dart';
import 'package:phu_tho_mobile/presentation/screens/detail_job/widget/job_information_widget.dart';
import 'package:phu_tho_mobile/presentation/screens/detail_job/widget/layout_widget.dart';
import 'package:phu_tho_mobile/presentation/screens/list_job/bloc/list_job_cubit.dart';

import '../list_job/bloc/list_job_state.dart';

class DetailJobScreen extends StatefulWidget {
  const DetailJobScreen({super.key, required this.argument});

  final DetailJobArgument argument;

  @override
  State<DetailJobScreen> createState() => _DetailJobScreenState();
}

class _DetailJobScreenState extends State<DetailJobScreen> {
  late ListJobCubit cubit;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit = BlocProvider.of<ListJobCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.blueF8,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 15.w,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocListener<ListJobCubit, ListJobState>(
        listener: (context, state){
          if(state.loadApplyJob == LoadStatus.loading){
            showDialog(context: context, builder:(context)=> const AppLoading());
          }

          if(state.loadApplyJob == LoadStatus.success){
            if(Navigator.canPop(context)){
              Navigator.pop(context);
            }
            AppToast.showToastSuccess(context, title: state.message);
          }

          if(state.loadApplyJob == LoadStatus.failure){
            if(Navigator.canPop(context)){
              Navigator.pop(context);
            }
            AppToast.showToastError(context, title: state.message);
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // header
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [AppColors.blue44, AppColors.blueF8],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.argument.job.title,
                        style: AppTextStyle.textLg.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.argument.job.businessName,
                                  style: AppTextStyle.textSm.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                                Row(
                                  children: [
                                    Assets.icons.bankNote03.svg(
                                        width: 15.w,
                                        height: 15.w,
                                        colorFilter: const ColorFilter.mode(
                                            Colors.white, BlendMode.srcIn)),
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    Expanded(
                                      child: Text(
                                        widget.argument.job.salary,
                                        style: AppTextStyle.textSm.copyWith(
                                            color: AppColors.orange43,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 3.h),
                                      child: Assets.icons.markerPin03.svg(
                                          width: 15.w,
                                          height: 15.w,
                                          colorFilter: const ColorFilter.mode(
                                              Colors.white, BlendMode.srcIn)),
                                    ),
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    Expanded(
                                      child: Text(
                                        // 'Phú Thọ',
                                        widget.argument.job.nameProvince,
                                        style: AppTextStyle.textSm.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Assets.icons.calendarClock.svg(
                                        width: 15.w,
                                        height: 15.w,
                                        colorFilter: const ColorFilter.mode(
                                            Colors.white, BlendMode.srcIn)),
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    Text(
                                      'Ngày đăng ${widget.argument.job.dateStart.formatToDMY()}',
                                      style: AppTextStyle.textSm.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Expanded(
                            child: Container(
                              width: 80.w,
                              height: 80.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  color: Colors.white),
                              child: AppNetworkImage(
                                widget.argument.job.getImagePath(),
                                fit: BoxFit.contain,
                                radius: 8.r,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [
                      // Job Description
                      SizedBox(
                        height: 16.h,
                      ),
                      AppSeeMore(
                        title: tr("jobDescription"),
                        html: widget.argument.job.description,
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      AppSeeMore(
                        title: tr("JobRequired"),
                        html: widget.argument.job.jobRequirement,
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      if (widget.argument.job.benefit.isNotEmpty)
                        AppSeeMore(
                          title: tr("benefits"),
                          html: widget.argument.job.jobRequirement,
                        ),
                      SizedBox(
                        height: 16.h,
                      ),
                      LayoutWidget(
                          title: tr("JobInfo"),
                          child: JobInfoWidget(
                            jobResponse: widget.argument.job,
                          )),
                      SizedBox(
                        height: 16.h,
                      ),
                      LayoutWidget(
                          title: tr("CompanyInfo"),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RouteName.detailBusiness,
                                  arguments: DetailBusinessArgument(
                                      idBusiness: widget.argument.job.idBusiness,
                                      type: widget.argument.typeAction));
                            },
                            borderRadius: BorderRadius.circular(16.r),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 8.h),
                              decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.whiteD6),
                                  borderRadius: BorderRadius.circular(16.r)),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      AppNetworkImage(
                                        widget.argument.job.getImagePath(),
                                        fit: BoxFit.contain,
                                        width: 1.sw / 4,
                                        height: 1.sw / 6,
                                        radius: 8.r,
                                      ),
                                      SizedBox(
                                        width: 8.w,
                                      ),
                                      Expanded(
                                        child: Text(
                                          widget.argument.job.businessName,
                                          style: AppTextStyle.textBase.copyWith(
                                              fontWeight: FontWeight.w700),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 16.h,
                      ),
                      AppButton(
                        onPressed: () => cubit.applyJob(widget.argument.job.id),
                        height: 40.h,
                        title: 'Ứng tuyển',
                        color: AppColors.orange,
                        radius: 8.r,
                        textStyle: AppTextStyle.textBase
                            .copyWith(color: AppColors.white),
                        contentPadding: EdgeInsets.symmetric(vertical: 8.h),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
