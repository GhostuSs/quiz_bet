import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_bet/data/app_settings/color_pallete/colors.dart';
import 'package:quiz_bet/ui/uikit/1xbet_label.dart';
import 'package:quiz_bet/ui/uikit/rounded_button.dart';

import '../quiz/quiz_screen.dart';
import 'model/quiz_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var data = '';
    rootBundle.loadString('assets/quizes.json').then((value) => data = value);
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              XbelLabel(),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  children: [
                    Wrap(
                      children: [
                        for (int i = 1; i < 11; i++)
                          Padding(
                            padding: EdgeInsets.all(8.w),
                            child: RoundedRectangleBtn(
                              label: (i).toString(),
                              onTap: () => _onTap(i, data),
                            ),
                          )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onTap(int index, dynamic data) {
    final listMapAll = jsonDecode(data);
    List<Quiz> quiz = [];
    for (int i = 0; i < listMapAll[index - 1][index.toString()].length; i++)
      quiz.add(Quiz.fromJson(listMapAll[index - 1][index.toString()][i]));
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext ctx) => QuizScreen(quiz: quiz),
      ),
    );
  }
}
