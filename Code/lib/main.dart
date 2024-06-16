import 'package:demo2/NavigationRoute.dart';
import 'package:demo2/theme/Appcolors.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.PrimaryBackground) .copyWith(
            secondary: AppColors.SecondaryBackground, brightness: Brightness.dark),
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.PrimaryBackground,

      ),
      routerConfig: NavigationRoute().router,
    );
  }
}
