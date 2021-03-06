import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Welcome/welcome.dart';
import 'package:flutter_application_1/function/ui/theme.dart';
import 'package:flutter_application_1/function/ui/theme_service.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/login/unknowhn.dart';
import 'package:flutter_application_1/page/graph/graph_page.dart';
import 'package:flutter_application_1/page/guide_pill.dart';
import 'package:flutter_application_1/page/detail_pressure.dart';
import 'package:flutter_application_1/page/high_pressure.dart';
import 'package:flutter_application_1/page/more.dart';
import 'package:flutter_application_1/page/normal_pressure.dart';
import 'package:flutter_application_1/page/screen_main/guidepilltest.dart';
import 'package:flutter_application_1/page/screen_main/user_form.dart';
import 'package:flutter_application_1/page/screen_main/user_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'controller/info_pill_page.dart';
import 'controller/notifications.service.dart';
import 'function/add_temp.dart';
import 'function/ui/add_task_bar.dart';
import 'page/pressure-average.screen.dart';

Future<void> main() async {
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Bangkok'));
  initializeDateFormatting();
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationsService().initail();
  await Firebase.initializeApp();
  // await NotifyHelper().initializeNotification();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return GetMaterialApp(
      debugShowMaterialGrid: false,
      //theme: Themes.light,
      //darkTheme: Themes.dark,
      //themeMode: ThemeService().Theme,
      initialRoute: '/',
      routes: {
        '/': (context) => user == null ? Welcome() : Home(),
        '/forgot HN': (BuildContext context) => UnknowHN(),
        '/guide pill': (BuildContext context) => GuidePill(),
        '/detail pressure': (BuildContext context) => DetailPressure(),
        '/addtemp': (context) => AddTemp(),
        '/graphpage': (context) => GraphPage(),
        '/pagemore': (context) => More(),
        '/page datauser': (context) => PageDataUser(),
        '/info pill page': (context) => InfoPillPage(),
        '/guidepill': (BuildContext context) => CourseInfoScreen(),
        '/high pressure': (context) => HighPressure(),
        '/normal pressure': (context) => NormalPressure(),
        '/pressure-average': (context) => PressureAveragePage(),

        UserFormScreen.routeName: (context) => UserFormScreen(),
        AddTaskPage.routeName: (context) => AddTaskPage(),
        //'/medpill': (context) => Medpill(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
