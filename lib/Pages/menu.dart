import 'package:dec_app/Pages/Seller/sallerHome.dart';
import 'package:dec_app/Pages/Seller/sellerprofileEdit.dart';
import 'package:dec_app/Pages/technicalhelp.dart';
import 'package:dec_app/Widgets/font_size_controller.dart';
import 'package:dec_app/Widgets/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dec_app/Azure_Translation/translatable_text.dart';

import '../Azure_Translation/LanguageToggle.dart';
import '../Firestore/auth_service.dart';
import 'Farmer/farmerHome.dart';
import 'Farmer/farmerprofileEdit.dart';
import 'LoginPage.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  User? user;
  String? displayName;
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    displayName = user?.displayName ?? 'User';
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.themeMode,
      builder: (context, themeMode, _) {
        final isDark = themeMode == ThemeMode.dark;

        return MaterialApp(
          title: 'Profile UI',
          debugShowCheckedModeBanner: false,
          themeMode: themeMode,
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.green,
            scaffoldBackgroundColor: Colors.white,
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.green,
            scaffoldBackgroundColor: Colors.black,
            useMaterial3: true,
          ),
          builder: (context, child) {
            return ValueListenableBuilder<double>(
              valueListenable: FontSizeController.fontSize,
              builder: (context, fontSize, _) {
                return MediaQuery(
                  data: MediaQuery.of(
                    context,
                  ).copyWith(textScaleFactor: fontSize),
                  child: child ?? const SizedBox(),
                );
              },
            );
          },
          home: Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    buildProfileHeader(),
                    const SizedBox(height: 40),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade800,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 64,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 4,
                      ),
                      onPressed: () async {
                        if (user != null) {
                          var userDoc = await _authService.getUserData(
                            user!.uid,
                          );
                          if (userDoc.exists) {
                            Navigator.pop(context);
                            if (userDoc['role'] == 'farmer') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FarmerProfileEditPage(),
                                ),
                              );
                            } else if (userDoc['role'] == 'seller') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfileEditPage(),
                                ),
                              );
                            }
                          }
                        }
                      },
                      icon: const Icon(Icons.edit),
                      label: const TranslatableText(
                        'තොරතුරු වෙනස් කිරිම',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade800,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 84,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 4,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TechnicalHelpPage(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.settings),
                      label: const TranslatableText(
                        'තාක්ෂණික සහාය',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 16),
                    buildFontSizeCard(context),
                    const SizedBox(height: 32),
                    buildThemeToggle(isDark),
                    const SizedBox(height: 32),
                    const SizedBox(height: 32),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        backgroundColor: Colors.grey.shade700,
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(fontSize: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      icon: const Icon(Icons.arrow_back),
                      label: const TranslatableText('ආපසු'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FarmerHomePage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildProfileHeader() {
    return Container(
      height: 200,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).focusColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(blurRadius: 5, color: Colors.black26.withOpacity(0.1)),
        ],
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/images/faramer1.jpg'),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ' $displayName',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      ' ${user?.uid ?? "No Details"}',
                      style: const TextStyle(fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(top: 4, right: 48, child: const LanguageToggle()),
          Positioned(
            top: 1,
            right: -11,
            child: IconButton(
              icon: const Icon(Icons.logout, size: 28, color: Colors.red),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFontSizeCard(BuildContext context) {
    return Center(
      child: Container(
        width: 330,
        height: 120,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.green.shade800,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [BoxShadow(blurRadius: 4, color: Colors.black26)],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: const [
                Icon(Icons.search, color: Colors.white),
                SizedBox(width: 8),
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: TranslatableText(
                      'අකුරු ප්‍රමාණය වෙනස් කිරීම',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    color: Colors.green.shade800,
                    onPressed: FontSizeController.decreaseFont,
                  ),
                  ValueListenableBuilder<double>(
                    valueListenable: FontSizeController.fontSize,
                    builder: (context, fontSize, _) {
                      return Text(
                        '${(fontSize * 100).toInt()}%',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        textScaleFactor: 1.0,
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    color: Colors.green.shade800,
                    onPressed: FontSizeController.increaseFont,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildThemeToggle(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TranslatableText(
          'වර්ණ තේමාව',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Container(
          width: 330,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            color: Theme.of(context).focusColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Row(
                children: [
                  Icon(Icons.light_mode),
                  SizedBox(width: 4),
                  TranslatableText(
                    "ආලෝකය",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Switch(
                value: isDark,
                onChanged: (value) {
                  ThemeController.toggleTheme(value);
                },
              ),
              const Row(
                children: [
                  Icon(Icons.dark_mode),
                  SizedBox(width: 4),
                  TranslatableText(
                    "අඳුරු",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
