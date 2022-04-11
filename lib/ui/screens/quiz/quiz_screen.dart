import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_bet/data/app_settings/color_pallete/colors.dart';
import 'package:quiz_bet/gen/assets.gen.dart';
import 'package:quiz_bet/main.dart';
import 'package:quiz_bet/ui/screens/home/models/quiz_model.dart';
import 'package:quiz_bet/ui/uikit/1xbet_label.dart';

import '../result/result_screen.dart';

class QuizScreen extends StatefulWidget {
  QuizScreen({required this.quiz, required this.indexOfQuiz});

  final int indexOfQuiz;
  final List<Quiz> quiz;

  @override
  State<StatefulWidget> createState() {
    return _QuizScreenState();
  }
}

class _QuizScreenState extends State<QuizScreen> {
  int index = 0;
  int correctAnswers = 0;
  int currIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: premium
          ? Padding(
              padding: EdgeInsets.only(bottom: 107.h),
              child: InkWell(
                onTap: () {
                  print('otTap');
                },
                child: Container(
                  height: 56.h,
                  width: 200.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: AppColors.green),
                  child: Center(
                    child: Text(
                      '50/50'.toUpperCase(),
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
          : Container(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
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
        //activeColor: AppColors.green,
        // inactiveColor: AppColors.white,
        backgroundColor: AppColors.bglBlue,
        unselectedLabelStyle: TextStyle(
            fontFamily: 'Bakbak',
            fontWeight: FontWeight.w400,
            color: AppColors.white,
            fontSize: 12.h),
        currentIndex: currIndex,
        onTap: (index) {
          setState(() {
            currIndex = index;
          });
        },
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
                    widget.quiz[index].question!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.white,
                        fontSize: 19.w,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Bakbak'),
                  ),
                ),
                Wrap(
                  children: [
                    for (int i = 0; i < widget.quiz[index].answers!.length; i++)
                      InkWell(
                        borderRadius: BorderRadius.circular(8.r),
                        onTap: () {
                          print(widget.quiz[index].correct ==
                              widget.quiz[index].answers![i]);
                          if (widget.quiz[index].correct ==
                              widget.quiz[index].answers![i]) {
                            if (correctAnswers < 5) ;
                            correctAnswers++;
                          }
                          if (index < widget.quiz.length - 1)
                            setState(() {
                              index++;
                            });
                          else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResultScreen(
                                  indexOfQuiz: widget.indexOfQuiz,
                                  result: correctAnswers,
                                ),
                              ),
                            );
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.all(8.h),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: AppColors.usualBlue),
                            width: 155.w,
                            height: 155.h,
                            child: Center(
                              child: Text(
                                widget.quiz[index].answers![i].toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 24.w,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Bakbak'),
                              ),
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
