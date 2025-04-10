import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:multicolour_clock/pages/clock_main/clock_main_binding.dart';
import 'package:multicolour_clock/pages/clock_main/clock_main_view.dart';
import 'package:multicolour_clock/pages/clock_setting/clock_setting_binding.dart';
import 'package:multicolour_clock/pages/clock_setting/clock_setting_view.dart';
import 'package:multicolour_clock/pages/feedback/feedback_binding.dart';
import 'package:multicolour_clock/pages/feedback/feedback_view.dart';
import 'package:multicolour_clock/pages/reload/reload_page_binding.dart';
import 'package:multicolour_clock/pages/reload/reload_page_view.dart';

Color primaryColor = Colors.black;
Color bgColor = const Color(0xfff8f8f8);

List<List<Color>> bgColors = [
  [const Color(0xff285591), const Color(0xff682681)],
  [const Color(0xff6eacff), const Color(0xff6eacff)],
  [const Color(0xff41746f), const Color(0xff41746f)],
  [const Color(0xff844175), const Color(0xff844175)],
  [const Color(0xff416284), const Color(0xff416284)],
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: Coloras,
      initialRoute: '/clockMain',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: bgColor,
        colorScheme: ColorScheme.light(
          primary: primaryColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: primaryColor,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        cardTheme: const CardTheme(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        dialogTheme: const DialogTheme(
          actionsPadding: EdgeInsets.only(right: 10, bottom: 5),
        ),
        dividerTheme: DividerThemeData(
          thickness: 1,
          color: Colors.grey[200],
        ),
      ),
    );
  }
}
List<GetPage<dynamic>> Coloras = [
  GetPage(name: '/clockMain', page: () => const ClockMainPage(), binding: ClockMainBinding()),
  GetPage(name: '/clockSetting', page: () => ClockSettingPage(), binding: ClockSettingBinding()),
  GetPage(name: '/feedback', page: () => FeedbackPage(), binding: FeedbackBinding()),
  GetPage(name: '/reload', page: () => const ReloadPageView(), binding: ReloadPageBinding()),
];