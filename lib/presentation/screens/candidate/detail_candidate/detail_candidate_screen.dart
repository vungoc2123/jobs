import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/domain/models/response/cadidate/candidate_response.dart';
import 'package:phu_tho_mobile/gen/assets.gen.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_network_image.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_see_more.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/appbar_gradient_widget.dart';
import 'package:phu_tho_mobile/presentation/screens/candidate/detail_candidate/widget/info_profile_widget.dart';

class DetailCandidateScreen extends StatefulWidget {
  final CandidateResponse profile;

  const DetailCandidateScreen({super.key, required this.profile});

  @override
  State<DetailCandidateScreen> createState() => _DetailCandidateScreenState();
}

class _DetailCandidateScreenState extends State<DetailCandidateScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: GradientAppBar(
          title: tr('candidateInformation'),
          leading: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
          ),
          leadingAction: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              banner(widget.profile),
              //title(tr('personalInformation')),
              //InfoPersonalWidget(profile: widget.profile,),
              title(tr('profileInformation')),
              InfoProfileWidget(profile: widget.profile),

              AppSeeMore(
                title: tr("careerGoals"),
                html: widget.profile.tagetJob,
                paddingHorizon: 16.w,
                paddingVertical: 8.h,
              ),
              AppSeeMore(
                title: tr("skill"),
                html: widget.profile.skill,
                paddingHorizon: 16.w,
                paddingVertical: 8.h,
              ),
              AppSeeMore(
                title: tr("education"),
                html: widget.profile.educationLv,
                paddingHorizon: 16.w,
                paddingVertical: 8.h,
              ),
              AppSeeMore(
                title: tr("experience"),
                html: widget.profile.experience,
                paddingHorizon: 16.w,
                paddingVertical: 8.h,
              ),
              //ExperienceWidget(profile: widget.profile,),
            ],
          ),
        ),
      ),
    );
  }

  Widget banner(CandidateResponse profile) {
    return Container(
      color: AppColors.white,
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Assets.images.background
                  .image(width: 1.sw, height: 100.h, fit: BoxFit.cover),
              Positioned(
                bottom: -50,
                child: Container(
                  width: 100.r,
                  height: 100.r,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.r),
                      border: Border.all(color: AppColors.white, width: 3)),
                  child: AppNetworkImage(
                    profile.getAvatar(),
                    fit: BoxFit.cover,
                    radius: 50.r,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 66.h,
          ),
          Text(
            profile.fullName,
            style: AppTextStyle.textLg.copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 8.h,
          ),
          SizedBox(
            height: 8.h,
          ),
          // Container(
          //   margin: EdgeInsets.symmetric(horizontal: 16.w),
          //   child: Row(
          //     children: [
          //       Expanded(
          //           child: AppButton(
          //         height: 40.h,
          //         title: tr('contact'),
          //         textStyle: AppTextStyle.textSm.copyWith(
          //             color: AppColors.white, fontWeight: FontWeight.w500),
          //         color: AppColors.orange,
          //         radius: 8.r,
          //       )),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }

  Widget title(String title) {
    return Container(
      margin: EdgeInsets.only(top: 16.w, left: 16.w),
      child: Text(title,
          style: AppTextStyle.textLg.copyWith(
              fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
    );
  }
}
