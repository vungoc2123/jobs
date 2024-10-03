import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/domain/models/response/question/question_response.dart';
import 'package:phu_tho_mobile/presentation/screens/list_job/widget/gradian_appbar.dart';

class DetailQuestionScreen extends StatelessWidget {
  const DetailQuestionScreen({super.key, required this.question});

  final QuestionResponse question;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
          title: Text(
            tr("questionInfo"),
            style: AppTextStyle.textLg
                .copyWith(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          isOpenSearch: false,
          gradient: const LinearGradient(
              colors: [AppColors.blue44, AppColors.blueF8],
              begin: Alignment.topLeft,
              end: Alignment.topRight)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                question.title,
                style: AppTextStyle.textBase.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(
                "${tr("field")}: ${question.field}",
                style: AppTextStyle.textSm.copyWith(
                    color: AppColors.textPrimary, fontWeight: FontWeight.w400),
              ),
              Text(
                "${tr("questioner")}: ${question.questioner}",
                style: AppTextStyle.textSm.copyWith(
                    color: AppColors.textPrimary, fontWeight: FontWeight.w400),
              ),
              Text(
                "${tr("gmail")}: ${question.email}",
                style: AppTextStyle.textSm.copyWith(
                    color: AppColors.textPrimary, fontWeight: FontWeight.w400),
              ),
              question.content != ""
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8.h,),
                        Text(
                          "${tr("content")}:",
                          style: AppTextStyle.textSm.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary),
                        ),
                        Html(
                          data: question.content,
                        )
                      ],
                    )
                  : const SizedBox(),
              const Divider(),
              SizedBox(
                height: 8.h,
              ),
              if (question.listReply.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${tr("reply")}:",
                      style: AppTextStyle.textSm.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 4.h
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                            question.listReply.length,
                            (index) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${tr("respondent")}: ${question.listReply[index].respondent}",
                                      style: AppTextStyle.textBase.copyWith(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Html(
                                        data: question.listReply[index].content,
                                      style: {
                                        "img": Style(
                                          width: Width(1.sw-80.w),
                                          height: Height(200),
                                        ),
                                        "p":Style(
                                          textAlign: TextAlign.justify
                                        )
                                      }
                                    ),
                                    SizedBox(height: 12.h,)
                                  ],
                                )),
                      ),
                    )
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
