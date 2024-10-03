import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/application/extentions/string_extension.dart';
import 'package:phu_tho_mobile/domain/models/argument/in_app_web_view_argument.dart';
import 'package:phu_tho_mobile/domain/models/request/notification/notification_request.dart';
import 'package:phu_tho_mobile/gen/assets.gen.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_dialog.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_load_more.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_loading.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_toast.dart';
import 'package:phu_tho_mobile/presentation/routes/route_name.dart';
import 'package:phu_tho_mobile/presentation/screens/list_job/widget/gradian_appbar.dart';
import 'package:phu_tho_mobile/presentation/screens/notification/notification_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/notification/notification_state.dart';
import 'package:skeletons/skeletons.dart';

import 'widgets/notification_item_widget.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late NotificationCubit _cubit;
  late ValueNotifier<bool> isOnlyUnRead;
  bool readNotification = false;

  @override
  void initState() {
    super.initState();
    isOnlyUnRead = ValueNotifier(true);
    _cubit = BlocProvider.of<NotificationCubit>(context);
    _cubit.getNotificationUnRead();
    _cubit.getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GradientAppBar(
            title: Text(
              tr("notification"),
              style: AppTextStyle.textLg
                  .copyWith(color: Colors.white, fontWeight: FontWeight.w700),
            ),
            actionBackWithResult: () {
              Navigator.of(context).pop(readNotification);
            },
            isOpenSearch: false,
            gradient: const LinearGradient(
                colors: [AppColors.blue44, AppColors.blueF8],
                begin: Alignment.topLeft,
                end: Alignment.topRight)),
        body: Column(
          children: [
            BlocBuilder<NotificationCubit, NotificationState>(
              buildWhen: (pre, cur) =>
                  pre.loadNotificationUnRead != cur.loadNotificationUnRead,
              builder: (context, state) {
                if (state.loadNotificationUnRead == LoadStatus.failure) {
                  return Padding(
                    padding: EdgeInsets.only(
                        bottom: 12.r, top: 16.r, right: 12.r, left: 12.r),
                    child: Row(
                      children: [
                        SvgPicture.asset(isOnlyUnRead.value
                            ? Assets.icons.icCheck.path
                            : Assets.icons.icUnCheck.path),
                        SizedBox(
                          width: 8.w,
                        ),
                        Text(
                          "${tr("onlyViewUnRead")} (Error)",
                          style: AppTextStyle.textSm.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColors.grey86),
                        )
                      ],
                    ),
                  );
                }
                if (state.loadNotificationUnRead == LoadStatus.success) {
                  return ValueListenableBuilder(
                    valueListenable: isOnlyUnRead,
                    builder: (context, value, _) {
                      return Padding(
                        padding: EdgeInsets.only(
                            bottom: 12.r, top: 16.r, right: 12.r, left: 12.r),
                        child: InkWell(
                          onTap: () {
                            if (!isOnlyUnRead.value) {
                              isOnlyUnRead.value = !value;
                              _cubit.onChangeRequest(const NotificationRequest(
                                  isReadFilter: false, pageIndex: 1));
                              _cubit.getNotifications();
                              return;
                            }
                            isOnlyUnRead.value = !value;
                            _cubit.onChangeRequest(const NotificationRequest(
                                isReadFilter: true, pageIndex: 1));
                            _cubit.getNotifications();
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset(isOnlyUnRead.value
                                  ? Assets.icons.icCheck.path
                                  : Assets.icons.icUnCheck.path),
                              SizedBox(
                                width: 8.w,
                              ),
                              Text(
                                "${tr("onlyViewUnRead")} (${state.notificationsUnRead.length})",
                                style: AppTextStyle.textSm.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.grey86),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
                return Padding(
                  padding: EdgeInsets.only(
                      bottom: 12.r, top: 16.r, right: 12.r, left: 12.r),
                  child: Row(
                    children: [
                      SvgPicture.asset(isOnlyUnRead.value
                          ? Assets.icons.icCheck.path
                          : Assets.icons.icUnCheck.path),
                      SizedBox(
                        width: 8.w,
                      ),
                      Text(
                        tr("onlyViewUnRead"),
                        style: AppTextStyle.textSm.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColors.grey86),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                            width: 20.w,
                            height: 12.h,
                            borderRadius: BorderRadius.circular(8.r)),
                      )
                    ],
                  ),
                );
              },
            ),
            BlocConsumer<NotificationCubit, NotificationState>(
              listenWhen: (pre, cur) =>
                  pre.loadDetailNotification != cur.loadDetailNotification,
              listener: (context, state) {
                if (state.loadDetailNotification == LoadStatus.loading) {
                  showDialog(
                      context: context,
                      builder: (context) => const AppLoading(),
                      barrierDismissible: false);
                }
                if (state.loadDetailNotification == LoadStatus.success) {
                  Navigator.of(context).pop();
                  // if (state.not.link != null && state.loadTickRead == false) {
                  //   final url = state.not.link!.toResourceUrl();
                  //   Navigator.of(context).pushNamed(RouteName.inAppWebView,
                  //       arguments: InAppWebViewArgument(
                  //           label: "Chi tiết thông báo", stringUrl: url));
                  // }
                  readNotification = true;
                  _cubit.onChangeRequest(state.request.copyWith(pageIndex: 1));
                  _cubit.getNotifications();
                  _cubit.getNotificationUnRead();
                }
                if (state.loadDetailNotification == LoadStatus.failure) {
                  Navigator.of(context).pop();
                  AppToast.showToastError(context,
                      title: "Không thể mở thông báo!");
                }
              },
              buildWhen: (pre, cur) =>
                  pre.loadStatus != cur.loadStatus ||
                  pre.loadMoreStatus != cur.loadMoreStatus,
              builder: (context, state) {
                if (state.loadStatus == LoadStatus.failure) {
                  return const Center(
                    child: Text("Error"),
                  );
                }
                if (state.loadStatus == LoadStatus.success) {
                  return Expanded(
                      child: SlidableAutoCloseBehavior(
                    child: AppLoadMore(
                      onLoadMore: () {
                        _cubit.getMoreNotifications();
                      },
                      onRefresh: () {
                        _cubit.onChangeRequest(
                            state.request.copyWith(pageIndex: 1));
                        _cubit.getNotifications();
                      },
                      child: ListView.separated(
                          itemBuilder: (context, index) => InkWell(
                                onTap: () {
                                  // _cubit.getDetailNotification(
                                  //     state.notifications[index].id, false);
                                },
                                child:
                                    state.notifications[index].isRead == false
                                        ? Slidable(
                                            key: UniqueKey(),
                                            endActionPane: ActionPane(
                                                extentRatio: 0.2,
                                                motion: const ScrollMotion(),
                                                children: [
                                                  if (state.notifications[index]
                                                          .isRead ==
                                                      false)
                                                    SlidableAction(
                                                      onPressed: (contextSli) {
                                                        AppDialog.showDialogConfirm(
                                                            context,
                                                            label:
                                                                "Bạn có muốn đánh dấu thông báo là đã đọc?",
                                                            onConfirm: () {
                                                          _cubit.getDetailNotification(
                                                              state
                                                                  .notifications[
                                                                      index]
                                                                  .id,
                                                              true);
                                                          Navigator.of(context)
                                                              .pop();
                                                        });
                                                      },
                                                      backgroundColor:
                                                          AppColors.blueFB,
                                                      foregroundColor:
                                                          AppColors.white,
                                                      icon: Icons.check_circle,
                                                    ),
                                                ]),
                                            child: NotificationWidget(
                                              not: state.notifications[index],
                                            ),
                                          )
                                        : NotificationWidget(
                                            not: state.notifications[index],
                                          ),
                              ),
                          separatorBuilder: (_, __) => const Divider(
                                color: AppColors.greyF6,
                              ),
                          itemCount: state.notifications.length),
                    ),
                  ));
                }
                return Expanded(child: skeletonLoading());
              },
            ),
          ],
        ));
  }

  Widget skeletonLoading() {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, __) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 12.w,
              ),
              SizedBox(
                width: 1.sw - 32.w,
                child: Row(
                  children: [
                    SkeletonLine(
                      style: SkeletonLineStyle(width: 60.r, height: 60.r),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SkeletonLine(
                            style: SkeletonLineStyle(
                                width: 1.sw - 100.w, height: 20.h),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          SkeletonLine(
                            style:
                                SkeletonLineStyle(width: 100.w, height: 20.h),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
        separatorBuilder: (_, __) => const Divider(
              color: AppColors.greyF6,
            ),
        itemCount: 10);
  }
}
