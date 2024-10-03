import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_load_more.dart';
import 'package:phu_tho_mobile/presentation/routes/route_name.dart';
import 'package:phu_tho_mobile/presentation/screens/terms_of_use/term_of_use_state.dart';
import 'package:phu_tho_mobile/presentation/screens/terms_of_use/terms_of_use_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/terms_of_use/widget/item_terms_widget.dart';

import '../../../application/enums/load_status.dart';
import '../../../gen/assets.gen.dart';
import '../../common_widgets/app_label_text_field.dart';
import '../../common_widgets/app_loading.dart';
import '../../common_widgets/emty_list_data.dart';

class TermsOfUseScreen extends StatefulWidget {
  const TermsOfUseScreen({super.key});

  @override
  State<TermsOfUseScreen> createState() => _TermsOfUseScreenState();
}

class _TermsOfUseScreenState extends State<TermsOfUseScreen> {
  late TermsOfUseCubit cubit;
  ValueNotifier<bool> openSearch = ValueNotifier(false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit = BlocProvider.of<TermsOfUseCubit>(context);
    cubit.getTermsOfUse();
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
                      radius: 99.r,
                      onChanged: (values) {
                        cubit.changeRequest(values);
                        cubit.getTermsOfUse();
                      },
                      prefixIcon: Assets.icons.search.svg(
                          width: 15.r,
                          height: 15.r,
                          colorFilter: const ColorFilter.mode(
                              AppColors.grey86, BlendMode.srcIn)),
                      hintText: tr("inputName"),
                textStyleHint: AppTextStyle.textSm.copyWith(),
                textStyleInput: AppTextStyle.textSm.copyWith(),
                      backgroundColor: AppColors.grayF2,
                    )
                  : Text(
                      tr("terms"),
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
                      cubit.getTermsOfUse();
                    }
                  },
                ),
              ],
            ), valueListenable: openSearch,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: AppLoadMore(
              onRefresh: () {
                cubit.getTermsOfUse();
              },
              onLoadMore: () {
                cubit.getTermsOfUseMore();
              },
              child: BlocBuilder<TermsOfUseCubit, TermsOfUseState>(
                buildWhen: (previous, current) => previous.status != current.status,
                builder: (context, state) {
                  if (state.status == LoadStatus.loading) {
                    return const AppLoading();
                  }
                  if (state.status == LoadStatus.failure) {
                    return const EmptyListData();
                  }
                  if (state.status == LoadStatus.success &&
                      state.listData.isEmpty) {
                    return const EmptyListData();
                  }
                  if (state.status == LoadStatus.success) {
                    return ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 8.h),
                        itemBuilder: (context, index) => InkWell(
                            borderRadius: BorderRadius.circular(16.r),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RouteName.detailTermOfUse,
                                  arguments: state.listData[index]);
                            },
                            child: Ink(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 8.h),
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                child: ItemTermsWidget(
                                    terms: state.listData[index]))),
                        separatorBuilder: (context, index) => SizedBox(
                              height: 8.h,
                            ),
                        itemCount: state.listData.length);
                  }
                  return const SizedBox();
                },
              ),
            ))
          ],
        ),
      ),
    );
  }
}
