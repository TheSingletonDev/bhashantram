import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';

import 'app_routes.dart';
import 'global/global_app_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GestureBinding.instance.resamplingEnabled = true;
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  // await Hive.initFlutter();
  // await Hive.openBox(hiveDBName);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // final Box hiveDBInstance = Hive.box(hiveDBName);
    // Streaming vs Batch model preference
    // if (hiveDBInstance.get(isStreamingPreferred) == null) {
    //   hiveDBInstance.put(isStreamingPreferred, true);
    // }

    return DynamicColorBuilder(builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
      // Color baseColor = Get.isDarkMode ? const Color(0xFF6f35a6) : const Color(0xFF052e70);
      Color baseColor = const Color(0xFF6f35a6);
      ColorScheme lightColorScheme;
      ColorScheme darkColorScheme;

      // // Enable if monet is needed
      // if (lightDynamic != null && darkDynamic != null) {
      //   lightColorScheme = lightDynamic.harmonized();
      //   darkColorScheme = darkDynamic.harmonized();
      // } else {
      //   lightColorScheme = ColorScheme.fromSeed(seedColor: baseColor);
      //   darkColorScheme = ColorScheme.fromSeed(seedColor: baseColor, brightness: Brightness.dark);
      // }

      // Enable if Color needed from Seed Color only
      lightColorScheme = ColorScheme.fromSeed(seedColor: baseColor);
      darkColorScheme = ColorScheme.fromSeed(seedColor: baseColor, brightness: Brightness.dark);

      return GetMaterialApp(
          title: appName.tr,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(colorScheme: lightColorScheme, useMaterial3: true),
          darkTheme: ThemeData(colorScheme: darkColorScheme, useMaterial3: true),
          getPages: AppRoutes.routes,
          initialRoute: AppRoutes.getMenuPageRoute(),
          builder: (context, child) {
            final scale = MediaQuery.of(context).textScaleFactor.clamp(1.0, 1.0);

            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                statusBarColor: Theme.of(context).colorScheme.primaryContainer,
                statusBarIconBrightness: Get.isDarkMode ? Brightness.light : Brightness.dark));

            ScreenUtil.init(context, designSize: const Size(screenUtilWidth, screenUtilHeight), minTextAdapt: true);
            return MediaQuery(data: MediaQuery.of(context).copyWith(textScaleFactor: scale), child: child!);
          });
    });
  }
}
