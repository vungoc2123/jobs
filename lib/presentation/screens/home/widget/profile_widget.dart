import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/application/extentions/list_extentions.dart';
import 'package:phu_tho_mobile/domain/models/response/cadidate/candidate_response.dart';
import 'package:phu_tho_mobile/gen/assets.gen.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_network_image.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_slide_widgets.dart';
import 'package:phu_tho_mobile/presentation/routes/route_name.dart';

class Experience {
  String company;
  String imageCompany;
  String position;
  String address;
  String experience;

  Experience(
      {required this.company,
      required this.imageCompany,
      required this.position,
      required this.address,
      required this.experience});
}

class ProfileModel {
  String image;
  String name;
  String yearOfBirth;
  String exp;
  String vacancies;
  String career;
  String salary;
  String level;
  double rate;
  String numberPhone;
  String email;
  String address;
  String addressWork;
  String school;
  String experienceWork;
  String specialized;
  List<Experience> experiences;

  ProfileModel(
      {required this.image,
      required this.name,
      required this.yearOfBirth,
      required this.exp,
      required this.vacancies,
      required this.career,
      required this.salary,
      required this.level,
      required this.rate,
      required this.numberPhone,
      required this.email,
      required this.address,
      required this.experienceWork,
      required this.addressWork,
      required this.school,
      required this.specialized,
      required this.experiences});
}

class ProfileWidget extends StatefulWidget {
  final List<CandidateResponse> candidates;

  const ProfileWidget({super.key, required this.candidates});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  late List<List<CandidateResponse>> profiles;
  late List<Widget> profileWidgets;

  @override
  void initState() {
    super.initState();
    profiles = widget.candidates.twoDimensionalArrayWithTwoElements;
    profileWidgets = profiles.map((e) => itemSlideProfile(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removeViewPadding(
      context: context,
      removeTop: true,
      child: AppSlideWidget(
        height: 245.h * 2,
        widgets: profileWidgets,
        sizeIndicator: 8.r,
        space: 10,
        enlargeCenterPage: false,
        isExpandIndicator: false,
        autoPlay: false,
      ),
    );
  }

  Widget itemSlideProfile(List<CandidateResponse> list) {
    return Container(
      color: Colors.transparent,
      child: ListView.separated(
        itemCount: list.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          CandidateResponse profile = list[index];
          return itemProfile(
            profile,
          );
        },
        separatorBuilder: (BuildContext context, int index) =>  SizedBox(
          height: 10.h,
        ),
      ),
    );
  }

  Widget itemProfile(CandidateResponse profile) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(RouteName.detailCandidate, arguments: profile);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.r),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: Colors.white,
            border: Border.all(color: AppColors.blue.withOpacity(0.5),width: 0.5)
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppNetworkImage(
                  profile.getAvatar(),
                  radius: 8.r,
                  height: 100.r,
                  width: 100.r,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  width: 16.w,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profile.fullName,
                        style: AppTextStyle.textSm
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      line(
                          "${tr("yearOfBirth")}:",
                          profile.dateOfBirth != null
                              ? DateFormat.y()
                              .format(DateTime.parse(profile.dateOfBirth!))
                              : 'chưa biết'),
                      line("${tr("level")}:", profile.level),
                      line("${tr("experience")}:", profile.yearOfExperience),
                    ],
                  ),
                )
              ],
            ),
            lineIcon(Assets.icons.businessPerson.path, "${tr('location')}:",
                profile.currenPosition),
            lineIcon(Assets.icons.briefcase.path, "${tr('career')}:",
                profile.jobName),
            lineIcon(Assets.icons.usdCircle.path, "${tr('salary')}:",
                profile.proposedSalary),
          ],
        ),
      ),
    );
  }

  Widget line(String title, String content) {
    return Container(
      margin: EdgeInsets.only(top: 8.h),
      child: Row(
        children: [
          Text(
            title,
            style: AppTextStyle.textSm.copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 8.w,
          ),
          Expanded(
            child: Text(
              content,
              style: AppTextStyle.textSm.copyWith(
                  fontWeight: FontWeight.w500, overflow: TextOverflow.ellipsis),
            ),
          )
        ],
      ),
    );
  }

  Widget lineIcon(String icon, String title, String content) {
    return Container(
      margin: EdgeInsets.only(top: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(icon,
              width: 20.r,
              height: 20.r,
              colorFilter:
                  const ColorFilter.mode(AppColors.grey, BlendMode.srcIn)),
          SizedBox(
            width: 8.w,
          ),
          Text(
            title,
            style: AppTextStyle.textSm.copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 8.w,
          ),
          Expanded(
            child: Text(
              content,
              style: AppTextStyle.textSm.copyWith(
                  fontWeight: FontWeight.w500, overflow: TextOverflow.ellipsis),
            ),
          )
        ],
      ),
    );
  }
}
