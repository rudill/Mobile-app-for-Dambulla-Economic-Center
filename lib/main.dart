import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'Components/local_notification.dart';
import 'Pages/homeScreen.dart';
import 'firebase_options.dart';
import 'Widgets/font_size_controller.dart';
import 'Widgets/theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  await Hive.openBox('myBox');
  await Hive.openBox('reservations');
  // initializeNotifications();

  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.themeMode,
      builder: (context, themeMode, _) {
        return ValueListenableBuilder<double>(
          valueListenable: FontSizeController.fontSize,
          builder: (context, fontSize, _) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              themeMode: themeMode,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              builder:
                  (context, child) => MediaQuery(
                    data: MediaQuery.of(
                      context,
                    ).copyWith(textScaleFactor: fontSize),
                    child: child!,
                  ),
              home: const HomeScreen(),
            );
          },
        );
      },
    );
  }
}

//keytool -list -v -keystore "C:\Users\Ruvinda Dilshan\.android\debug.keystore" -alias androiddebugkey -storepass android -keypass android
