import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_bottom_sheet.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_button.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_dialog.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_loading.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_toast.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/row_infomation_widget.dart';
import 'package:phu_tho_mobile/presentation/routes/route_name.dart';
import 'package:phu_tho_mobile/presentation/screens/account/qr_scanner/qr_scanner_cubit.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  late QrScannerCubit _cubit;
  QRViewController? _qrViewController;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
  }

  String convertDate(String dateString) {
    int day = int.parse(dateString.substring(0, 2));
    int month = int.parse(dateString.substring(2, 4));
    int year = int.parse(dateString.substring(4));

    return '$day/$month/$year';
  }

  bool validateCCCD(String cccd) {
    if (cccd.length != 12) return false;

    if (!cccd.contains(RegExp(r'^[0-9]+$'))) return false;

    return true;
  }

  void executeScanQR(QRViewController qrViewController) {
    _qrViewController = qrViewController;
    qrViewController.scannedDataStream.listen(
      (scanData) async {
        if (scanData.code?.isEmpty ?? true) return;

        if (_cubit.state.qrCode == scanData.code) return;

        _cubit.onChangeQrCode(scanData.code ?? '');

        if (_cubit.state.qrCode.isNotEmpty) {
          final data = _cubit.state.qrCode.split('|');

          if(!validateCCCD(data.first)){
            await AppDialog.showDialogConfirm(
              context,
              label: 'Mã QR không hợp lệ',
              onConfirm: () => Navigator.of(context).pop(),
            );
            _cubit.resetQrCode();
            return;
          }

          await AppBottomSheet.showBottomSheet(
            context,
            isScroll: true,
            child: ClipRRect(
              borderRadius: BorderRadius.only(topRight: Radius.circular(16.r), topLeft: Radius.circular(16.r)),
              child: Container(
                color: AppColors.white,
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20.r,
                          ),
                          Expanded(
                            child: Text(
                              tr('information'),
                              style: AppTextStyle.textBase.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.of(context).pop(),
                            borderRadius: BorderRadius.circular(10.r),
                            child: Icon(
                              Icons.close,
                              size: 20.r,
                            ),
                          )
                        ],
                      ),
                    ),
                    const Divider(color: AppColors.greyE5),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 16.w,
                        top: 12.h,
                        right: 16.w,
                        bottom: MediaQuery.of(context).viewPadding.bottom > 0
                            ? MediaQuery.of(context).viewPadding.bottom
                            : 16.h,
                      ),
                      child: Column(
                        children: [
                          RowInformationWidget(
                            label: 'Số CCCD',
                            value: data.elementAtOrNull(0) ?? 'Chưa có thông tin',
                          ),
                          Divider(height: 30.h, color: AppColors.greyF6),
                          RowInformationWidget(
                            label: 'Họ và tên',
                            value: data.elementAtOrNull(2) ?? 'Chưa có thông tin',
                          ),
                          Divider(height: 30.h, color: AppColors.greyF6),
                          RowInformationWidget(
                            label: 'Ngày sinh',
                            value: data.elementAtOrNull(6) != null
                                ? convertDate(data.elementAtOrNull(3)!)
                                : 'Chưa có thông tin',
                          ),
                          Divider(height: 30.h, color: AppColors.greyF6),
                          RowInformationWidget(
                            label: 'Giới tính',
                            value: data.elementAtOrNull(4) ?? 'Chưa có thông tin',
                          ),
                          Divider(height: 30.h, color: AppColors.greyF6),
                          RowInformationWidget(
                            label: 'Nơi thường trú',
                            value: data.elementAtOrNull(5) ?? 'Chưa có thông tin',
                          ),
                          Divider(height: 30.h, color: AppColors.greyF6),
                          RowInformationWidget(
                            label: 'Ngày cấp CCCD',
                            value: data.elementAtOrNull(6) != null
                                ? convertDate(data.elementAtOrNull(6)!)
                                : 'Chưa có thông tin',
                          ),
                          SizedBox(height: 16.h),
                          AppButton(
                            title: 'Xác nhận',
                            textStyle: AppTextStyle.textSm.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.white,
                            ),
                            color: AppColors.blue,
                            contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                            radius: 8.r,
                            onPressed: () => _cubit.validateAccountByQrCode(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
          _cubit.resetQrCode();
        }
      },
    );
  }

  @override
  void dispose() {
    _qrViewController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<QrScannerCubit, QrScannerState>(
      listenWhen: (prev, curr) => prev.loadStatus != curr.loadStatus,
      listener: (_, state) async {
        if (state.loadStatus == LoadStatus.loading) {
          showDialog(
            context: context,
            builder: (_) => const AppLoading(),
            barrierDismissible: false,
          );
        }

        if (state.loadStatus == LoadStatus.success) {
          Navigator.of(context).popUntil((route) => route.settings.name == RouteName.homeTab);
          AppToast.showToastSuccess(context, title: state.message);
        }

        if (state.loadStatus == LoadStatus.failure) {
          Navigator.of(context).popUntil((route) => route.settings.name == RouteName.qrScanner);
          AppToast.showToastError(context, title: state.message);
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            tr('qrScanner'),
            style: AppTextStyle.textBase.copyWith(fontWeight: FontWeight.w700, color: Colors.white),
          ),
          centerTitle: true,
          automaticallyImplyLeading: true,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            QRView(
              key: GlobalKey(),
              overlay: QrScannerOverlayShape(
                borderColor: AppColors.blue,
                borderWidth: 8.r,
                borderRadius: 8.r,
                borderLength: 20.r,
                cutOutHeight: 200.r,
                cutOutWidth: 200.r,
              ),
              onQRViewCreated: executeScanQR,
            ),
          ],
        ),
      ),
    );
  }
}
