import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/application/enums/gender.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/application/extentions/gender_extension.dart';
import 'package:phu_tho_mobile/application/extentions/string_extension.dart';
import 'package:phu_tho_mobile/application/utils/validator.dart';
import 'package:phu_tho_mobile/domain/models/request/edit_information/edit_information_request.dart';
import 'package:phu_tho_mobile/domain/models/response/user/user_profile_response.dart';
import 'package:phu_tho_mobile/gen/assets.gen.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_button.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_label_text_field.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_loading.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_toast.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/appbar_gradient_widget.dart';
import 'package:phu_tho_mobile/presentation/screens/account/edit_information/edit_infomation_state.dart';
import 'package:phu_tho_mobile/presentation/screens/account/edit_information/edit_information_cubit.dart';

class EditInformationScreen extends StatefulWidget {
  final UserProfileResponse user;

  const EditInformationScreen({super.key, required this.user});

  @override
  State<EditInformationScreen> createState() => _EditInformationScreenState();
}

class _EditInformationScreenState extends State<EditInformationScreen> {
  late EditInformationCubit _cubit;
  var isChanged = false;
  late ValueNotifier<bool> changeInfo;
  late ValueNotifier<bool> validatePhoneNumber;
  late ValueNotifier<bool> validateEmail;

  @override
  void initState() {
    super.initState();
    changeInfo = ValueNotifier(false);
    validatePhoneNumber = ValueNotifier(true);
    validateEmail = ValueNotifier(true);
    _cubit = BlocProvider.of<EditInformationCubit>(context);
    _cubit.onChangeRequest(EditInformationRequest(
        id: widget.user.id,
        fullName: widget.user.fullName,
        birthDay: widget.user.birthDay,
        address: widget.user.address,
        email: widget.user.email,
        phoneNumber: widget.user.phoneNumber,
        gender: widget.user.gender));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyFB,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: GradientAppBar(
          title: 'Chỉnh sửa thông tin cá nhân',
          leading: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
          ),
          leadingAction: () {
            Navigator.of(context).pop(isChanged);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12.r),
        child: BlocConsumer<EditInformationCubit, EditInformationState>(
          buildWhen: (previous, current) => previous.request != current.request,
          listenWhen: (previous, current) =>
              previous.loadStatus != current.loadStatus,
          listener: (context, state) {
            if (state.loadStatus == LoadStatus.success) {
              Navigator.of(context).pop();
              AppToast.showToastSuccess(context, title: state.message);
              isChanged = true;
            }
            if (state.loadStatus == LoadStatus.loading) {
              showDialog(
                  context: context,
                  builder: (context) => const AppLoading(),
                  barrierDismissible: false);
            }
            if (state.loadStatus == LoadStatus.failure) {
              Navigator.of(context).pop();
              AppToast.showToastError(context, title: state.message);
            }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Họ tên",
                  style: AppTextStyle.textSm.copyWith(
                      fontWeight: FontWeight.w600, color: AppColors.grey52),
                ),
                SizedBox(
                  height: 8.h,
                ),
                CustomLabelTextField(
                  radius: 12.r,
                  maxLine: 1,
                  defaultValue: _cubit.state.request.fullName,
                  onChanged: (value) {
                    if (_cubit.state.request.fullName != value) {
                      _cubit.onChangeRequest(
                          _cubit.state.request.copyWith(fullName: value));
                      changeInfo.value = true;
                    }
                  },
                  errorMessage: _cubit.state.request.fullName.trim().isEmpty
                      ? "Tên không được để trống"
                      : "",
                  colorBorder: _cubit.state.request.fullName.trim().isEmpty
                      ? Colors.red
                      : AppColors.greyAE,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  textStyleHint: AppTextStyle.textSm.copyWith(
                      fontWeight: FontWeight.w500, color: AppColors.grey72),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  "Email",
                  style: AppTextStyle.textSm.copyWith(
                      fontWeight: FontWeight.w600, color: AppColors.grey52),
                ),
                SizedBox(
                  height: 8.h,
                ),
                ValueListenableBuilder(
                  valueListenable: validateEmail,
                  builder: (context, valueValidateEmail, _) {
                    return CustomLabelTextField(
                      radius: 12.r,
                      maxLine: 1,
                      defaultValue: _cubit.state.request.email,
                      onChanged: (value) {
                        if (_cubit.state.request.email != value) {
                          _cubit.onChangeRequest(
                              _cubit.state.request.copyWith(email: value));
                          changeInfo.value = true;
                        }
                      },
                      errorMessage: !validateEmail.value
                          ? "Email không đúng định dạng"
                          : '',
                      colorBorder:
                          !validateEmail.value ? Colors.red : AppColors.greyAE,
                      prefixIcon: Assets.icons.icEmail.svg(
                          width: 18.r,
                          height: 18.r,
                          colorFilter: const ColorFilter.mode(
                              AppColors.greyAE, BlendMode.srcIn)),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 12.w, vertical: 12.h),
                      textStyleHint: AppTextStyle.textSm.copyWith(
                          fontWeight: FontWeight.w500, color: AppColors.grey72),
                    );
                  },
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  "Điện thoại",
                  style: AppTextStyle.textSm.copyWith(
                      fontWeight: FontWeight.w600, color: AppColors.grey52),
                ),
                SizedBox(
                  height: 8.h,
                ),
                ValueListenableBuilder(
                  valueListenable: validatePhoneNumber,
                  builder: (context, valueValidate, _) {
                    return CustomLabelTextField(
                      radius: 12.r,
                      maxLength: 10,
                      defaultValue: _cubit.state.request.phoneNumber,
                      onChanged: (valuePhone) {
                        if (_cubit.state.request.phoneNumber != valuePhone) {
                          _cubit.onChangeRequest(_cubit.state.request
                              .copyWith(phoneNumber: valuePhone));
                          changeInfo.value = true;
                        }
                      },
                      colorBorder: !validatePhoneNumber.value
                          ? Colors.red
                          : AppColors.greyAE,
                      maxLine: 1,
                      errorMessage: !validatePhoneNumber.value
                          ? "Số điện thoại không đúng định dạng"
                          : '',
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      prefixIcon: Assets.icons.icTelephone.svg(
                          width: 18.r,
                          height: 18.r,
                          colorFilter: const ColorFilter.mode(
                              AppColors.greyAE, BlendMode.srcIn)),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 12.w, vertical: 12.h),
                      textStyleHint: AppTextStyle.textSm.copyWith(
                          fontWeight: FontWeight.w500, color: AppColors.grey72),
                    );
                  },
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  "Ngày sinh",
                  style: AppTextStyle.textSm.copyWith(
                      fontWeight: FontWeight.w600, color: AppColors.grey52),
                ),
                SizedBox(
                  height: 8.h,
                ),
                InkWell(
                  onTap: () async {
                    final DateTime? selectDay = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(3000),
                    );
                    if (selectDay != null) {
                      _cubit.onChangeRequest(_cubit.state.request.copyWith(
                          birthDay: selectDay
                              .add(const Duration(hours: 7))
                              .toUtc()
                              .toIso8601String()));
                      changeInfo.value = true;
                    }
                  },
                  borderRadius: BorderRadius.circular(12.r),
                  child: CustomLabelTextField(
                    radius: 12.r,
                    enable: false,
                    defaultValue: _cubit.state.request.birthDay.isEmpty
                        ? tr("noInfo")
                        : _cubit.state.request.birthDay.formatToDMY(),
                    onChanged: (value) {},
                    colorBorder: AppColors.greyAE,
                    prefixIcon: Assets.icons.icCalendar.svg(
                        colorFilter: const ColorFilter.mode(
                            AppColors.greyAE, BlendMode.srcIn)),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                    textStyleHint: AppTextStyle.textSm.copyWith(
                        fontWeight: FontWeight.w500, color: AppColors.grey72),
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Row(
                  children: [
                    Text(
                      "Giới tính",
                      style: AppTextStyle.textSm.copyWith(
                          fontWeight: FontWeight.w600, color: AppColors.grey52),
                    ),
                    SizedBox(
                      width: 30.w,
                    ),
                    Row(
                      children: [
                        optionGender(Gender.men,
                            _cubit.state.request.gender == Gender.men.getValue,
                            () {
                          if (_cubit.state.request.gender !=
                              Gender.men.getValue) {
                            _cubit.onChangeRequest(_cubit.state.request
                                .copyWith(gender: Gender.men.getValue));
                            changeInfo.value = true;
                          }
                        }),
                        SizedBox(
                          width: 30.w,
                        ),
                        optionGender(
                            Gender.woman,
                            _cubit.state.request.gender ==
                                Gender.woman.getValue, () {
                          if (_cubit.state.request.gender !=
                              Gender.woman.getValue) {
                            _cubit.onChangeRequest(_cubit.state.request
                                .copyWith(gender: Gender.woman.getValue));
                            changeInfo.value = true;
                          }
                        }),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  "Địa chỉ",
                  style: AppTextStyle.textSm.copyWith(
                      fontWeight: FontWeight.w600, color: AppColors.grey52),
                ),
                SizedBox(
                  height: 8.h,
                ),
                CustomLabelTextField(
                  radius: 12.r,
                  defaultValue: _cubit.state.request.address,
                  onChanged: (value) {
                    if (_cubit.state.request.address != value) {
                      _cubit.onChangeRequest(
                          _cubit.state.request.copyWith(address: value));
                      changeInfo.value = true;
                    }
                  },
                  colorBorder: AppColors.greyAE,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  textStyleHint: AppTextStyle.textSm.copyWith(
                      fontWeight: FontWeight.w500, color: AppColors.grey72),
                ),
                SizedBox(
                  height: 20.h,
                ),
                ValueListenableBuilder(
                  valueListenable: changeInfo,
                  builder: (context, value, _) {
                    return AppButton(
                      title: "Cập nhập thông tin",
                      color: AppColors.blue,
                      onPressed: () {
                        validatePhoneNumber.value =
                            AppValidator.validatePhoneNumber(
                                _cubit.state.request.phoneNumber);
                        validateEmail.value = AppValidator.validateEmail(
                            _cubit.state.request.email);
                        if (_cubit.state.request.fullName.isNotEmpty &&
                            validateEmail.value == true &&
                            validatePhoneNumber.value == true) {
                          _cubit.updateInformation();
                        }
                      },
                      isEnable: value,
                      contentPadding: EdgeInsets.symmetric(vertical: 8.h),
                      radius: 12.r,
                      textStyle: AppTextStyle.textSm.copyWith(
                          fontWeight: FontWeight.w600, color: Colors.white),
                    );
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget optionGender(Gender gender, bool selected, VoidCallback onPressed) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: () {
        onPressed.call();
      },
      child: Row(
        children: [
          selected
              ? Assets.icons.icCheckRadio.svg()
              : Assets.icons.icUnCheckRadio.svg(),
          SizedBox(
            width: 12.w,
          ),
          Text(
            gender.getName,
            style: AppTextStyle.textSm
                .copyWith(fontWeight: FontWeight.w500, color: AppColors.grey52),
          )
        ],
      ),
    );
  }
}
