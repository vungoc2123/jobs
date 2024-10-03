import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_button.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_label_text_field.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_loading.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_toast.dart';
import 'package:phu_tho_mobile/presentation/screens/login/login_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/login/login_state.dart';

import '../../../gen/assets.gen.dart';
import '../../routes/route_name.dart';
import '../home_tab/home_tab.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  late LoginCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<LoginCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocListener<LoginCubit, LoginState>(
        listenWhen: (previous, current) =>
            previous.loadStatus != current.loadStatus,
        listener: (context, state) {
          if (state.loadStatus == LoadStatus.loading) {
            showDialog(
                context: context,
                builder: (context) => const AppLoading(),
                barrierDismissible: false);
          }
          if (state.loadStatus == LoadStatus.success) {
            // AppToast.showToastSuccess(context, title: state.message);
            Navigator.of(context).pop();
            Navigator.of(context).pushNamedAndRemoveUntil(
                RouteName.homeTab, (Route<dynamic> route) => false,
                arguments: const HomeTabArguments(index: 0));
          }
          if (state.loadStatus == LoadStatus.failure) {
            AppToast.showToastError(context, title: state.message);
            Navigator.of(context).pop();
          }
        },
        child: Stack(
          children: [
            // Background image
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.images.anhnen.path),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Content
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
                              height: 70.h,
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
                          tr("loginnow"),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 24),
                        ),
                        const SizedBox(height: 16),
                        CustomLabelTextField(
                          radius: 8.r,
                          hintText: tr("userName"),
                          maxLine: 1,
                          defaultValue: _cubit.state.loginRequest.userName,
                          onChanged: (value) {
                            _cubit.changeLoginRequest(_cubit.state.loginRequest
                                .copyWith(userName: value));
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
                          hintText: tr("password"),
                          maxLine: 1,
                          defaultValue: _cubit.state.loginRequest.password,
                          obscureText: _obscureText,
                          onChanged: (value) {
                            _cubit.changeLoginRequest(_cubit.state.loginRequest
                                .copyWith(password: value));
                          },
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 16.h),
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            child: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                          textStyleHint: AppTextStyle.textSm.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColors.grey72),
                        ),
                        SizedBox(height: 10.h),
                        SizedBox(height: 16.h),
                        // Forgot Password Link
                        Align(
                          alignment: Alignment.center,
                          child: TextButton(
                            onPressed: () {
                              // Xử lý sự kiện quên mật khẩu
                              Navigator.of(context)
                                  .pushNamed(RouteName.forgotPassword);
                            },
                            child: Text(
                              tr("forgotPassword"),
                              style: const TextStyle(color: AppColors.white),
                            ),
                          ),
                        ),

                        // Login Button
                        SizedBox(
                          width: double.infinity,
                          child: AppButton(
                            onPressed: () {
                              if (_cubit.state.loginRequest.userName == '' ||
                                  _cubit.state.loginRequest.password == '') {
                                AppToast.showToastError(context,
                                    title: tr("fillInformation"));
                                return;
                              }
                              _cubit.login();
                            },
                            textStyle:AppTextStyle.textXs.copyWith(color: Colors.white,fontWeight: FontWeight.w600),
                            radius: 8,
                            title: tr("login"),
                            color: AppColors.blueEA,
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 12.h),
                          ),
                        ),
                        SizedBox(height: 24.h),
                        //Register and Guest Experience Links
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              tr("noAccount"),
                              style: const TextStyle(color: Colors.white),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, RouteName.register);
                              },
                              child: Text(
                                tr("register"),
                                style: const TextStyle(
                                    color: Colors.lightBlueAccent),
                              ),
                            ),
                          ],
                        ),
                        if (!Navigator.canPop(context))
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                  RouteName.homeTab,
                                  arguments: const HomeTabArguments(index: 0),
                                  (route) => false,
                                );
                              },
                              child: Text(
                                "Trải nghiệm không cần đăng nhập",
                                style: AppTextStyle.textXs.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ))
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
