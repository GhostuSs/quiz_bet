import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/app_settings/color_pallete/colors.dart';

class RoundedRectangleBtn extends StatelessWidget {
  const RoundedRectangleBtn(
      {Key? key, required this.label, required this.onTap})
      : super(key: key);
  final VoidCallback onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(3.h),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.h),
          color: AppColors.usualBlue,
        ),
        width: 155.w,
        height: 155.h,
        child: Center(
          child: Text(
            label,
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Bakbak',
                fontSize: 75.h,
                fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }
}
