import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_deep_link.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/application/extentions/string_extension.dart';
import 'package:phu_tho_mobile/domain/models/argument/in_app_web_view_argument.dart';
import 'package:phu_tho_mobile/domain/models/response/user/user_profile_response.dart';
import 'package:phu_tho_mobile/gen/assets.gen.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_button.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_dialog.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_loading.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_network_image.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_toast.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/row_infomation_widget.dart';
import 'package:phu_tho_mobile/presentation/routes/route_name.dart';
import 'package:phu_tho_mobile/presentation/screens/account/infomation_account/infomation_account_state.dart';
import 'package:phu_tho_mobile/presentation/screens/account/infomation_account/information_account_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/list_job/widget/gradian_appbar.dart';
import 'package:skeletons/skeletons.dart';

class InformationAccountScreen extends StatefulWidget {
  const InformationAccountScreen({super.key});

  @override
  State<InformationAccountScreen> createState() =>
      _InformationAccountScreenState();
}

class _InformationAccountScreenState extends State<InformationAccountScreen> {
  late InformationAccountCubit _cubit;
  bool changedInformationAccount = false;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<InformationAccountCubit>(context);
    _cubit.getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: GradientAppBar(
        isOpenSearch: false,
        actionBackWithResult: () {
          Navigator.of(context).pop(changedInformationAccount);
        },
        actionMore: IconButton(
          onPressed: () async {
            if (_cubit.state.loadStatus == LoadStatus.success) {
              final result = await Navigator.of(context).pushNamed(
                  RouteName.editInformation,
                  arguments: _cubit.state.userProfile);
              if (result is bool && result == true) {
                changedInformationAccount = true;
                _cubit.getUserProfile();
              }
            }
          },
          icon: Assets.icons.icEditOutline.svg(
              colorFilter:
                  const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
              width: 24.r,
              height: 24.r),
        ),
        title: Text(
          "Thông tin cá nhân",
          style: AppTextStyle.textBase
              .copyWith(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        gradient: const LinearGradient(
            colors: [AppColors.blue44, AppColors.blueF8],
            begin: Alignment.topLeft,
            end: Alignment.topRight),
      ),
      body: SafeArea(
        child: BlocConsumer<InformationAccountCubit, InformationAccountState>(
          listener: (context, state) {
            if(state.deleteStatus == LoadStatus.loading){
        
              showDialog(context: context, builder:(context) => const AppLoading(), barrierDismissible: false);
              Future.delayed(const Duration(seconds: 15), () {
                if (state.deleteStatus == LoadStatus.loading) {
                  Navigator.of(context).pop();
                  AppToast.showToastError(context, title: "Thao tác quá thời gian. Vui lòng thử lại.");
                  _cubit.cancelDeleteOperation();
                }
              });
            }
        
            if(state.deleteStatus == LoadStatus.success){
              if(Navigator.canPop(context)){
                Navigator.pop(context);
                Navigator.pushNamedAndRemoveUntil(context, RouteName.login, (route) => false);
                AppToast.showToastSuccess(context, title: state.message);
              }
            }
          },
          builder: (context, state) {
            if (state.loadStatus == LoadStatus.failure) {
              return const Center(
                child: Text("Error"),
              );
            }
            if (state.loadStatus == LoadStatus.success) {
              return Column(
                children: [
                  imageUser(state.userProfile),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(12.r),
                      child: Column(
                        children: [
                          RowInformationWidget(
                            label: "Tên tài khoản",
                            value: state.userProfile.username,
                          ),
                          Divider(
                            height: 30.h,
                            color: AppColors.greyF6,
                          ),
                          RowInformationWidget(
                            label: "Họ tên",
                            value: state.userProfile.fullName,
                          ),
                          Divider(
                            height: 30.h,
                            color: AppColors.greyF6,
                          ),
                          RowInformationWidget(
                            label: "Giới tính",
                            value: state.userProfile.genderTxt,
                          ),
                          Divider(
                            height: 30.h,
                            color: AppColors.greyF6,
                          ),
                          RowInformationWidget(
                            label: "Ngày sinh",
                            value: state.userProfile.birthDay.isEmpty
                                ? ""
                                : state.userProfile.birthDay.formatToDMY(),
                          ),
                          Divider(
                            height: 30.h,
                            color: AppColors.greyF6,
                          ),
                          RowInformationWidget(
                            label: "Điện thoại",
                            value: state.userProfile.phoneNumber,
                          ),
                          Divider(
                            height: 30.h,
                            color: AppColors.greyF6,
                          ),
                          RowInformationWidget(
                            label: "Email",
                            value: state.userProfile.email,
                          ),
                          Divider(
                            height: 30.h,
                            color: AppColors.greyF6,
                          ),
                          RowInformationWidget(
                            label: "Phòng, ban, đơn vị",
                            value: state.userProfile.departmentName,
                          ),
                          Divider(
                            height: 30.h,
                            color: AppColors.greyF6,
                          ),
                          RowInformationWidget(
                            label: "Chức vụ",
                            value: state.userProfile.idPositionName,
                          ),
                          Divider(
                            height: 30.h,
                            color: AppColors.greyF6,
                          ),
                          RowInformationWidget(
                            label: "Địa chỉ",
                            value: state.userProfile.address,
                          ),
                          Divider(
                            height: 30.h,
                            color: AppColors.greyF6,
                          ),
                          RowInformationWidget(
                              label: "Vai trò",
                              value: state.userProfile.rolesName),
                          SizedBox(
                            height: 32.h,
                          ),
                          AppButton(
                            onPressed: () {
                              AppDialog.showDialogConfirm(context, label: "Bạn chắc chắn muốn xóa tài khoản !", onConfirm: (){
                                _cubit.deleteAccount();
                              });
                            },
                            title: "Xóa tài khoản",
                            color: AppColors.red14,
                            textStyle: AppTextStyle.textSm
                                .copyWith(color: AppColors.white),
                            contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                            radius: 12.r,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
            }
            return skeletonWidget();
          },
        ),
      ),
    );
  }

  Widget imageUser(UserProfileResponse userProfile) {
    final nameParts = userProfile.fullName.split(" ") ?? [];
    final count = nameParts.length >= 2 ? 2 : nameParts.length;
    final shortName = nameParts.sublist(0, count).map((e) => e[0]);
    return Container(
      color: AppColors.white,
      child: Stack(alignment: Alignment.center, children: [
        Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.blue44, AppColors.blueF8],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              height: 100.h,
              width: 1.sw,
            ),
            SizedBox(
              height: 60.h,
            ),
          ],
        ),
        Positioned(
          bottom: 12.h,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Positioned(
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
                    userProfile.avatarUrl,
                    fit: BoxFit.contain,
                    radius: 50.r,
                    errorWidget: Container(
                      padding: EdgeInsets.all(2.r),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: AppColors.blueFB, width: 2.sp),
                      ),
                      child: SizedBox(
                        width: 55.r,
                        height: 55.r,
                        child: CircleAvatar(
                          backgroundColor: AppColors.blueFB.withOpacity(0.5),
                          child: Text(
                            shortName.join().toUpperCase(),
                            style: AppTextStyle.textXl.copyWith(
                              color: AppColors.blue44,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: InkWell(
                    onTap: () async {
                      //thay đổi ảnh đại diện
                      final url = await AppDeepLink.changeAvatarUser
                          .toResourceUrl()
                          .withUserToken();
                      if (mounted) {
                       await Navigator.of(context).pushNamed(RouteName.inAppWebView,
                            arguments: InAppWebViewArgument(
                                label: "Thay đổi ảnh đại diện",
                                stringUrl: url));
                       _cubit.getUserProfile();
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(6.r),
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: AppColors.greyDF, width: 2.r),
                          color: Colors.white,
                          shape: BoxShape.circle),
                      child: Assets.icons.icCamera.svg(
                          colorFilter: const ColorFilter.mode(
                              AppColors.blue, BlendMode.srcIn),
                          width: 20.r,
                          height: 20.r),
                    ),
                  ))
            ],
          ),
        ),
      ]),
    );
  }

  Widget skeletonWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: AppColors.white,
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.blue44, AppColors.blueF8],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                      height: 100.h,
                      width: 1.sw,
                    ),
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
                        child: SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            shape: BoxShape.circle,
                            width: 18.r,
                            height: 18.r,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 60.h,
                ),
              ],
            ),
          ),
          ListView.separated(
              padding: EdgeInsets.all(12.r),
              shrinkWrap: true,
              itemBuilder: (_, __) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          width: 1.sw / 2 - 70.w,
                          height: 20.h,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          width: 1.sw / 2 - 20.w,
                          height: 20.h,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ],
                  ),
              separatorBuilder: (_, __) => Divider(
                    height: 30.h,
                    color: AppColors.greyF6,
                  ),
              itemCount: 10)
        ],
      ),
    );
  }
}
