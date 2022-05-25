import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_bet/gen/assets.gen.dart';
import 'package:quiz_bet/main.dart';
import 'package:quiz_bet/ui/screens/onboarding/ui/onboarding_screen.dart';
import 'package:quiz_bet/ui/uikit/1xbet_label.dart';
import 'package:quiz_bet/ui/uikit/settings_button.dart';
import '../../../data/app_settings/color_pallete/colors.dart';

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
        decoration: const BoxDecoration(
            color: AppColors.bglBlue
        ),
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 22.h, bottom: 22.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    XbelLabel()
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: SettingsButton(
                  icon: Assets.images.buyPremium.svg(color: AppColors.white),
                  label: 'buy premium',
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => OnBoardingScreen())),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: SettingsButton(
                  onPressed: ()=>openPrivacyPolicy(),
                  icon: Assets.images.privacyPolicy.svg(color: AppColors.white),
                  label: 'privacy policy',
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: SettingsButton(
                    onPressed: ()=>openTermsOfUse(),
                  icon: Assets.images.termsOfUse.svg(color: AppColors.white),
                  label: 'Terms of use',
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: SettingsButton(
                  icon: Assets.images.support.svg(color: AppColors.white),
                  label: 'support',
                  onPressed: ()=>openSupport(),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: SettingsButton(
                  icon: Assets.images.rateApp.svg(color: AppColors.white),
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
