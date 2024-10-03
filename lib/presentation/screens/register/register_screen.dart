import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/application/enums/gender.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/gen/assets.gen.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_button.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_label_text_field.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_loading.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_toast.dart';
import 'package:phu_tho_mobile/presentation/screens/list_job/widget/gradian_appbar.dart';
import 'package:phu_tho_mobile/presentation/screens/register/register_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/register/register_state.dart';
import 'package:phu_tho_mobile/presentation/screens/register/widget/radio_button.dart';
import 'package:phu_tho_mobile/presentation/screens/register/widget/radio_type_account.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late RegisterCubit cubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit = BlocProvider.of<RegisterCubit>(context);
    cubit.getDictItem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
          title: Text(
            "Đăng ký tài khoản",
            style: AppTextStyle.textLg
                .copyWith(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          isOpenSearch: false,
          gradient: const LinearGradient(
              colors: [AppColors.blue44, AppColors.blueF8],
              begin: Alignment.topLeft,
              end: Alignment.topRight)),
      body: SafeArea(
        child: BlocListener<RegisterCubit, RegisterState>(
          listenWhen: (previous, current) =>
              previous.message != current.message,
          listener: (context, state) {
            if (state.status == LoadStatus.failure) {
              AppToast.showToastError(context, title: state.message);
            }
            if (state.status == LoadStatus.success) {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
              AppToast.showToastSuccess(context, title: state.message);
            }

            if (state.status == LoadStatus.loading) {
              showDialog(
                context: context,
                builder: (context) => const AppLoading(),
              );
            }
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Column(
              children: [
                BlocBuilder<RegisterCubit, RegisterState>(
                  buildWhen: (previous, current) =>
                      previous.errorFullName != current.errorFullName,
                  builder: (context, state) => CustomLabelTextField(
                    label: "Tên người dùng",
                    hintText: "Tên người dùng",
                    maxLine: 1,
                    onChanged: (values) {
                      cubit.changeRequest(fullName: values);
                      cubit.validateFullName();
                    },
                    defaultValue: state.fullName,
                    errorMessage: state.errorFullName,
                    colorBorder: AppColors.greyEF,
                    textStyleLabel: AppTextStyle.textSm.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600),
                    textStyleHint: AppTextStyle.textSm.copyWith(),
                    textStyleInput: AppTextStyle.textSm
                        .copyWith(color: AppColors.textPrimary),
                    contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                    prefixIcon: Assets.icons.user.svg(
                        width: 16.r,
                        height: 16.r,
                        colorFilter: const ColorFilter.mode(
                            AppColors.textPrimary, BlendMode.srcIn)),
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                BlocBuilder<RegisterCubit, RegisterState>(
                  buildWhen: (previous, current) =>
                      previous.errorUserName != current.errorUserName,
                  builder: (context, state) => CustomLabelTextField(
                    colorBorder: AppColors.greyEF,
                    label: "Tên tài khoản",
                    hintText: "Tên tài khoản",
                    onChanged: (values) {
                      cubit.changeRequest(useName: values);
                      cubit.validateUseName();
                    },
                    maxLine: 1,
                    defaultValue: state.userName,
                    errorMessage: state.errorUserName,
                    textStyleLabel: AppTextStyle.textSm.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600),
                    textStyleHint: AppTextStyle.textSm.copyWith(),
                    textStyleInput: AppTextStyle.textSm
                        .copyWith(color: AppColors.textPrimary),
                    contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                    prefixIcon: Assets.icons.user.svg(
                        width: 16.r,
                        height: 16.r,
                        colorFilter: const ColorFilter.mode(
                            AppColors.textPrimary, BlendMode.srcIn)),
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                BlocBuilder<RegisterCubit, RegisterState>(
                  buildWhen: (previous, current) =>
                      previous.errorPassword != current.errorPassword,
                  builder: (context, state) => CustomLabelTextField(
                    colorBorder: AppColors.greyEF,
                    label: "Mật khẩu",
                    hintText: "Mật khẩu",
                    onChanged: (values) {
                      cubit.changeRequest(password: values);
                      cubit.validatePassword();
                    },
                    maxLine: 1,
                    obscureText: true,
                    defaultValue: state.password,
                    errorMessage: state.errorPassword,
                    textStyleLabel: AppTextStyle.textSm.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600),
                    textStyleHint: AppTextStyle.textSm.copyWith(),
                    textStyleInput: AppTextStyle.textSm
                        .copyWith(color: AppColors.textPrimary),
                    contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                    prefixIcon: Assets.icons.clocked.svg(
                        width: 16.r,
                        height: 16.r,
                        colorFilter: const ColorFilter.mode(
                            AppColors.textPrimary, BlendMode.srcIn)),
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                BlocBuilder<RegisterCubit, RegisterState>(
                  buildWhen: (previous, current) =>
                      previous.errorConfirmPass != current.errorConfirmPass,
                  builder: (context, state) => CustomLabelTextField(
                    colorBorder: AppColors.greyEF,
                    label: "Nhập lại mật khẩu",
                    hintText: "Nhập lại mật khẩu",
                    onChanged: (values) {
                      cubit.changeRequest(confirmPass: values);
                      cubit.validateConfirmPassword();
                    },
                    maxLine: 1,
                    obscureText: true,
                    defaultValue: state.confirmPass,
                    errorMessage: state.errorConfirmPass,
                    textStyleLabel: AppTextStyle.textSm.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600),
                    textStyleHint: AppTextStyle.textSm.copyWith(),
                    textStyleInput: AppTextStyle.textSm
                        .copyWith(color: AppColors.textPrimary),
                    contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                    prefixIcon: Assets.icons.clocked.svg(
                        width: 16.r,
                        height: 16.r,
                        colorFilter: const ColorFilter.mode(
                            AppColors.textPrimary, BlendMode.srcIn)),
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                BlocBuilder<RegisterCubit, RegisterState>(
                  builder: (context, state) => Row(
                    children: [
                      RadioButton(
                        values: state.gender,
                        title: "Nam",
                        defaultValue: Gender.men,
                        callback: () => cubit.changeRequest(gender: Gender.men),
                      ),
                      SizedBox(
                        width: 16.w,
                      ),
                      RadioButton(
                          values: state.gender,
                          title: "Nữ",
                          defaultValue: Gender.woman,
                          callback: () =>
                              cubit.changeRequest(gender: Gender.woman)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                BlocBuilder<RegisterCubit, RegisterState>(
                  buildWhen: (previous, current) =>
                      previous.errorPhoneNumber != current.errorPhoneNumber,
                  builder: (context, state) => CustomLabelTextField(
                    colorBorder: AppColors.greyEF,
                    label: "Số điện thoại",
                    hintText: "Số điện thoại",
                    onChanged: (values) {
                      cubit.changeRequest(phoneNumber: values);
                      cubit.validatePhoneNumber();
                    },
                    maxLine: 1,
                    defaultValue: state.phoneNumber,
                    errorMessage: state.errorPhoneNumber,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    textStyleLabel: AppTextStyle.textSm.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600),
                    textStyleHint: AppTextStyle.textSm.copyWith(),
                    textStyleInput: AppTextStyle.textSm
                        .copyWith(color: AppColors.textPrimary),
                    contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                    prefixIcon: Assets.icons.icTelephone.svg(
                        width: 16.r,
                        height: 16.r,
                        colorFilter: const ColorFilter.mode(
                            AppColors.textPrimary, BlendMode.srcIn)),
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                BlocBuilder<RegisterCubit, RegisterState>(
                  buildWhen: (previous, current) =>
                      previous.errorEmail != current.errorEmail,
                  builder: (context, state) => CustomLabelTextField(
                    colorBorder: AppColors.greyEF,
                    label: "Email",
                    hintText: "Email",
                    onChanged: (values) {
                      cubit.changeRequest(email: values);
                      cubit.validateEmail();
                    },
                    maxLine: 1,
                    defaultValue: state.email,
                    errorMessage: state.errorEmail,
                    textStyleLabel: AppTextStyle.textSm.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600),
                    textStyleHint: AppTextStyle.textSm.copyWith(),
                    textStyleInput: AppTextStyle.textSm
                        .copyWith(color: AppColors.textPrimary),
                    contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                    prefixIcon: Assets.icons.mail02.svg(
                        width: 16.r,
                        height: 16.r,
                        colorFilter: const ColorFilter.mode(
                            AppColors.textPrimary, BlendMode.srcIn)),
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                BlocBuilder<RegisterCubit, RegisterState>(
                  buildWhen: (previous, current) =>
                      previous.errorAddress != current.errorAddress,
                  builder: (context, state) => CustomLabelTextField(
                    colorBorder: AppColors.greyEF,
                    label: "Địa chỉ",
                    hintText: "Địa chỉ",
                    onChanged: (values) {
                      cubit.changeRequest(address: values);
                      cubit.validateAddress();
                    },
                    defaultValue: state.address,
                    errorMessage: state.errorAddress,
                    textStyleLabel: AppTextStyle.textSm.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600),
                    textStyleHint: AppTextStyle.textSm.copyWith(),
                    textStyleInput: AppTextStyle.textSm
                        .copyWith(color: AppColors.textPrimary),
                    contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                    prefixIcon: Assets.icons.markerPin03.svg(
                        width: 16.r,
                        height: 16.r,
                        colorFilter: const ColorFilter.mode(
                            AppColors.textPrimary, BlendMode.srcIn)),
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                SizedBox(
                  width: 1.sw,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Loại tài khoản",
                        style: AppTextStyle.textSm.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      BlocBuilder<RegisterCubit, RegisterState>(
                        buildWhen: (previous, current) =>
                            previous.type != current.type ||
                            previous.typeAccount != current.typeAccount,
                        builder: (context, state) => ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.typeAccount.length,
                          separatorBuilder: (context, index) => SizedBox(
                            width: 12.h,
                          ),
                          itemBuilder: (context, index) => RadioTypeAccount(
                            callback: () => cubit.changeRequest(
                                type: state.typeAccount[index].value),
                            filterResponse: state.typeAccount[index],
                            value: state.type,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: AppButton(
            title: "Đăng ký",
            color: AppColors.blue,
            contentPadding: EdgeInsets.symmetric(vertical: 12.h),
            textStyle: AppTextStyle.textSm.copyWith(color: AppColors.white),
            radius: 12.r,
            onPressed: () => cubit.createAccount(),
          ),
        ),
      ),
    );
  }
}
