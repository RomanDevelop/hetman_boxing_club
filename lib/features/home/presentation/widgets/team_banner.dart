import 'package:flutter/material.dart';
import 'package:hetman_boxing_club/app/theme/app_colors.dart';

class TeamBanner extends StatelessWidget {
  const TeamBanner({super.key});

  static const _aspect = 1024 / 341;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = width / _aspect;
        return SizedBox(
          width: width,
          height: height,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/images/team_banner.jpg',
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0x00070708),
                      Color(0x00070708),
                      Color(0xB3070708),
                      AppColors.background,
                    ],
                    stops: [0, 0.58, 0.84, 1],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
