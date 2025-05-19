
import 'package:dec_app/Pages/Seller/sallerHome.dart';
import 'package:dec_app/Pages/Seller/sellerprofileEdit.dart';
import 'package:dec_app/Pages/technicalhelp.dart';
import 'package:dec_app/Widgets/font_size_controller.dart';
import 'package:dec_app/Widgets/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Firestore/auth_service.dart';
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
                  data: MediaQuery.of(context).copyWith(textScaleFactor: fontSize),
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
                        padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        elevation: 4,
                      ),
                      onPressed: () async{
                        if (user != null) {
                          var userDoc = await _authService.getUserData(user!.uid);
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
                      label: const Text('තොරතුරු වෙනස් කිරිම', style: TextStyle(fontSize: 16)),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade800,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 84, vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        elevation: 4,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TechnicalHelpPage()),
                        );
                      },
                      icon: const Icon(Icons.settings),
                      label: const Text('තාක්ෂණික සහාය', style: TextStyle(fontSize: 16)),
                    ),
                    const SizedBox(height: 16),
                    buildFontSizeCard(context),
                    const SizedBox(height: 32),
                    buildThemeToggle(isDark),
                    const SizedBox(height: 32),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        textStyle: TextStyle(fontSize: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      icon: Icon(Icons.logout, size: 28),
                      label: Text('Logout'),
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
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
      height: 150,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).focusColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Colors.black26.withOpacity(0.1),
          ),
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
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                if (user != null) {
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("User not logged in")),
                  );
                }
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
          boxShadow: const [
            BoxShadow(blurRadius: 4, color: Colors.black26),
          ],
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
                    child: Text(
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
                        style: const TextStyle(fontSize: 16, color: Colors.black),
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
        const Text('වරණ පරිපාලනය',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                  Text("ආලෝකය", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
                  Text("අඳුරු", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
      ],

    );
  }

}
