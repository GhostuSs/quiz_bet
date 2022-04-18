import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:quiz_bet/data/app_settings/color_pallete/colors.dart';
import 'package:quiz_bet/data/app_settings/navigation/routes.dart';
import 'package:quiz_bet/gen/assets.gen.dart';
import 'package:quiz_bet/ui/screens/home/models/results/hive_results.dart';
import 'package:quiz_bet/ui/uikit/1xbet_label.dart';

class ResultScreen extends StatefulWidget {
  ResultScreen({
    required this.result,
    required this.indexOfQuiz,
  });

  final int result;
  final int indexOfQuiz;

  @override
  State<StatefulWidget> createState() {
    return _ResultScreenState();
  }
}

class _ResultScreenState extends State<ResultScreen> {
  int currIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.black.withOpacity(0.3)))
        ),
        child: BottomNavigationBar(
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
          backgroundColor: AppColors.bglBlue,
          unselectedLabelStyle: TextStyle(
            fontFamily: 'Bakbak',
            fontWeight: FontWeight.w400,
            color: AppColors.white,
            fontSize: 12.h,
          ),
          currentIndex: 0,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.darkblue,
              AppColors.bglBlue,
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                XbelLabel(),
                Padding(
                  padding: EdgeInsets.only(top: 10.h, bottom: 8.h),
                  child: Text(
                    'The level is finished',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.white,
                        fontSize: 19.w,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Bakbak'),
                  ),
                ),
                SizedBox(
                  height: 160.h,
                ),
                Text(
                  'Your result:'.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.white,
                      fontSize: 24.w,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Bakbak'),
                ),
                Text(
                  '${widget.result}/5'.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.white,
                      fontSize: 187.w,
                      height: 1.5.h,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Bakbak'),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(left: 88.w,right: 88.w,bottom: 22.h),
                  child: InkWell(
                    onTap: () async {
                      final box = await Hive.openBox<HiveResult>('results');
                      if (box.values
                          .where((element) =>
                      element.quizIndex ==
                          widget.indexOfQuiz.toString())
                          .isNotEmpty) {
                        box.values
                            .firstWhere((element) =>
                        element.quizIndex ==
                            widget.indexOfQuiz.toString())
                            .delete();
                      }
                      await box.add(HiveResult(
                          quizIndex: widget.indexOfQuiz.toString(),
                          correctAnswers: widget.result.toString()));
                      await box.close();
                      Navigator.popAndPushNamed(
                          context, MainNavigationRoutes.main);
                    },
                    child: Container(
                      height: 56.h,
                      width: 200.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          color: AppColors.green),
                      child: Center(
                        child: Text(
                          'BACK'.toUpperCase(),
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
                )
              ],
            ),
          ),
        ),
      ),
    ), onWillPop: ()async=>false);
  }
}
