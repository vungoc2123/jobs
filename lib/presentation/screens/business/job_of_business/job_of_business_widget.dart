import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/domain/models/argument/list_job_argument.dart';
import 'package:phu_tho_mobile/gen/assets.gen.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_loading_indicator.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/noti_emty_list.dart';
import 'package:phu_tho_mobile/presentation/routes/route_name.dart';
import 'package:phu_tho_mobile/presentation/screens/business/job_of_business/job_of_business_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/business/job_of_business/job_of_business_state.dart';
import 'package:phu_tho_mobile/presentation/screens/home/widget/job_widget.dart';

class JobOfBusinessWidget extends StatefulWidget {
  // final int idBusiness;
  final ListJobArgument argument;

  const JobOfBusinessWidget({super.key, required this.argument});

  @override
  State<JobOfBusinessWidget> createState() => _JobOfBusinessWidgetState();
}

class _JobOfBusinessWidgetState extends State<JobOfBusinessWidget> {
  late JobOfBusinessCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<JobOfBusinessCubit>(context);
    _cubit.onChangeTypeAction(widget.argument.typeAction);
    _cubit.getJobs(widget.argument.idBusiness);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JobOfBusinessCubit, JobOfBusinessState>(
      builder: (context, state) {
        if (state.loadStatus == LoadStatus.failure) {
          return const Text("Error");
        }
        if (state.loadStatus == LoadStatus.success) {
          if (state.jobs.isEmpty) {
            return SizedBox(
              height: 400.h,
              child: Center(
                child: AppNotEmptyListWidget(
                    title: tr("noJobsFindingNow"),
                    icon: Image.asset(
                      Assets.images.folder.path,
                      width: 70.r,
                      height: 70.r,
                    )),
              ),
            );
          }
          return Container(
            padding: EdgeInsets.only(left: 10.r, right: 10.r, bottom: 10.r),
            child: Column(
              children: [
                SizedBox(
                  height: 15.h,
                ),
                JobWidget(jobs: state.jobs),
                SizedBox(
                  height: 12.h,
                ),
                if (state.jobs.length > 9)
                  InkWell(
                      borderRadius: BorderRadius.circular(12.r),
                      onTap: () {
                        Navigator.of(context).pushNamed(RouteName.listJob,
                            arguments: widget.argument);
                      },
                      child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 4.h),
                          child: Text(
                            tr("seeMore"),
                            style: AppTextStyle.textSm
                                .copyWith(color: AppColors.blue),
                          ))),
                SizedBox(
                  height: 12.h,
                ),
              ],
            ),
          );
        }
        return SizedBox(
          height: 100.h,
          child: const Center(
            child: AppLoadingIndicator(),
          ),
        );
      },
    );
  }
}
