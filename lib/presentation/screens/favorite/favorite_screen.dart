import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/appbar_gradient_widget.dart';
import 'package:phu_tho_mobile/presentation/screens/favorite/has_apply/applied_screen.dart';
import 'package:phu_tho_mobile/presentation/screens/favorite/has_save/saved_screen.dart';
import 'package:phu_tho_mobile/presentation/screens/favorite/seen/seen_screen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> with TickerProviderStateMixin{
  late TabController tabController;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: GradientAppBar(
        title: tr("favorites"),
        leading: const Icon(
          Icons.arrow_back_ios_new_outlined,
          color: Colors.white,
        ),
        leadingAction: () {
          Navigator.pop(context);
        },
      ),
    ),
      body: SafeArea(
        child: Column(
          children: [
            TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              unselectedLabelColor: Colors.black,
              labelColor: AppColors.blueF8,
              controller: tabController,
              tabs: [
                Tab(text: tr("has_apply"),),
                Tab(text: tr("has_save"),),
                Tab(text: tr("has_seen"),),
              ],
            ),
            
            Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: const [
                    JobAppliedScreen(),
                    JobSavedScreen(),
                    SeenScreen()
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}
