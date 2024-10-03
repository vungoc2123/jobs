import 'package:flutter/material.dart';
import 'package:phu_tho_mobile/gen/assets.gen.dart';

class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GradientAppBar(
      {super.key,
      required this.title,
      required this.gradient,
      this.isOpenSearch = true,
      this.actionMore,
      this.actionBackWithResult});

  final Widget title;
  final Gradient gradient;
  final bool isOpenSearch;
  final Widget? actionMore;
  final VoidCallback? actionBackWithResult;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: gradient),
      child: AppBar(
        title: title,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            actionBackWithResult != null
                ? actionBackWithResult?.call()
                : Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          isOpenSearch
              ? IconButton(
                  onPressed: () {},
                  icon: Assets.icons.search.svg(
                      colorFilter: const ColorFilter.mode(
                          Colors.white, BlendMode.srcIn)))
              : const SizedBox(),
          if (actionMore != null) actionMore!
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
