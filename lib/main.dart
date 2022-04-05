import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_bet/data/app_settings/navigation/routes.dart';

Future<void> main() async {
  final a = await rootBundle.loadString('assets/quiz.json');
  print(a);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: () => MaterialApp(
        darkTheme: ThemeData.dark(),
        routes: routes,
        initialRoute: MainNavigationRoutes.main,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: TextTheme(button: TextStyle(fontSize: 45.sp)),
        ),
      ),
    );
  }
}
