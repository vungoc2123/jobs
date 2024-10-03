import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/application/extentions/string_extension.dart';
import 'package:phu_tho_mobile/application/utils/app_utils.dart';
import 'package:phu_tho_mobile/domain/models/argument/in_app_web_view_argument.dart';
import 'package:phu_tho_mobile/domain/models/response/banner/banner_response.dart';
import 'package:phu_tho_mobile/gen/assets.gen.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_loading_indicator.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_network_image.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_slide_widgets.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/appbar_gradient_widget.dart';
import 'package:phu_tho_mobile/presentation/routes/route_name.dart';
import 'package:phu_tho_mobile/presentation/screens/home/bloc/home_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/home/bloc/home_state.dart';
import 'package:phu_tho_mobile/presentation/screens/home/widget/employer_widget.dart';
import 'package:phu_tho_mobile/presentation/screens/home/widget/job_widget.dart';
import 'package:phu_tho_mobile/presentation/screens/home/widget/menu_tab_home.dart';
import 'package:phu_tho_mobile/presentation/screens/home/widget/profile_widget.dart';

class SlideModel {
  String image;
  String title;
  String description;

  SlideModel(
      {required this.image, required this.title, required this.description});
}

class ProviderModel {
  String image;
  String title;

  ProviderModel({required this.image, required this.title});
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeCubit _cubit;
  late List<Widget> banners;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<HomeCubit>(context);
    _cubit.getBanner();
    _cubit.getJobs();
    _cubit.getCandidate();
    _cubit.getBusiness();
    _cubit.getNotificationUnRead();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyFB,
      appBar: const PreferredSize(
        preferredSize: Size(0, 0),
        child: GradientAppBar(),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.blue44, AppColors.blueF8],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Assets.images.imgLogoApp
                                .image(width: 46.r, height: 46.r),
                            SizedBox(
                              width: 8.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tr("titleApp"),
                                  style: AppTextStyle.textBase.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.white),
                                ),
                                Text(
                                  tr("hello"),
                                  style: AppTextStyle.textSm.copyWith(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            )
                          ],
                        ),
                        BlocBuilder<HomeCubit, HomeState>(
                          buildWhen: (pre, cur) =>
                              pre.loadNotificationStatus !=
                              cur.loadNotificationStatus,
                          builder: (context, state) {
                            return icon(
                                Assets.icons.notifications.svg(
                                    colorFilter: const ColorFilter.mode(
                                      AppColors.white,
                                      BlendMode.srcIn,
                                    ),
                                    width: 24.r,
                                    height: 24.r), () async {
                              final result = await Navigator.pushNamed(
                                context,
                                RouteName.notification,
                              );
                              if (result != null &&
                                  result is bool &&
                                  result == true) {
                                _cubit.getNotificationUnRead();
                              }
                            }, state.notifications.length);
                          },
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<HomeCubit, HomeState>(
                    buildWhen: (previous, current) =>
                        previous.loadBannerStatus != current.loadBannerStatus,
                    builder: (context, state) {
                      if (state.loadBannerStatus == LoadStatus.failure) {
                        return const Center(
                          child: Text("Error"),
                        );
                      }
                      if (state.loadBannerStatus == LoadStatus.success) {
                        // if (state.banners.isEmpty) {
                        //   return const SizedBox();
                        // }
                        banners = state.banners.map((e) => banner(e)).toList();
                        return AppSlideWidget(
                          widgets: banners,
                          viewportFraction: 1,
                          sizeIndicator: 8.r,
                          space: 0,
                          unselectedColor: AppColors.white,
                          enlargeCenterPage: false,
                          aspectRatio: 2.5,
                          enableInfiniteScroll: true,
                        );
                      }
                      return SizedBox(
                          height: 130.h,
                          child: const Center(
                            child: AppLoadingIndicator(),
                          ));
                    },
                  ),
                  SizedBox(
                    height: 16.h,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            const MenuTabHome(),
            SizedBox(
              height: 16.h,
            ),
            titleItem(
                title: tr('bestJob'),
                show: false,
                callback: () {
                  Navigator.pushNamed(context, RouteName.listJob);
                }),
            Container(
              color: Colors.transparent,
              child: BlocBuilder<HomeCubit, HomeState>(
                buildWhen: (previous, current) =>
                    previous.loadJobStatus != current.loadJobStatus,
                builder: (context, state) {
                  if (state.loadJobStatus == LoadStatus.failure) {
                    return const Text("Error");
                  }
                  if (state.loadJobStatus == LoadStatus.success) {
                    return JobWidget(jobs: state.jobs);
                  }
                  return SizedBox(
                    height: 500.h,
                    child: const Center(
                      child: AppLoadingIndicator(),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            titleItem(
                title: tr('outstandingEmployer'),
                show: false,
                callback: () {
                  // Navigator.of(context).pushNamed(RouteName.listEmployers,arguments: DetailBusinessArgument(type: TypeAction.extract));
                }),
            BlocBuilder<HomeCubit, HomeState>(
              buildWhen: (previous, current) =>
                  previous.loadBusinessStatus != current.loadBusinessStatus,
              builder: (context, state) {
                if (state.loadBusinessStatus == LoadStatus.failure) {
                  return SizedBox(
                    height: 70.h,
                    child: const Center(
                      child: Text("Error"),
                    ),
                  );
                }

                if (state.loadBusinessStatus == LoadStatus.success) {
                  return EmployerWidget(
                    business: state.business,
                  );
                }
                return SizedBox(
                  height: 70.h,
                  child: const Center(
                    child: AppLoadingIndicator(),
                  ),
                );
              },
            ),
            SizedBox(
              height: 16.h,
            ),
            titleItem(
                title: tr('outstandingCandidate'),
                show: false,
                callback: () {
                  Navigator.of(context).pushNamed(RouteName.listCandidate);
                }),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state.loadCandidateStatus == LoadStatus.failure) {
                  return const Text("Error");
                }
                if (state.loadCandidateStatus == LoadStatus.success) {
                  return ProfileWidget(
                    candidates: state.listCandidate,
                  );
                }
                return SizedBox(
                  height: 500.h,
                  child: const Center(
                    child: AppLoadingIndicator(),
                  ),
                );
              },
            ),
            SizedBox(
              height: 20.h,
            )
          ],
        ),
      ),
    );
  }

  Widget icon(Widget icon, VoidCallback? action, int quantity) {
    return GestureDetector(
      onTap: () {
        AppUtils.checkTokenBeforeImplement(context, onPress: () {
          action?.call();
        });
      },
      child: SizedBox(
        width: 43.r,
        height: 43.r,
        child: Stack(children: [
          Positioned(
            bottom: 0,
            child: CircleAvatar(
              backgroundColor: AppColors.white.withOpacity(0.2),
              child: icon,
            ),
          ),
          if (quantity != 0)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 22.r,
                height: 22.r,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1000.r),
                    color: AppColors.red14,
                    border: Border.all(color: Colors.white)),
                padding: EdgeInsets.all(2.r),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    quantity > 9 ? "9+" : quantity.toString(),
                    style: AppTextStyle.textSs.copyWith(
                        fontWeight: FontWeight.w600, color: AppColors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
        ]),
      ),
    );
  }

  Widget banner(BannerResponse banner) {
    return GestureDetector(
      onTap: () async {
        final url = await banner.link.toResourceUrl().withUserToken();
        if (mounted) {
          Navigator.of(context).pushNamed(RouteName.inAppWebView,
              arguments:
                  InAppWebViewArgument(label: banner.title, stringUrl: url));
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: AppNetworkImage(
                  banner.fileAttached,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )),
            // Image.network(model.getFileAttached(),
            //     width: double.infinity, fit: BoxFit.cover)
            Positioned(
              left: 16.w,
              bottom: 25.h,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 0), // Điều chỉnh vị trí đổ bóng
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(banner.title,
                        style: AppTextStyle.textXs.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.white)),
                    if (banner.description.isNotEmpty)
                      Text(banner.description,
                          style: AppTextStyle.textXs.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColors.white)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget providerImage(ProviderModel providerModel) {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: GestureDetector(
        onTap: () {
          // Navigator.pushNamed(context, RouteName.detailEmployer,
          //     arguments: Data.listEmployers[0]);
        },
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8.r)),
          padding: EdgeInsets.all(10.r),
          child: Column(
            children: [
              SizedBox(
                width: 60.r,
                height: 60.r,
                child: AppNetworkImage(providerModel.image,
                    fit: BoxFit.cover, radius: 8),
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(providerModel.title,
                  style: AppTextStyle.textXs.copyWith(
                      fontWeight: FontWeight.w600, color: AppColors.white))
            ],
          ),
        ),
      ),
    );
  }

  Widget titleItem(
      {required String title, required bool show, VoidCallback? callback}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: AppTextStyle.textLg.copyWith(
                  fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
          if (show)
            GestureDetector(
              onTap: callback,
              child: Text(
                tr('seeAll'),
                style: AppTextStyle.textSm.copyWith(
                    fontWeight: FontWeight.w500, color: AppColors.blue),
              ),
            ),
        ],
      ),
    );
  }
}
