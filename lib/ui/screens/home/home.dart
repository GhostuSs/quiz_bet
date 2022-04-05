import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_bet/data/app_settings/color_pallete/colors.dart';
import 'package:quiz_bet/ui/uikit/rounded_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [AppColors.darkblue, AppColors.bglBlue],
      )),
      child: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 46.h),
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
            RoundedRectangleBtn(label: '11')
          ],
        ),
      ),
    ));
  }
}
