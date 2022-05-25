import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:quiz_bet/data/app_settings/color_pallete/colors.dart';
import 'package:quiz_bet/ui/screens/home/models/results/hive_results.dart';
import 'package:quiz_bet/ui/screens/quiz/quiz_screen.dart';
import 'package:quiz_bet/ui/uikit/1xbet_label.dart';
import 'package:quiz_bet/ui/uikit/rounded_button.dart';
import '../../../main.dart';
import 'models/quiz_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Iterable<HiveResult> results = [];

  Future<bool> loadHive() async {
    await Hive.openBox<HiveResult>('results')
        .then((value) => results = value.values);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    var data = '';
    rootBundle.loadString('assets/quizes.json').then((value) => data = value);
    return FutureBuilder(
        future: loadHive(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              extendBodyBehindAppBar: true,
              extendBody: true,
              backgroundColor: AppColors.bglBlue,
              body: Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      XbelLabel(),
                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          children: [
                            Wrap(
                              alignment: WrapAlignment.center,
                              children: [
                                for (int i = 1; i < 21; i++)
                                  Padding(
                                    padding: EdgeInsets.all(4.w),
                                    child: Container(
                                      child: RoundedRectangleBtn(
                                        label: (i).toString(),
                                        onTap: () => _onTap(i, data),
                                        result: results
                                                .where((element) =>
                                                    element.quizIndex ==
                                                    i.toString())
                                                .isNotEmpty
                                            ? results.firstWhere((element) =>
                                                element.quizIndex ==
                                                i.toString())
                                            : null,
                                      ),
                                    ),
                                  )
                              ],
                            ),
                            if (subscribed == true)
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 16.h,
                                ),
                                child: Container(
                                  height: 100.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.r),),
                                  child: RoundedRectangleBtn(
                                      label: 'RANDOM',
                                      onTap: () =>
                                          _onTap(Random().nextInt(10), data)),
                                ),
                              )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Container(
              width: double.infinity,
              height: double.infinity,
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
            );
          }
        });
  }

  void _onTap(int index, dynamic data) {
    final listMapAll = jsonDecode(data);
    List<Quiz> quiz = [];
    for (int i = 0; i < listMapAll[index - 1][index.toString()].length; i++)
      quiz.add(Quiz.fromJson(listMapAll[index - 1][index.toString()][i]));
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext ctx) =>
            QuizScreen(quiz: quiz, indexOfQuiz: index),
      ),
    );
  }
}
