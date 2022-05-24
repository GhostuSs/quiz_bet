import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  SystemChrome.setPreferredOrientations(
  [DeviceOrientation.portraitUp]);
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
  if (onboardingSeen.values.isEmpty) await onboardingSeen.put('seen', false);
  seen = onboardingSeen.values.first;
  if (prem.values.isEmpty) await prem.put('premium', false);
  premium = prem.values.first;
  final box = await Hive.openBox<HiveResult>('results');
  print(box.values.length);
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
          selectedRowColor: AppColors.blue,
          unselectedWidgetColor: AppColors.white.withOpacity(0.3),
        ),
        routes: routes,
        initialRoute: seen==true && premium==true
            ? MainNavigationRoutes.main
            : MainNavigationRoutes.onboarding,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              selectedItemColor: AppColors.blue,
              selectedLabelStyle: TextStyle(
                  fontFamily: 'Bakbak',
                  fontWeight: FontWeight.w400,
                  fontSize: 12.h),
              showUnselectedLabels: true,
              showSelectedLabels: true,
              unselectedItemColor: AppColors.white.withOpacity(0.3),
              unselectedLabelStyle: TextStyle(
                  color: AppColors.white.withOpacity(0.3),
                  fontFamily: 'Bakbak',
                  fontWeight: FontWeight.w400,
                  fontSize: 12.h),
              unselectedIconTheme: IconThemeData(color: AppColors.white.withOpacity(0.3))),
          textTheme: TextTheme(
              button: TextStyle(
            fontSize: 45.sp,
          )),
        ),
          ),
    );
  }
}
