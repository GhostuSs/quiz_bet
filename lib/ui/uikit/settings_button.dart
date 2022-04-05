import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/app_settings/color_pallete/colors.dart';
import '../../gen/assets.gen.dart';

class SettingsButton extends StatelessWidget {
  Widget icon;
  String label;

  SettingsButton({Key? key, required this.icon, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: InkWell(
        onTap: () => debugPrint('pressed'),
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          width: double.infinity,
          height: 58.h,
          decoration: BoxDecoration(
              color: AppColors.green,
              borderRadius: BorderRadius.circular(12.r)),
          child: Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: Row(
              children: [
                SizedBox(
                  width: 32.w,
                  height: 32.h,
                  child: icon,
                ),
                SizedBox(width: 16.w),
                Text(
                  label.toUpperCase(),
                  style: TextStyle(
                    color: AppColors.darkblue,
                    fontSize: 22.h,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Bakbak',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
