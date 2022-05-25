import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_bet/ui/screens/settings/settings_screen.dart';
import '../../data/app_settings/color_pallete/colors.dart';
import '../../gen/assets.gen.dart';
import 'home/home.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> screens = [HomeScreen(), SettingsScreen()];
  int currIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          bottomNavigationBar: Container(
            child: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                    icon: Assets.images.quiz
                        .svg(color: AppColors.white.withOpacity(0.3)),
                    label: 'Quiz',
                    activeIcon: Assets.images.quiz.svg(color: AppColors.blue)),
                BottomNavigationBarItem(
                    label: 'Settings',
                    icon: Assets.images.settings.svg(
                        color: AppColors.white.withOpacity(0.3),
                        width: 24.w,
                        height: 24.h),
                    activeIcon: Assets.images.settings.svg(
                        color: AppColors.blue, width: 24.w, height: 24.h)),
              ],
              backgroundColor: AppColors.darkblue,
              unselectedLabelStyle: TextStyle(
                fontFamily: 'Bakbak',
                fontWeight: FontWeight.w400,
                color: AppColors.white.withOpacity(0.3),
                fontSize: 12.h,
              ),
              currentIndex: currIndex,
              onTap: (index) {
                setState(() {
                  currIndex = index;
                });
              },
            ),
          ),
          body: Container(
            child: screens[currIndex],
          ),
        ),
        onWillPop: () async => false);
  }
}
