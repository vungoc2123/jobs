import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/domain/models/argument/detail_business_argument.dart';
import 'package:phu_tho_mobile/domain/models/argument/list_job_argument.dart';
import 'package:phu_tho_mobile/domain/models/response/business/business_response.dart';
import 'package:phu_tho_mobile/gen/assets.gen.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_loading_indicator.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_network_image.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/appbar_gradient_widget.dart';
import 'package:phu_tho_mobile/presentation/screens/business/detail_business/detail_business_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/business/detail_business/detail_business_state.dart';
import 'package:phu_tho_mobile/presentation/screens/business/job_of_business/job_of_business_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/business/job_of_business/job_of_business_widget.dart';
import 'package:phu_tho_mobile/presentation/screens/business/widgets/custom_tabbar_widget.dart';
import 'package:phu_tho_mobile/presentation/screens/business/widgets/infomation_widget.dart';

class DetailBusinessScreen extends StatefulWidget {
  final DetailBusinessArgument argument;

  const DetailBusinessScreen({super.key, required this.argument});

  @override
  State<DetailBusinessScreen> createState() => _DetailBusinessScreenState();
}

class _DetailBusinessScreenState extends State<DetailBusinessScreen>
    with SingleTickerProviderStateMixin {
  late DetailBusinessCubit _cubit;
  late List<String> tabIndex;
  late List<Widget> tabWidget;
  late RenderBox renderBox;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<DetailBusinessCubit>(context);
    _cubit.changeTypeAction(widget.argument.type);
    _cubit.getDetailBusiness(widget.argument.idBusiness);
    tabIndex = [tr("information"), tr("jobsFinding")];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: GradientAppBar(
          title: tr("employer"),
          leading: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
          ),
          leadingAction: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocBuilder<DetailBusinessCubit, DetailBusinessState>(
        buildWhen: (previous, current) =>
            previous.loadStatus != current.loadStatus,
        builder: (context, state) {
          if (state.loadStatus == LoadStatus.failure) {
            return const Expanded(
                child: Center(
              child: Text("Error"),
            ));
          }
          if (state.loadStatus == LoadStatus.success) {
            tabWidget = [
              InformationWidget(businessResponse: state.businessResponse),
              BlocProvider(
                  create: (context) => JobOfBusinessCubit(),
                  child: JobOfBusinessWidget(
                      argument: ListJobArgument(
                          typeAction: widget.argument.type,
                          idBusiness: state.businessResponse.id)))
            ];
            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  Container(child: commonInfo(state.businessResponse)),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomTabBarWidget(
                    tabTitles: tabIndex,
                    tabWidgets: tabWidget,
                  )
                ],
              ),
            );
          }
          return const Center(
            child: AppLoadingIndicator(),
          );
        },
      ),
    );
  }
}

Widget commonInfo(BusinessResponse businessResponse) {
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
                  border: Border.all(color: AppColors.white, width: 3),
                  color: AppColors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: AppNetworkImage(
                  businessResponse.getImagePath(),
                  fit: BoxFit.contain,
                  radius: 50.r,
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 60.h,
        ),
        Text(
          businessResponse.nameBusiness,
          style: AppTextStyle.textLg.copyWith(fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 4.h,
        ),
        Text(
          businessResponse.businessProfession != ""
              ? businessResponse.businessProfession
              : tr("noInfo"),
          style: AppTextStyle.textSm
              .copyWith(color: AppColors.blueEA, fontWeight: FontWeight.w600),
        ),
      ],
    ),
  );
}
