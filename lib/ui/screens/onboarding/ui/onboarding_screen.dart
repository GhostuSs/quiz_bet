import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:quiz_bet/data/app_settings/color_pallete/colors.dart';
import 'package:quiz_bet/data/app_settings/navigation/routes.dart';
import 'package:quiz_bet/gen/assets.gen.dart';
import 'package:quiz_bet/main.dart';
import 'package:quiz_bet/ui/screens/webview/web.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _OnBoardingScreenState();
  }
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.usualBlue,
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/onBoarding.png'),
                fit: BoxFit.cover)),
        child: Container(
          decoration: BoxDecoration(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding:
                    EdgeInsets.symmetric(vertical: 57.h, horizontal: 28.w),
                    child: InkWell(
                      onTap: () async {
                        final box = await Hive.openBox<bool>('seen');
                        await box.clear();
                        await box.put('seen', true);
                        Navigator.pushNamed(context, MainNavigationRoutes.main);
                      },
                      child: Icon(
                        Icons.clear,
                        color: AppColors.white,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 60.h,
              ),
              Assets.images.xbetLogo.svg(),
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.end,
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text(
              //       '1X',
              //       style: TextStyle(
              //         color: AppColors.white,
              //         fontWeight: FontWeight.w400,
              //         fontFamily: 'Bakbak',
              //         fontSize: 112.w,
              //       ),
              //     ),
              //     Text(
              //       'BEL',
              //       style: TextStyle(
              //           color: AppColors.blue,
              //           fontWeight: FontWeight.w400,
              //           fontFamily: 'Bakbak',
              //           fontSize: 112.w),
              //     )
              //   ],
              // ),
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text(
              //       'QUIZ: SPORT',
              //       style: TextStyle(
              //           color: AppColors.white,
              //           height: 0.6,
              //           fontWeight: FontWeight.w400,
              //           fontFamily: 'Bakbak',
              //           fontSize: 51.w),
              //     )
              //   ],
              // ),
              Padding(
                padding: EdgeInsets.only(top: 95.h, bottom: 18.h),
                child: Text(
                  'Random Mode',
                  style: TextStyle(
                      color: AppColors.white,
                      height: 0.6,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Bakbak',
                      fontSize: 29.w),
                ),
              ),
              Container(
                width: 159.w,
                height: 1.5,
                color: AppColors.blue,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 18.h),
                child: Text(
                  '50/50',
                  style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Bakbak',
                      fontSize: 29.w),
                ),
              ),
              Container(
                width: 159.w,
                height: 1.5,
                color: AppColors.blue,
              ),
              SizedBox(
                height: 18.h,
              ),
              Text(
                'Ad Removing',
                style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Bakbak',
                    fontSize: 29.w),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 24.w, right: 24.w, top: 30.h, bottom: 22.h),
                child: InkWell(
                  onTap: () async {
                    final box = await Hive.openBox<bool>('premium');
                    await box.clear();
                    await box.put('premium', true);
                    final seen = await Hive.openBox<bool>('seen');
                    await seen.clear();
                    await seen.put('seen', true);
                    premium=true;
                    Navigator.pushNamed(context, MainNavigationRoutes.main);
                  },
                  child: Container(
                    height: 56.h,
                    width: 327.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: AppColors.blue),
                    child: Center(
                      child: Text(
                        'Buy premium'.toUpperCase(),
                        style: TextStyle(
                          color: AppColors.darkblue,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Bakbak',
                          fontSize: 22.w,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Opacity(
                opacity: 0.5,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 48.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>WebViewPage())),
                        child: Text(
                          'Terms of use',
                          style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Bakbak',
                              fontSize: 14.w),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          final box = await Hive.openBox<bool>('premium');
                          await box.clear();
                          await box.put('premium', true);
                          premium=true;
                          final onboardingSeen = await Hive.openBox<bool>('seen');
                          await onboardingSeen.clear();
                          await onboardingSeen.put('seen', true);
                          seen=true;
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Restore',
                          style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Bakbak',
                              fontSize: 14.w),
                        ),
                      ),
                      InkWell(
                        onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>WebViewPage())),
                        child: Text(
                          'Privacy Policy',
                          style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Bakbak',
                              fontSize: 14.w),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
