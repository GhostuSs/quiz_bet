import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/app_settings/color_pallete/colors.dart';

class XbelLabel extends StatelessWidget {
  const XbelLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 46.h),
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
    );
  }
}
