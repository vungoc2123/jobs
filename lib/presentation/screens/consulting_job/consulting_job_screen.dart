import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_deep_link.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/application/enums/searchField.dart';
import 'package:phu_tho_mobile/application/extentions/string_extension.dart';
import 'package:phu_tho_mobile/domain/models/argument/in_app_web_view_argument.dart';
import 'package:phu_tho_mobile/domain/models/request/advise/advise_request.dart';
import 'package:phu_tho_mobile/gen/assets.gen.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_label_text_field.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_load_more.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_loading.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/emty_list_data.dart';
import 'package:phu_tho_mobile/presentation/routes/route_name.dart';
import 'package:phu_tho_mobile/presentation/screens/consulting_job/conslting_state.dart';
import 'package:phu_tho_mobile/presentation/screens/consulting_job/consulting_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/consulting_job/widget/item_advise.dart';
import 'package:phu_tho_mobile/presentation/screens/list_job/widget/gradian_appbar.dart';

class ConsultingJobScreen extends StatefulWidget {
  const ConsultingJobScreen({super.key});

  @override
  State<ConsultingJobScreen> createState() => _ConsultingJobScreenState();
}

class _ConsultingJobScreenState extends State<ConsultingJobScreen> {
  late ConsultingCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<ConsultingCubit>(context);
    cubit.getAllAdvise();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final url = AppDeepLink.consultationJob.toResourceUrl();
          if (context.mounted) {
            Navigator.of(context).pushNamed(RouteName.inAppWebView,
                arguments:
                    InAppWebViewArgument(label: "Hỏi đáp", stringUrl: url));
          }
        },
        backgroundColor: AppColors.blueEA,
        child: Assets.icons.icMessage.svg(
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
      ),
      backgroundColor: AppColors.greyFB,
      appBar: GradientAppBar(
          title: Text(
            "Tư vấn việc làm",
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
            // Container(
            //   width: 1.sw,
            //   color: AppColors.white,
            //   padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            //   child: BlocBuilder<ConsultingCubit, ConsultingState>(
            //       builder: (context, state) {
            //     if (state.openSearch) {
            //       return search();
            //     }
            //     return SingleChildScrollView(
            //         scrollDirection: Axis.horizontal,
            //         child: Row(
            //           children: [
            //             InkWell(
            //               onTap: () {
            //                 cubit.refreshFilter();
            //                 cubit.getAllAdvise();
            //               },
            //               borderRadius: BorderRadius.circular(20.r),
            //               child: Container(
            //                 padding: EdgeInsets.symmetric(
            //                     horizontal: 8.w, vertical: 4.h),
            //                 decoration: BoxDecoration(
            //                     borderRadius: BorderRadius.circular(20.r),
            //                     border: Border.all(color: AppColors.blue)),
            //                 child: Text(
            //                   tr("refresh"),
            //                   style: AppTextStyle.textSm.copyWith(
            //                       color: AppColors.grey4D,
            //                       fontWeight: FontWeight.w400),
            //                 ),
            //               ),
            //             ),
            //             SizedBox(
            //               width: 8.w,
            //             ),
            //             itemSearch(
            //                 title: "Tên doanh nghiệp",
            //                 value: state.request.nameBusiness ??
            //                     "Tên doanh nghiệp",
            //                 field: SearchField.businessName),
            //             SizedBox(
            //               width: 8.w,
            //             ),
            //             itemSearch(
            //                 title: "Tên khu công nghiệp",
            //                 value: state.request.industrialPark ??
            //                     "Tên khu công nghiệp",
            //                 field: SearchField.industrialParkName),
            //             SizedBox(
            //               width: 8.w,
            //             ),
            //             itemSearch(
            //               title: "Địa chỉ",
            //               value: state.request.location ?? "Địa chỉ",
            //               field: SearchField.address,
            //             ),
            //             SizedBox(
            //               width: 8.w,
            //             ),
            //             itemSearch(
            //               title: "Mã số thuế",
            //               value: state.request.taxCode ?? "Mã số thuế",
            //               field: SearchField.taxCode,
            //             ),
            //             SizedBox(
            //               width: 8.w,
            //             ),
            //             itemSearch(
            //                 title: "Hotline",
            //                 value: state.request.hotlineFilter ?? "Hotline",
            //                 field: SearchField.hotline),
            //           ],
            //         ));
            //   }),
            // ),
            Expanded(
                child: AppLoadMore(
              onLoadMore: () => cubit.getAdviseMore(),
              onRefresh: () {
                cubit.state.copyWith(request: const AdviseRequest());
                cubit.getAllAdvise();
              },
              child: BlocBuilder<ConsultingCubit, ConsultingState>(
                buildWhen: (previous, current) =>
                    previous.status != current.status,
                builder: (context, state) {
                  if (state.status == LoadStatus.failure) {
                    return const Center(
                      child: EmptyListData(),
                    );
                  }
                  if (state.status == LoadStatus.success &&
                      state.advises.isEmpty) {
                    return const Center(
                      child: EmptyListData(),
                    );
                  }

                  if (state.status == LoadStatus.loading) {
                    return const AppLoading();
                  }

                  if (state.status == LoadStatus.success) {
                    return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 8.h),
                        itemBuilder: (context, index) => InkWell(
                              onTap: () => (),
                              borderRadius: BorderRadius.circular(12.r),
                              child: Ink(
                                decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(12.r)),
                                child: ItemAdvise(advise: state.advises[index]),
                              ),
                            ),
                        separatorBuilder: (context, index) => SizedBox(
                              height: 8.h,
                            ),
                        itemCount: state.advises.length);
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

  Widget itemSearch(
      {required String title,
      required String value,
      VoidCallback? callback,
      required SearchField field}) {
    return InkWell(
      onTap: () {
        cubit.openSearch(field);
      },
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
                color: title == value ? AppColors.greyDF : AppColors.blue)),
        child: Text(
          title != value ? cubit.getValueRequest(cubit.state.field) : title,
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
            hintText: tr("inputName"),
            contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20),
            radius: 20.r,
            colorBorder: AppColors.greyDF,
            textStyleHint: AppTextStyle.textSm,
            maxLine: 1,
            onSubmit: (value) {
              cubit.changeRequestByField(cubit.state.field, value);
              cubit.openSearch(SearchField.unknown);
              cubit.getAllAdvise();
            },
            prefixIcon: Assets.icons.search.svg(
                width: 16.r,
                height: 16.r,
                colorFilter:
                    const ColorFilter.mode(AppColors.grey, BlendMode.srcIn)),
          ),
        ),
        SizedBox(
          width: 8.w,
        ),
        InkWell(
          onTap: () {
            cubit.openSearch(SearchField.unknown);
            cubit.state.copyWith(request: const AdviseRequest());
            cubit.getAllAdvise();
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
