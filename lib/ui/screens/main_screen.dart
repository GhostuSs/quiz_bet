import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_bet/ui/screens/settings/settings_screen.dart';

import '../../data/app_settings/color_pallete/colors.dart';
import '../../gen/assets.gen.dart';
import '../uikit/rounded_button.dart';
import 'home/home.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> screens = [const HomeScreen(), SettingsScreen()];
  int currIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBarTheme(
          data: BottomNavigationBarThemeData(
              selectedItemColor: AppColors.green,
              selectedLabelStyle: TextStyle(
                  fontFamily: 'Bakbak',
                  fontWeight: FontWeight.w400,
                  fontSize: 12.h),
              unselectedLabelStyle: TextStyle(
                  fontFamily: 'Bakbak',
                  fontWeight: FontWeight.w400,
                  fontSize: 12.h),
              unselectedIconTheme: IconThemeData(color: AppColors.white)),
          child: CupertinoTabBar(
            items: [
              BottomNavigationBarItem(
                  icon: Assets.images.quiz.svg(color: AppColors.white),
                  label: 'Quiz',
                  activeIcon: Assets.images.quiz.svg(color: AppColors.green)),
              BottomNavigationBarItem(
                  label: 'Settings',
                  icon: Assets.images.settings
                      .svg(color: AppColors.white, width: 24.w, height: 24.h),
                  activeIcon: Assets.images.settings
                      .svg(color: AppColors.green, width: 24.w, height: 24.h)),
            ],
            activeColor: AppColors.green,
            inactiveColor: AppColors.white,
            backgroundColor: AppColors.bglBlue,
            currentIndex: currIndex,
            onTap: (index) {
              setState(() {
                currIndex = index;
              });
            },
          )),
      body: Container(
        child: screens[currIndex],
      ),
    );
  }
}
