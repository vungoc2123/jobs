import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/domain/models/argument/in_app_web_view_argument.dart';
import 'package:phu_tho_mobile/gen/assets.gen.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_bottom_sheet.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_loading_indicator.dart';
import 'package:phu_tho_mobile/presentation/screens/list_job/widget/gradian_appbar.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:image/image.dart' as image;
import 'package:image_picker/image_picker.dart' as image_picker;
import 'package:webview_flutter_android/webview_flutter_android.dart' as webview_flutter_android;

class InAppWebViewScreen extends StatefulWidget {
  final InAppWebViewArgument argument;

  const InAppWebViewScreen({super.key, required this.argument});

  @override
  State<InAppWebViewScreen> createState() => _InAppWebViewScreenState();
}

class _InAppWebViewScreenState extends State<InAppWebViewScreen> {
  late WebViewController controller;
  late ValueNotifier<bool> isLoadingWeb;

  @override
  void initState() {
    super.initState();
    isLoadingWeb = ValueNotifier(true);
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {
            isLoadingWeb.value = true;
          },
          onPageFinished: (String url) {
            isLoadingWeb.value = false;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.argument.stringUrl));

    if (Platform.isAndroid) {
      final androidController = (controller.platform as webview_flutter_android.AndroidWebViewController);
      androidController.setOnShowFileSelector((params) async {
        final res = await AppBottomSheet.showBottomSheet(
          context,
          isScroll: false,
          child: Container(
            padding: EdgeInsets.only(top: 12.r, bottom: 30.r, right: 12.r, left: 12.r),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(12.r), topLeft: Radius.circular(12.r))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Bạn muốn chọn ảnh từ",
                  style: AppTextStyle.textSm.copyWith(fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 20.h,
                ),
                InkWell(
                  onTap: () async {
                    final data = await _androidFilePicker(params, source: image_picker.ImageSource.camera);
                    if (mounted) {
                      Navigator.of(context).pop(data);
                    }
                  },
                  child: Row(
                    children: [
                      Assets.icons.icCamera.svg(colorFilter: const ColorFilter.mode(AppColors.grey52, BlendMode.srcIn)),
                      SizedBox(
                        width: 8.w,
                      ),
                      Text(
                        'Chụp ảnh',
                        style: AppTextStyle.textSm.copyWith(fontWeight: FontWeight.w500, color: AppColors.grey52),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: AppColors.greyF6,
                ),
                InkWell(
                  onTap: () async {
                    final data = await _androidFilePicker(params, source: image_picker.ImageSource.gallery);
                    if (mounted) {
                      Navigator.of(context).pop(data);
                    }
                  },
                  child: Row(
                    children: [
                      Assets.icons.icGallery
                          .svg(colorFilter: const ColorFilter.mode(AppColors.grey52, BlendMode.srcIn)),
                      SizedBox(
                        width: 8.w,
                      ),
                      Text(
                        'Chọn ảnh từ thư viện',
                        style: AppTextStyle.textSm.copyWith(fontWeight: FontWeight.w500, color: AppColors.grey52),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
        return res ?? [];
      });
    }
  }

  Future<List<String>> _androidFilePicker(
    webview_flutter_android.FileSelectorParams params, {
    required image_picker.ImageSource source,
  }) async {
    final picker = image_picker.ImagePicker();
    final photo = await picker.pickImage(source: source);

    if (photo == null) {
      return [];
    }

    final imageData = await photo.readAsBytes();
    final decodedImage = image.decodeImage(imageData)!;
    final scaledImage = image.copyResize(decodedImage, width: 500);
    final jpg = image.encodeJpg(scaledImage, quality: 90);

    final filePath = (await getTemporaryDirectory()).uri.resolve(
          './image_${DateTime.now().microsecondsSinceEpoch}.jpg',
        );
    final file = await File.fromUri(filePath).create(recursive: true);
    await file.writeAsBytes(jpg, flush: true);

    return [file.uri.toString()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: GradientAppBar(
        isOpenSearch: false,
        title: Text(
          widget.argument.label,
          style: AppTextStyle.textBase.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        gradient: const LinearGradient(
          colors: [AppColors.blue44, AppColors.blueF8],
          begin: Alignment.topLeft,
          end: Alignment.topRight,
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: isLoadingWeb,
        builder: (context,value,_){
          if(value){
            return const AppLoadingIndicator();
          }
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.all(8.r),
              child: WebViewWidget(
                controller: controller,
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () async {
                final canGoBack = await controller.canGoBack();
                if (canGoBack) {
                  controller.goBack();
                }
              },
              icon: const Icon(
                Icons.arrow_back,
              ),
            ),
            IconButton(
                onPressed: () async {
                  final canGoForward = await controller.canGoForward();
                  if (canGoForward) {
                    controller.goForward();
                  }
                },
                icon: const Icon(Icons.arrow_forward)),
          ],
        ),
      ),
    );
  }
}
