import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_bet/gen/assets.gen.dart';
import 'package:quiz_bet/ui/uikit/settings_button.dart';

import '../../../data/app_settings/color_pallete/colors.dart';
import '../../uikit/rounded_button.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SettingsScreenState();
  }
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.darkblue, AppColors.bglBlue],
        )),
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 46.h, bottom: 22.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '1X',
                      style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Bakbak',
                          fontSize: 44.h),
                    ),
                    Text(
                      'BEL',
                      style: TextStyle(
                          color: AppColors.green,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Bakbak',
                          fontSize: 44.h),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: SettingsButton(
                  icon: Assets.images.buyPremium.svg(),
                  label: 'buy premium',
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: SettingsButton(
                  icon: Assets.images.privacyPolicy.svg(),
                  label: 'privacy policy',
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: SettingsButton(
                  icon: Assets.images.termsOfUse.svg(),
                  label: 'Terms of use',
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: SettingsButton(
                  icon: Assets.images.support.svg(),
                  label: 'support',
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: SettingsButton(
                  icon: Assets.images.rateApp.svg(),
                  label: 'rate app',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
