import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_button.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_dialog.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_label_text_field.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_loading.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_toast.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/appbar_gradient_widget.dart';
import 'package:phu_tho_mobile/presentation/routes/route_name.dart';
import 'package:phu_tho_mobile/presentation/screens/account/change_password/change_password_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/account/change_password/change_password_state.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late ChangePasswordCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<ChangePasswordCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyFB,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: GradientAppBar(
          title: "Đổi mật khẩu người dùng",
          leading: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
          ),
          leadingAction: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocListener<ChangePasswordCubit, ChangePasswordState>(
        listenWhen: (previous, current) =>
            previous.loadStatus != current.loadStatus,
        listener: (context, state) {
          if (state.loadStatus == LoadStatus.loading) {
            showDialog(
                context: context,
                builder: (_) => const AppLoading(),
                barrierDismissible: false);
          }
          if (state.loadStatus == LoadStatus.success) {
            Navigator.of(context).pop();
            AppDialog.showDialogConfirm(context,
                label:
                    "Bạn đã thay đổi mật khẩu thành công. Vui lòng đăng nhập lại!",
                onConfirm: () {
              _cubit.logout();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(RouteName.login, (route) => false);
            });
          }
          if (state.loadStatus == LoadStatus.failure) {
            Navigator.of(context).pop();
            AppToast.showToastError(context, title: state.message);
          }
        },
        child: Container(
          padding: EdgeInsets.all(12.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // RichText(
              //   text: TextSpan(
              //     text: "Mật khẩu cũ ",
              //     style: AppTextStyle.textSm.copyWith(
              //         fontWeight: FontWeight.w600, color: AppColors.grey52),
              //     children: const <TextSpan>[
              //       TextSpan(text: '*', style: TextStyle(color: Colors.red)),
              //     ],
              //   ),
              // ),
              Text(
                "Người dùng vui lòng cung cấp đầy đủ thông tin!",
                style: AppTextStyle.textSm.copyWith(
                    fontWeight: FontWeight.w500, color: AppColors.grey52),
              ),
              SizedBox(
                height: 16.h,
              ),
              CustomLabelTextField(
                radius: 8.r,
                hintText: "Mật khẩu cũ",
                obscureText: true,
                defaultValue: _cubit.state.request.oldPassword,
                onChanged: (value) {
                  _cubit.onChangeRequest(
                      _cubit.state.request.copyWith(oldPassword: value));
                },
                colorBorder: AppColors.greyDF,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
                textStyleHint: AppTextStyle.textSm.copyWith(
                    fontWeight: FontWeight.w500, color: AppColors.grey72),
              ),
              SizedBox(
                height: 16.h,
              ),
              CustomLabelTextField(
                radius: 8.r,
                hintText: "Mật khẩu mới",
                obscureText: true,
                defaultValue: _cubit.state.request.newPassword,
                onChanged: (value) {
                  _cubit.onChangeRequest(
                      _cubit.state.request.copyWith(newPassword: value));
                },
                colorBorder: AppColors.greyDF,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
                textStyleHint: AppTextStyle.textSm.copyWith(
                    fontWeight: FontWeight.w500, color: AppColors.grey72),
              ),
              SizedBox(
                height: 16.h,
              ),
              CustomLabelTextField(
                radius: 8.r,
                hintText: "Nhập lại mật khẩu mới",
                defaultValue: _cubit.state.request.confirmPassword,
                obscureText: true,
                onChanged: (value) {
                  _cubit.onChangeRequest(
                      _cubit.state.request.copyWith(confirmPassword: value));
                },
                colorBorder: AppColors.greyDF,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
                textStyleHint: AppTextStyle.textSm.copyWith(
                    fontWeight: FontWeight.w500, color: AppColors.grey72),
              ),
              SizedBox(
                height: 20.h,
              ),
              AppButton(
                title: "Đổi mật khẩu",
                color: AppColors.blue,
                onPressed: () {
                  _cubit.changePassword();
                },
                radius: 8.r,
                contentPadding: EdgeInsets.symmetric(vertical: 8.h),
                textStyle: AppTextStyle.textSm
                    .copyWith(fontWeight: FontWeight.w500, color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
