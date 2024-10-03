import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/gen/assets.gen.dart';
import 'package:phu_tho_mobile/presentation/routes/route_name.dart';
import 'package:phu_tho_mobile/presentation/screens/home_tab/home_tab.dart';

import 'splash_cubit.dart';
import 'splash_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SplashCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<SplashCubit>(context);
    _cubit.checkLoggedSessionBeforeImplement();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.blue44,
      body: BlocListener<SplashCubit, SplashSate>(
        listenWhen: (pre, cur) => pre.loadStatus != cur.loadStatus,
        listener: (context, state) {
          if (state.loadStatus == LoadStatus.success) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              RouteName.homeTab,
              (Route<dynamic> route) => false,
              arguments: const HomeTabArguments(index: 0),
            );
          }
        },
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.images.anhnen.path),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    Assets.images.imgLogoApp.path,
                    height: 70,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    'Việc làm Phú Thọ',
                    style: TextStyle(color: AppColors.white, fontSize: 30),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
