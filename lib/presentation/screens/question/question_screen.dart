import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/gen/assets.gen.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_label_text_field.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_load_more.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_loading.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/emty_list_data.dart';
import 'package:phu_tho_mobile/presentation/routes/route_name.dart';
import 'package:phu_tho_mobile/presentation/screens/question/question_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/question/question_state.dart';
import 'package:phu_tho_mobile/presentation/screens/question/widget/question_widget.dart';

import '../../../application/constants/app_text_style.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  late QuestionCubit cubit;
  ValueNotifier<bool> openSearch = ValueNotifier(false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit = BlocProvider.of<QuestionCubit>(context);
    cubit.getAllQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyFB,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          padding: EdgeInsets.only(right: 8.w),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.blue44, AppColors.blueF8],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: ValueListenableBuilder(
            builder: (context, value, child) => AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              centerTitle: true,
              elevation: 0,
              leading: !openSearch.value
                  ? IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 15.w,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  : null,
              leadingWidth: openSearch.value ? null : 48.w,
              title: openSearch.value
                  ? CustomLabelTextField(
                      maxLine: 1,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                      prefixIcon: Assets.icons.search.svg(
                          width: 15.r,
                          height: 15.r,
                          colorFilter: const ColorFilter.mode(
                              AppColors.grey86, BlendMode.srcIn)),
                      textStyleHint: AppTextStyle.textSm.copyWith(),
                      textStyleInput: AppTextStyle.textSm.copyWith(),
                      radius: 99.r,
                      onChanged: (values) {
                        cubit.changeRequest(values);
                        cubit.getAllQuestion();
                      },
                      hintText: tr("inputName"),
                      backgroundColor: AppColors.grayF2,
                    )
                  : Text(
                      "Câu hỏi",
                      style: AppTextStyle.textBase.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
              actions: <Widget>[
                IconButton(
                  icon: !openSearch.value
                      ? Assets.icons.search.svg(
                          colorFilter: const ColorFilter.mode(
                            AppColors.white,
                            BlendMode.srcIn,
                          ),
                        )
                      : Text(
                          tr("Cancel"),
                          style: AppTextStyle.textSm
                              .copyWith(color: AppColors.white),
                        ),
                  onPressed: () {
                    openSearch.value = !openSearch.value;
                    if (!openSearch.value) {
                      cubit.changeRequest('');
                      cubit.getAllQuestion();
                    }
                  },
                ),
              ],
            ),
            valueListenable: openSearch,
          ),
        ),
      ),
      body: SafeArea(
          child: AppLoadMore(
        onRefresh: () => cubit.getAllQuestion(),
        onLoadMore: () => cubit.getQuestionMore(),
        child: BlocBuilder<QuestionCubit, QuestionState>(
          buildWhen: (previous, current) => previous.status != current.status,
          builder: (context, state) {
            if (state.status == LoadStatus.loading) {
              return const AppLoading();
            }
            if (state.status == LoadStatus.failure) {
              return const EmptyListData();
            }
            if (state.status == LoadStatus.success && state.questions.isEmpty) {
              return const EmptyListData();
            }
            if (state.status == LoadStatus.success) {
              return ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                  itemBuilder: (context, index) => InkWell(
                      borderRadius: BorderRadius.circular(16.r),
                      onTap: () {
                        Navigator.pushNamed(context, RouteName.detailQuestion,
                            arguments: state.questions[index]);
                      },
                      child: Ink(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 8.h),
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(16.r)),
                          child: QuestionWidget(
                              question: state.questions[index]))),
                  separatorBuilder: (context, index) => SizedBox(
                        height: 8.h,
                      ),
                  itemCount: state.questions.length);
            }
            return const SizedBox();
          },
        ),
      )),
    );
  }
}
