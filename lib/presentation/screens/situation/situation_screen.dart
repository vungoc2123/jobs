import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/domain/models/request/service/service_request.dart';
import 'package:phu_tho_mobile/gen/assets.gen.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_label_text_field.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_load_more.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_loading.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/emty_list_data.dart';
import 'package:phu_tho_mobile/presentation/routes/route_name.dart';
import 'package:phu_tho_mobile/presentation/screens/list_job/widget/gradian_appbar.dart';
import 'package:phu_tho_mobile/presentation/screens/situation/situation_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/situation/situation_state.dart';
import 'package:phu_tho_mobile/presentation/screens/situation/widget/item_situation.dart';

class SituationScreen extends StatefulWidget {
  const SituationScreen({super.key});

  @override
  State<SituationScreen> createState() => _SituationScreenState();
}

class _SituationScreenState extends State<SituationScreen> {
  late SituationCubit cubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit = BlocProvider.of<SituationCubit>(context);
    cubit.getSituation();
  }
  
  String getValue(int field){
    switch (field){
      case 1:
        return (cubit.state.request.nameBusiness != '') ? "Tên doanh nghiệp: ${cubit.state.request.nameBusiness}" : "Tên doanh nghiệp";
      case 2:
        return (cubit.state.request.taxCode != '') ? "Mã số thuế: ${cubit.state.request.taxCode}" : "Mã số thuế";
      case 3:
        return (cubit.state.request.address != '') ? "Địa chỉ: ${cubit.state.request.address}" : "Địa chỉ";
      default:
        return "";
    }
  }

  String getDefaultValue(int field){
    switch (field){
      case 1:
        return cubit.state.request.nameBusiness ?? "";
      case 2:
        return cubit.state.request.taxCode ?? "";
      case 3:
        return cubit.state.request.address ?? "";
      default:
        return "";
    }
  }

  String getTitle(int field){
    switch (field){
      case 1:
        return "Tên doanh nghiệp...";
      case 2:
        return "Mã số thuế...";
      case 3:
        return "Địa chỉ...";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyFB,
      appBar: GradientAppBar(
          title: Text(
            "Tình hình thu nộp phí dịch vụ",
            style: AppTextStyle.textLg
                .copyWith(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          isOpenSearch: false,
          gradient: const LinearGradient(
              colors: [AppColors.blue44, AppColors.blueF8],
              begin: Alignment.topLeft,
              end: Alignment.topRight)),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: 1.sw,
              color: AppColors.white,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              child: BlocBuilder<SituationCubit, SituationState>(
                  builder: (context, state) {
                    if (state.openSearch) {
                      return search();
                    }
                    return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                cubit.changeRequest(pageIndex: 1,nameBusiness: '',address: '',taxCode: '');
                                cubit.getSituation();
                              },
                              borderRadius: BorderRadius.circular(20.r),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.w, vertical: 4.h),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.r),
                                    border: Border.all(color: AppColors.blue)),
                                child: Text(
                                  tr("refresh"),
                                  style: AppTextStyle.textSm.copyWith(
                                      color: AppColors.grey4D,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            itemSearch(
                                title: "Tên doanh nghiệp",
                                value: getValue(1),
                                callback: () => cubit.openSearch(1)),
                            SizedBox(
                              width: 8.w,
                            ),
                            itemSearch(
                                title: "Mã số thuế",
                                value: getValue(2),
                                callback: () => cubit.openSearch(2)),
                            SizedBox(
                              width: 8.w,
                            ),
                            itemSearch(
                                title: "Địa chỉ",
                                value: getValue(3),
                                callback: () => cubit.openSearch(3)),
                          ],
                        ));
                  }),
            ),
            Expanded(
              child: AppLoadMore(
                onRefresh: () {
                  cubit.getSituation();
                },
                onLoadMore: () {
                  cubit.getSituationMore();
                },
                child: BlocBuilder<SituationCubit, SituationState>(
                  builder: (context, state) {
                    if (state.status == LoadStatus.failure) {
                      return const Center(
                        child: EmptyListData(),
                      );
                    }
                    if (state.status == LoadStatus.loading) {
                      return const AppLoading();
                    }
                    if (state.status == LoadStatus.success) {
                      if(state.listData.isNotEmpty){
                        return ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 8.h),
                          itemBuilder: (context, index) => (InkWell(
                            borderRadius: BorderRadius.circular(12.w),
                            onTap: () => Navigator.pushNamed(
                                context, RouteName.situationDetail,
                                arguments: state.listData[index]),
                            child: Ink(
                                decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(12.w)),
                                child: ItemSituation(
                                    business: state.listData[index])),
                          )),
                          separatorBuilder: (context, index) => SizedBox(
                            height: 8.h,
                          ),
                          itemCount: state.listData.length,
                        );
                      }
                      return const EmptyListData();
                    }

                    return const EmptyListData();
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget itemSearch(
      {required String title, required String value, VoidCallback? callback}) {
    return InkWell(
      onTap: () {
        callback?.call();
      },
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
                color: title == value ? AppColors.greyDF : AppColors.blue)),
        child: Text(
          value.toString(),
          style: AppTextStyle.textSm
              .copyWith(color: AppColors.grey4D, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }

  Widget search() {
    return Row(
      children: [
        Expanded(
          child: CustomLabelTextField(
            defaultValue: getDefaultValue(cubit.state.searchField),
            hintText: getTitle(cubit.state.searchField),
            contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20),
            radius: 20.r,
            colorBorder: AppColors.greyDF,
            textStyleHint: AppTextStyle.textSm,
            maxLine: 1,
            onSubmit: (value) {
              if(cubit.state.searchField == 1){
                cubit.changeRequest(nameBusiness: value);
              }
              if(cubit.state.searchField == 2){
                cubit.changeRequest(taxCode: value);
              }
              if(cubit.state.searchField == 3){
                cubit.changeRequest(address: value);
              }
              cubit.getSituation();
            },
            prefixIcon: Assets.icons.search.svg(
                width: 16.r,
                height: 16.r,
                colorFilter:
                const ColorFilter.mode(AppColors.grey, BlendMode.srcIn)),
            onChanged: (value) {},
          ),
        ),
        SizedBox(
          width: 8.w,
        ),
        InkWell(
          onTap: () {
            cubit.openSearch(0);
          },
          child: Text(
            tr("Cancel"),
            style: AppTextStyle.textSm,
          ),
        )
      ],
    );
  }
}
