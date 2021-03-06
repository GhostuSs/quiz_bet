import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_bet/ui/screens/home/models/results/hive_results.dart';

import '../../data/app_settings/color_pallete/colors.dart';

class RoundedRectangleBtn extends StatelessWidget {
  const RoundedRectangleBtn(
      {Key? key, required this.label, required this.onTap, this.result})
      : super(key: key);
  final HiveResult? result;
  final VoidCallback onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.h),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.h),
          color: AppColors.blue,
        ),
        width: 155.w,
        height: 155.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.white,
                    fontFamily: 'Bakbak',
                    fontSize: label == 'RANDOM' ? 60.w : 80.w,
                    fontWeight: FontWeight.w400),
              ),
            ),
            if (label != 'RANDOM' && result != null)
              Text('${result!.correctAnswers}/5',
                  style: TextStyle(
                      color: AppColors.green,
                      fontFamily: 'Bakbak',
                      fontSize: 28.w,
                      fontWeight: FontWeight.w400))
          ],
        ),
      ),
    );
  }
}
