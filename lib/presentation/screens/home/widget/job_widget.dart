import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/application/enums/type_action.dart';
import 'package:phu_tho_mobile/application/extentions/list_extentions.dart';
import 'package:phu_tho_mobile/domain/models/argument/detail_job_argument.dart';
import 'package:phu_tho_mobile/domain/models/response/job/job_response.dart';
import 'package:phu_tho_mobile/gen/assets.gen.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_network_image.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_slide_widgets.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_widget_job.dart';
import 'package:phu_tho_mobile/presentation/routes/route_name.dart';

class JobWidget extends StatefulWidget {
  final List<JobResponse> jobs;

  const JobWidget({super.key, required this.jobs});

  @override
  State<JobWidget> createState() => _JobWidgetState();
}

class _JobWidgetState extends State<JobWidget> {
  late List<List<JobResponse>> jobs;
  late List<Widget> jobWidgets;

  @override
  void initState() {
    super.initState();
    jobs = widget.jobs.twoDimensionalArrayWithThreeElements;
    jobWidgets = jobs.map((e) => itemSlideJob(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removeViewPadding(
      removeTop: true,
      context: context,
      child: AppSlideWidget(
        height: 230.h * 3,
        widgets: jobWidgets,
        sizeIndicator: 8.r,
        space: 10.h,
        enlargeCenterPage: false,
        isExpandIndicator: false,
        autoPlay: false,
      ),
    );
  }

  Widget itemSlideJob(List<JobResponse> list) {
    return Container(
      color: Colors.transparent,
      child: ListView.separated(
        itemCount: list.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              // Navigator.pushNamed(context, RouteName.detailJob,
              //     arguments: list[index]);
              Navigator.pushNamed(context, RouteName.detailJob,
                  arguments: DetailJobArgument(typeAction: TypeAction.extract, job: list[index]));
                  //cần sửa chỗ này
            },
            child: AppWidgetJob(job: list[index],typeAction: TypeAction.extract,)
          );
        },
        separatorBuilder: (BuildContext context, int index) =>  SizedBox(
          height: 10.h,
        ),
      ),
    );
  }
}

class ItemJob extends StatefulWidget {
  const ItemJob(
      {super.key,
      required this.time,
      required this.sponsored,
      required this.providerName,
      required this.reputation,
      required this.isFavorite,
      required this.linkImage,
      required this.location,
      required this.money,
      required this.description,
      required this.nameJob,
      required this.type,
      required this.imageProvider,
      required this.evaluate});

  final String time;
  final bool sponsored;
  final String providerName;
  final bool reputation;
  final bool isFavorite;
  final String linkImage;
  final String location;
  final double money;
  final String description;
  final String nameJob;
  final String type;
  final String imageProvider;
  final double evaluate;

  @override
  State<StatefulWidget> createState() {
    return _ItemJobState();
  }
}

class _ItemJobState extends State<ItemJob> with SingleTickerProviderStateMixin {
  late bool favorite;
  late final AnimationController _controller = AnimationController(
      duration: const Duration(milliseconds: 200), vsync: this, value: 1.0);

  @override
  void initState() {
    super.initState();
    favorite = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      height: 225.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.time,
                style: AppTextStyle.textXs
                    .copyWith(color: const Color(0xff737373)),
              ),
              if (widget.sponsored)
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xffA5F0FC)),
                      borderRadius: BorderRadius.circular(16.r)),
                  child: Text(
                    tr("Sponsored"),
                    style: AppTextStyle.textXs
                        .copyWith(color: const Color(0xff0E7090)),
                  ),
                )
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 3,
                child: Text(
                  "${widget.nameJob}\n",
                  style: AppTextStyle.textBase.copyWith(
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff0F0F0F)),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              Flexible(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      favorite = !favorite;
                    });
                    _controller
                        .reverse()
                        .then((value) => _controller.forward());
                  },
                  child: ScaleTransition(
                    scale: Tween(begin: 0.7, end: 1.0).animate(CurvedAnimation(
                        parent: _controller, curve: Curves.easeOut)),
                    child: favorite
                        ? Assets.icons.heartActive.svg(
                            width: 20.w,
                            height: 20.h,
                            colorFilter: const ColorFilter.mode(
                                Colors.redAccent, BlendMode.srcIn),
                          )
                        : Assets.icons.heart.svg(
                            width: 20.w,
                            height: 20.h,
                            colorFilter: const ColorFilter.mode(
                                Color(0xff737373), BlendMode.srcIn),
                          ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          SizedBox(
            height: 100.r,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(8.r)),
                  child: AppNetworkImage(
                    widget.imageProvider,
                    radius: 8.r,
                    height: 100.r,
                    width: 100.r,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  width: 16.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.providerName}\n",
                        style: AppTextStyle.textSm.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      Row(
                        children: [
                          Assets.icons.markerPin03.svg(
                              height: 20.w,
                              width: 20.w,
                              colorFilter: const ColorFilter.mode(
                                  Color(0xff737373), BlendMode.srcIn)),
                          SizedBox(
                            width: 8.w,
                          ),
                          Expanded(
                            child: Text(widget.location,
                                style: AppTextStyle.textSm.copyWith(
                                    fontWeight: FontWeight.w500,
                                    overflow: TextOverflow.ellipsis)),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      Row(
                        children: [
                          Assets.icons.bankNote03.svg(
                              height: 20.w,
                              width: 20.w,
                              colorFilter: const ColorFilter.mode(
                                  Color(0xff737373), BlendMode.srcIn)),
                          SizedBox(
                            width: 8.w,
                          ),
                          Text('100.000.000đ',
                              style: AppTextStyle.textSm.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xff099250)))
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
