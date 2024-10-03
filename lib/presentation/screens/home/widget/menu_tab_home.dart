import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_deep_link.dart';
import 'package:phu_tho_mobile/application/enums/type_action.dart';
import 'package:phu_tho_mobile/application/enums/type_industrial_park.dart';
import 'package:phu_tho_mobile/application/extentions/string_extension.dart';
import 'package:phu_tho_mobile/domain/models/argument/in_app_web_view_argument.dart';
import 'package:phu_tho_mobile/domain/models/argument/list_job_argument.dart';
import 'package:phu_tho_mobile/gen/assets.gen.dart';
import 'package:phu_tho_mobile/presentation/routes/route_name.dart';
import 'package:phu_tho_mobile/presentation/screens/home/widget/item_menu_home.dart';

class MenuTabHome extends StatefulWidget {
  const MenuTabHome({super.key});

  @override
  State<MenuTabHome> createState() => _MenuTabHomeState();
}

class _MenuTabHomeState extends State<MenuTabHome> {
  late List<Widget> itemMenu;

  @override
  void initState() {
    super.initState();
    itemMenu = [
      ItemMenuHome(
          label: "Việc tìm người",
          iconPath: Assets.icons.icBagSecond.path,
          onPressed: () {
            Navigator.of(context).pushNamed(RouteName.listJob,
                arguments:
                    const ListJobArgument(typeAction: TypeAction.extract));
          },
          visible: true),
      ItemMenuHome(
          label: "Người tìm việc",
          iconPath: Assets.icons.icMutilUser.path,
          onPressed: () {
            Navigator.of(context).pushNamed(RouteName.listCandidate);
          },
          visible: true),
      // ItemMenuHome(
      //     label: "Bảo hiểm thất nghiệp",
      //     iconPath: Assets.icons.icInsurance.path,
      //     onPressed: () {},
      //     visible: true),
      // ItemMenuHome(
      //     label: "Kết quả khảo sát",
      //     iconPath: Assets.icons.icEmail.path,
      //     onPressed: () async {
      //       final url =
      //           await AppDeepLink.survey.toResourceUrl().withUserToken();
      //       if (mounted) {
      //         Navigator.of(context).pushNamed(RouteName.inAppWebView,
      //             arguments:
      //                 InAppWebViewArgument(label: "Khảo sát", stringUrl: url));
      //       }
      //     },
      //     visible: true),
      ItemMenuHome(
          label: "Tư vấn việc làm",
          iconPath: Assets.icons.icInterview.path,
          onPressed: () {
            Navigator.pushNamed(context, RouteName.consulting);
          },
          visible: true),
      ItemMenuHome(
          label: "Khu công nghiệp",
          iconPath: Assets.icons.icHomeBold.path,
          onPressed: () {
            Navigator.pushNamed(context, RouteName.industrialPark,
                arguments: TypeIndustrialPark.industrialPark);
          },
          visible: true),
      ItemMenuHome(
          label: "Giao lưu trực tuyến",
          iconPath: Assets.icons.icMessageBold.path,
          onPressed: () {
            Navigator.pushNamed(context, RouteName.communication);
          },
          visible: true),
      ItemMenuHome(
          label: "Khảo sát\n",
          iconPath: Assets.icons.icFeedBack.path,
          onPressed: () async {
            final url =
                await AppDeepLink.survey.toResourceUrl().withUserToken();
            if (mounted) {
              Navigator.of(context).pushNamed(RouteName.inAppWebView,
                  arguments:
                      InAppWebViewArgument(label: "Khảo sát", stringUrl: url));
            }
          },
          visible: true),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          // border:
          //     Border.all(color: AppColors.blue.withOpacity(0.5), width: 0.5),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(100, 100, 111, 0.2),
              blurRadius: 29,
              spreadRadius: 0,
              offset: Offset(
                0,
                7,
              ),
            ),
          ]),
      child: Wrap(
        spacing: 16.w,
        runSpacing: 16.w,
        children: List.generate(itemMenu.length, (index) => itemMenu[index]),
      ),
    );
  }
}
