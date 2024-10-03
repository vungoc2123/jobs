import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/gen/assets.gen.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_button.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_dialog.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_label_text_field.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_loading.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_toast.dart';
import 'package:phu_tho_mobile/presentation/routes/route_name.dart';
import 'package:phu_tho_mobile/presentation/screens/forgot_password/forgot_password_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/forgot_password/forgot_password_state.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late ForgotPasswordCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<ForgotPasswordCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          if (state.loadStatus == LoadStatus.loading) {
            showDialog(
                context: context,
                builder: (context) => const AppLoading(),
                barrierDismissible: false);
          }
          if (state.loadStatus == LoadStatus.success) {
            Navigator.of(context).pop();
            AppDialog.showDialogConfirm(context, label: state.message,
                onConfirm: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(RouteName.login, (route) => false);
            }, barrierDismissible: false);
          }
          if (state.loadStatus == LoadStatus.failure) {
            Navigator.of(context).pop();
            AppDialog.showDialogConfirm(context, label: state.message,
                onConfirm: () {
              Navigator.of(context).pop();
            }, barrierDismissible: false);
          }
        },
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.images.anhnen.path),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.all(16.r),
                child: Stack(
                  children: [
                    if (Navigator.of(context).canPop())
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Icon(
                          Icons.arrow_back_ios_new_outlined,
                          color: Colors.white,
                        ),
                      ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Logo
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              Assets.images.imgLogoApp.path,
                              height: 80.h,
                            ),
                            SizedBox(width: 20.w),
                            const Text(
                              'Việc làm Phú Thọ',
                              style: TextStyle(
                                  color: AppColors.white, fontSize: 30),
                            )
                          ],
                        ),
                        SizedBox(height: 40.h),
                        Text(
                          "Vui lòng nhập tài khoản và email đã đăng ký",
                          style: AppTextStyle.textSm.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.white),
                        ),
                        const SizedBox(height: 16),
                        CustomLabelTextField(
                          radius: 8.r,
                          hintText: tr("userName"),
                          defaultValue: _cubit.state.request.username,
                          onChanged: (value) {
                            _cubit.onChangeRequest(
                                _cubit.state.request.copyWith(username: value));
                          },
                          prefixIcon: const Icon(Icons.account_circle_sharp),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 16.h),
                          textStyleHint: AppTextStyle.textSm.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColors.grey72),
                        ),
                        SizedBox(height: 16.h),
                        // Password TextField
                        CustomLabelTextField(
                          radius: 8.r,
                          hintText: "Email",
                          defaultValue: _cubit.state.request.email,
                          onChanged: (value) {
                            _cubit.onChangeRequest(
                                _cubit.state.request.copyWith(email: value));
                          },
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 16.h),
                          prefixIcon: const Icon(Icons.email),
                          textStyleHint: AppTextStyle.textSm.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColors.grey72),
                        ),
                        SizedBox(height: 10.h),
                        SizedBox(height: 16.h),
                        // Forgot Password Link
                        SizedBox(
                          width: double.infinity,
                          child: AppButton(
                            onPressed: () {
                              if(_cubit.state.request.email.isEmpty || _cubit.state.request.username.isEmpty){
                                AppToast.showToastError(context, title: "Vui lòng điền đầy đủ thông tin");
                                return;
                              }
                              _cubit.forgotPassword();
                            },
                            textStyle: AppTextStyle.textXs.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                            radius: 8,
                            title: "Gửi yêu cầu",
                            color: AppColors.blueEA,
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 12.h),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
