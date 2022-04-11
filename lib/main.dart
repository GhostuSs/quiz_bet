import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quiz_bet/data/app_settings/navigation/routes.dart';
import 'package:quiz_bet/ui/screens/home/models/results/hive_results.dart';

import 'data/app_settings/color_pallete/colors.dart';

bool seen = false;
bool premium = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = Directory.current;
  if (Platform.isIOS) {
    directory = await getApplicationDocumentsDirectory();
  } else {
    directory = await getApplicationDocumentsDirectory();
  }
  Hive.init(directory.path);
  Hive.registerAdapter<HiveResult>(HiveResultAdapter());
  final onboardingSeen = await Hive.openBox<bool>('seen');
  final prem = await Hive.openBox<bool>('premium');
  if (onboardingSeen.values.isEmpty) onboardingSeen.put('seen', false);
  seen = onboardingSeen.values.first;
  if (prem.values.isEmpty) prem.put('premium', false);
  premium = prem.values.first;
  final box = await Hive.openBox<HiveResult>('results');
  print(box.values.length);
  premium = true;
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: () => MaterialApp(
        darkTheme: ThemeData(
          selectedRowColor: AppColors.green,
          unselectedWidgetColor: AppColors.white,
        ),
        routes: routes,
        initialRoute: seen || premium == false
            ? MainNavigationRoutes.main
            : MainNavigationRoutes.onboarding,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              selectedItemColor: AppColors.green,
              selectedLabelStyle: TextStyle(
                  fontFamily: 'Bakbak',
                  fontWeight: FontWeight.w400,
                  fontSize: 12.h),
              unselectedLabelStyle: TextStyle(
                  fontFamily: 'Bakbak',
                  fontWeight: FontWeight.w400,
                  fontSize: 12.h),
              unselectedIconTheme: const IconThemeData(color: AppColors.white)),
          textTheme: TextTheme(
              button: TextStyle(
            fontSize: 45.sp,
          )),
        ),
          ),
    );
  }
}
