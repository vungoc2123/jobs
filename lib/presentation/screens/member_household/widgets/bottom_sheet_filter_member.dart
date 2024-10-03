import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/domain/models/common/item_filter.dart';
import 'package:phu_tho_mobile/gen/assets.gen.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_label_text_field.dart';

class BottomSheetFilterMember extends StatefulWidget {
  const BottomSheetFilterMember(
      {super.key,
        required this.valueDefault,
        required this.title,
        required this.list,
        this.onChange,
        this.icon,
        this.searching = false});

  final String title;
  final String valueDefault;
  final List<ItemFilter> list;
  final Function(ItemFilter values)? onChange;
  final String? icon;
  final bool searching;

  @override
  State<BottomSheetFilterMember> createState() => _BottomSheetFilterMemberState();
}

class _BottomSheetFilterMemberState extends State<BottomSheetFilterMember> {
  late ValueNotifier<List<ItemFilter>> searchFilters;
  late String textSearching='';

  @override
  void initState() {
    super.initState();
    searchFilters = ValueNotifier(widget.list);
  }


  @override
  void didUpdateWidget(covariant BottomSheetFilterMember oldWidget) {
    super.didUpdateWidget(oldWidget);
    searchFilters = ValueNotifier(widget.list);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(16.r),
          topLeft: Radius.circular(16.r)),
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
                      widget.title,
                      style: AppTextStyle.textBase.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600),
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
            const Divider(
              color: AppColors.greyE5,
            ),
            if (widget.searching)
              Padding(
                padding: EdgeInsets.all(12.r),
                child: CustomLabelTextField(
                  hintText: "Nhập tên...",
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 8.h, horizontal: 20),
                  radius: 12.r,
                  colorBorder: AppColors.greyDF,
                  textStyleHint: AppTextStyle.textSm,
                  defaultValue: textSearching,
                  maxLine: 1,
                  onSubmit: (value) {
                    textSearching=value;
                    searchFilters.value = widget.list
                        .where((e) => e
                        .getTitle().toLowerCase()
                        .contains(value.toLowerCase()))
                        .toList();
                  },
                  prefixIcon: Assets.icons.search.svg(
                      width: 16.r,
                      height: 16.r,
                      colorFilter: const ColorFilter.mode(
                          AppColors.grey, BlendMode.srcIn)),
                  // suffixIcon: GestureDetector(
                  //   onTap: () {
                  //     searchFilters.value = widget.list;
                  //   },
                  //   child: Assets.icons.icCloseRound
                  //       .svg(width: 16.r, height: 16.r),
                  // ),
                ),
              ),
            Flexible(
              fit: widget.searching ? FlexFit.tight : FlexFit.loose,
              child: ValueListenableBuilder(
                valueListenable: searchFilters,
                builder: (context, value, child) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: searchFilters.value.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          widget.onChange
                              ?.call(searchFilters.value[index]);
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 8.h),
                          child: Row(
                            children: [
                              Container(
                                width: 24.r,
                                height: 24.r,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: widget.valueDefault ==
                                        searchFilters.value[index]
                                            .getValues()
                                        ? AppColors.blueF8
                                        : AppColors.white,
                                    borderRadius:
                                    BorderRadius.circular(12.r),
                                    border: Border.all(
                                        color: widget.valueDefault ==
                                            searchFilters
                                                .value[index]
                                                .getValues()
                                            ? AppColors.blueF8
                                            : AppColors.greyCC)),
                                child: Assets.icons.check.svg(
                                  width: 12.r,
                                  height: 12.r,
                                  colorFilter: const ColorFilter.mode(
                                      AppColors.white,
                                      BlendMode.srcIn),
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Flexible(
                                child: Text(
                                  searchFilters.value[index]
                                      .getTitle(),
                                  style: AppTextStyle.textSm.copyWith(
                                      color: AppColors.grey4D),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
