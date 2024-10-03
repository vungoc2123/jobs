import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/enums/type_action.dart';
import 'package:phu_tho_mobile/application/utils/app_utils.dart';
import 'package:phu_tho_mobile/gen/assets.gen.dart';
import 'package:phu_tho_mobile/presentation/screens/account/account_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/account/account_screen.dart';
import 'package:phu_tho_mobile/presentation/screens/business/list_business/business_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/business/list_business/business_screen.dart';
import 'package:phu_tho_mobile/presentation/screens/discover/discover_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/discover/discover_screen.dart';
import 'package:phu_tho_mobile/presentation/screens/home/bloc/home_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/home/home_screen.dart';
import 'package:phu_tho_mobile/presentation/screens/home_tab/widget/bottom_bar_widget.dart';
import 'package:phu_tho_mobile/presentation/screens/search/search_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/search/search_screen.dart';

class HomePageModel {
  final String name;
  final String iconUrl;
  final Widget child;

  const HomePageModel({
    required this.name,
    required this.iconUrl,
    required this.child,
  });
}

class HomeTabArguments {
  final int index;

  const HomeTabArguments({required this.index});
}

class HomeTab extends StatefulWidget {
  final HomeTabArguments arguments;

  const HomeTab({super.key, required this.arguments});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late PageController controller;
  late ValueNotifier<int> currentIndex;

  final List<HomePageModel> listPages = [
    HomePageModel(
      name: tr("home"),
      iconUrl: Assets.icons.houseChimney.path,
      child: BlocProvider(
          create: (context) => HomeCubit(), child: const HomeScreen()),
    ),
    HomePageModel(
      name: tr("company"),
      iconUrl: Assets.icons.bank.path,
      child: BlocProvider(
          create: (context) => BusinessCubit(),
          child: const BusinessScreen(
            type: TypeAction.extract,
          )),
    ),
    HomePageModel(
      name: tr("explore"),
      iconUrl: Assets.icons.search.path,
      child: BlocProvider(
        create:(context) => SearchCubit(),
        child: const SearchScreen(),
      ),
    ),
    HomePageModel(
      name: "Tin tức",
      iconUrl: Assets.icons.document.path,
      child: BlocProvider(
        create: (_) => DiscoverCubit() ,
        child: const DiscoverScreen(),
      ),
    ),
    HomePageModel(
      name: tr("account"),
      iconUrl: Assets.icons.user.path,
      child: BlocProvider(
        create: (context) => AccountCubit(),
        child: const AccountScreen(),
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    currentIndex = ValueNotifier<int>(widget.arguments.index);
    controller = PageController(initialPage: widget.arguments.index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller,
              children: listPages
                  .map((item) =>
                      SafeArea(top: false, bottom: false, child: item.child))
                  .toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: ValueListenableBuilder(
        valueListenable: currentIndex,
        builder: (BuildContext context, value, Widget? child) {
          return FloatingActionButton(
            backgroundColor:
                currentIndex.value == 2 ? AppColors.blueF8 : AppColors.white,
            onPressed: () {
              currentIndex.value = 2;
              controller.jumpToPage(2);
            },
            shape: const CircleBorder(),
            child: Assets.icons.search.svg(
              width: 20.r,
              height: 20.r,
              colorFilter: ColorFilter.mode(
                currentIndex.value == 2 ? AppColors.white : AppColors.grey72,
                BlendMode.srcIn,
              ),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: ValueListenableBuilder(
          valueListenable: currentIndex,
          builder: (BuildContext context, int value, Widget? child) {
            return BottomBarWidget(
              currentIndex: currentIndex.value,
              onTap: (index) {
                if (index == 4) {
                  AppUtils.checkTokenBeforeImplement(
                    context,
                    onPress: () {
                      currentIndex.value = index;
                      controller.jumpToPage(index);
                    },
                  );
                  return;
                }

                currentIndex.value = index;
                controller.jumpToPage(index);
              },
              listPage: listPages,
            );
          }),
    );
  }
}
