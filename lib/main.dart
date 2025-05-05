import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; //mkkmkk
import 'package:hive_ce/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'Pages/language_provider.dart';
import 'Pages/homeScreen.dart';
import 'Pages/CategoryFruit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  await Hive.openBox('myBox');

  runApp(
    ChangeNotifierProvider(
      create: (_) => LanguageProvider(),
      child: const Home(), // ✅ Now wrapped with provider
    ),
  );
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

//keytool -list -v -keystore "C:\Users\Ruvinda Dilshan\.android\debug.keystore" -alias androiddebugkey -storepass android -keypass android