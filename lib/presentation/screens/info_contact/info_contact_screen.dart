import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_loading_indicator.dart';
import 'package:phu_tho_mobile/presentation/screens/info_contact/info_contact_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/info_contact/info_contact_state.dart';
import 'package:phu_tho_mobile/presentation/screens/list_job/widget/gradian_appbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InfoContactScreen extends StatefulWidget {
  const InfoContactScreen({super.key});

  @override
  State<InfoContactScreen> createState() => _InfoContactScreenState();
}

class _InfoContactScreenState extends State<InfoContactScreen> {
  late WebViewController controller;
  late InfoContactCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<InfoContactCubit>(context);
    _cubit.getInfoContact();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        isOpenSearch: false,
        title: Text(
          tr('informationContact'),
          style: AppTextStyle.textBase
              .copyWith(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        gradient: const LinearGradient(
            colors: [AppColors.blue44, AppColors.blueF8],
            begin: Alignment.topLeft,
            end: Alignment.topRight),
      ),
      body: BlocBuilder<InfoContactCubit, InfoContactState>(
        builder: (context, state) {
          if (state.loadStatus == LoadStatus.failure) {
            return const Center(
              child: Text("Error"),
            );
          }
          if (state.loadStatus == LoadStatus.success) {
            controller = WebViewController()
              ..setJavaScriptMode(JavaScriptMode.unrestricted)
              ..setNavigationDelegate(
                NavigationDelegate(
                  onProgress: (int progress) {
                  },
                ),
              )
              ..loadHtmlString(state.infoContactResponse.getIframe());
            return SingleChildScrollView(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  rowInfo("Tên:", state.infoContactResponse.name),
                  SizedBox(
                    height: 8.h,
                  ),
                  rowInfo("Email:", state.infoContactResponse.email),
                  SizedBox(
                    height: 8.h,
                  ),
                  rowInfo("Liên lạc:", state.infoContactResponse.phone),
                  SizedBox(
                    height: 8.h,
                  ),
                  rowInfo("Địa chỉ:", state.infoContactResponse.address),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    "Bản đồ:",
                    style: AppTextStyle.textSm.copyWith(
                        color: AppColors.grey52, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  SizedBox(
                      width: 1.sw,
                      height: 400.h,
                      child: WebViewWidget(controller: controller))
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

  Widget rowInfo(String label, String? value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.textSm
              .copyWith(color: AppColors.grey52, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          width: 8.w,
        ),
        Expanded(
            child: Text((value == null || value == "") ? tr("noInfo") : value,
                style: AppTextStyle.textSm.copyWith(
                    color: AppColors.grey52, fontWeight: FontWeight.w400)))
      ],
    );
  }
}
