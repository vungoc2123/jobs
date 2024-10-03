import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/presentation/screens/discover/discover_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/discover/widget/news_group.dart';
import 'package:phu_tho_mobile/presentation/screens/news/bloc/news_common_cubit.dart';

import '../../../application/enums/path_news.dart';
import '../../common_widgets/appbar_gradient_widget.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  late DiscoverCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<DiscoverCubit>(context);
    cubit.checkPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.greyFB,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: GradientAppBar(
            title: "Tin tức",
          ),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          padding: EdgeInsets.only(left: 12.w,right: 12.w, top: 8.h, bottom: 40.h),
          child: Column(
            children: [
              BlocProvider(
                  create: (_) => NewsCommonCubit(),
                  child: const NewsGroup(path: NewsPath.advise)),
              SizedBox(
                height: 12.h,
              ),
              BlocProvider(
                create: (_) => NewsCommonCubit(),
                child: const NewsGroup(path: NewsPath.employmentStatus),
              ),
              SizedBox(
                height: 12.h,
              ),
              BlocProvider(
                  create: (_) => NewsCommonCubit(),
                  child: const NewsGroup(path: NewsPath.findingPeople)),
              SizedBox(
                height: 12.h,
              ),
              BlocProvider(
                create: (_) => NewsCommonCubit(),
                child: const NewsGroup(path: NewsPath.forecast),
              ),
              SizedBox(
                height: 12.h,
              ),
              BlocProvider(
                create: (_) => NewsCommonCubit(),
                child: const NewsGroup(path: NewsPath.introduction),
              ),
              SizedBox(
                height: 12.h,
              ),
              BlocProvider(
                  create: (_) => NewsCommonCubit(),
                  child: const NewsGroup(path: NewsPath.jobSeekers)),
              SizedBox(
                height: 12.h,
              ),
              BlocProvider(
                  create: (_) => NewsCommonCubit(),
                  child: const NewsGroup(path: NewsPath.supply)),
            ],
          ),
        )));
  }

// Widget rowItem({required String name, VoidCallback? callback}) {
//   return InkWell(
//     borderRadius: BorderRadius.circular(16.w),
//     onTap: () => callback?.call(),
//     child: Ink(
//       padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(16.w), color: AppColors.white),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Expanded(
//             child: Text(
//               name,
//               style: AppTextStyle.textSm.copyWith(
//                 color: AppColors.textPrimary,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//           SizedBox(width: 8.w),
//           const Icon(Icons.chevron_right),
//         ],
//       ),
//     ),
//   );
// }
}
