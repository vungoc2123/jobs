import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../application/constants/app_color.dart';
import '../../application/constants/app_text_style.dart';

class AppSeeMore extends StatefulWidget {
  const AppSeeMore({
    super.key,
    this.title,
    this.html,
    this.paddingHorizon,
    this.paddingVertical,
  });

  final String? title;
  final String? html;
  final double? paddingHorizon;
  final double? paddingVertical;

  @override
  State<AppSeeMore> createState() => _AppSeeMoreState();
}

class _AppSeeMoreState extends State<AppSeeMore> {
  late ValueNotifier<bool> isExpanded;
  final double collapsedHeight = 85.h;
  late bool _shouldShowButton;
  late final String content;

  @override
  void initState() {
    super.initState();
    isExpanded = ValueNotifier(false);
    _shouldShowButton = false;
    content = _cleanHtml(widget.html ?? '').trim();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkContentHeight();
    });
  }

  @override
  void dispose() {
    isExpanded.dispose();
    super.dispose();
  }

  String _cleanHtml(String html) {
    String cleanedHtml = html
        .replaceAll(RegExp(r'<p>\s*(\r\n)*\s*</p>'), '')
        .replaceAll(RegExp(r'(\r\n)+'), '');
    cleanedHtml = cleanedHtml.trim();
    return cleanedHtml;
  }

  int countLines(String text) {
    int lineBreaks = RegExp(r'\r?\n').allMatches(text).length;
    return lineBreaks;
  }

  void _checkContentHeight() {
    int line = countLines(widget.html ?? '');
    setState(() {
      _shouldShowButton = line > 3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: widget.paddingHorizon ?? 0,
        vertical: widget.paddingVertical ?? 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null && widget.title!.isNotEmpty)
            Text(
              widget.title!,
              style:
                  AppTextStyle.textBase.copyWith(fontWeight: FontWeight.w600),
            ),
          ValueListenableBuilder<bool>(
            valueListenable: isExpanded,
            builder: (context, value, child) {
              return Column(
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: _shouldShowButton && !value
                          ? collapsedHeight
                          : double.infinity,
                    ),
                    child: Html(
                      data: content,
                      style: {
                        "body": Style(
                          fontSize: FontSize(14.sp),
                          textAlign: TextAlign.justify,
                        ),
                      },
                    ),
                  ),
                  if (_shouldShowButton) ...[
                    SizedBox(height: 8.h),
                    GestureDetector(
                      onTap: () {
                        isExpanded.value = !isExpanded.value;
                      },
                      child: Container(
                        width: 1.sw,
                        padding: EdgeInsets.symmetric(vertical: 4.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: const Color(0xffD6D6D6)),
                        ),
                        child: Text(
                          value ? 'Ẩn bớt' : 'Xem chi tiết',
                          textAlign: TextAlign.center,
                          style: AppTextStyle.textSm
                              .copyWith(color: AppColors.blueEA),
                        ),
                      ),
                    ),
                  ],
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
