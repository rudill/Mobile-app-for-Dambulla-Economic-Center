import 'package:dec_app/Pages/sellerprofileEdit.dart';
import 'package:dec_app/Pages/technicalhelp.dart';
import 'package:flutter/material.dart';


class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile UI',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
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
      home: ProfileScreen(onThemeToggle: _toggleTheme, themeMode: _themeMode),
    );
  }
}

// ---------------------- ProfileScreen ----------------------

class ProfileScreen extends StatelessWidget {
  final Function(bool) onThemeToggle;
  final ThemeMode themeMode;

  const ProfileScreen({
    super.key,
    required this.onThemeToggle,
    required this.themeMode,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = themeMode == ThemeMode.dark;

    return Scaffold(

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const UserProfileCard(),
                const SizedBox(height: 40),
                const GreenActionButton(),
                const SizedBox(height: 16),
                const SupportButton(),
                const SizedBox(height: 16),
                const FontSizeControl(),
                const SizedBox(height: 32),
                DarkModeToggle(
                  isDarkMode: isDark,
                  onToggle: onThemeToggle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------- Other Widgets ----------------------

class UserProfileCard extends StatelessWidget {
  const UserProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).focusColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(blurRadius: 5, color: Colors.black26),
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
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ඩී.කේ සිරිසේන',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '3455667',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class GreenActionButton extends StatelessWidget {
  const GreenActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green.shade800,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 4,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfileEditPage()),
        );
      },
      icon: const Icon(Icons.edit),
      label: const Text('තොරතුරු වෙනස් කිරිම', style: TextStyle(fontSize: 16)),
    );
  }
}

class SupportButton extends StatelessWidget {
  const SupportButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
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
    );
  }
}

class FontSizeControl extends StatefulWidget {
  const FontSizeControl({super.key});

  @override
  State<FontSizeControl> createState() => _FontSizeControlState();
}

class _FontSizeControlState extends State<FontSizeControl> {
  double fontSize = 1.0;

  void _increaseFont() {
    setState(() {
      if (fontSize < 1.5) fontSize += 0.1;
    });
  }

  void _decreaseFont() {
    setState(() {
      if (fontSize > 0.5) fontSize -= 0.1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 330,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.green.shade800,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [BoxShadow(blurRadius: 4, color: Colors.black26)],
        ),
        child: Column(
          children: [
            const Row(
              children: [
                Icon(Icons.search, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  'අකුරු ප්‍රමාණය වෙනස් කිරීම',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                    onPressed: _decreaseFont,
                  ),
                  Text(
                    '${(fontSize * 100).toInt()}%',
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    color: Colors.green.shade800,
                    onPressed: _increaseFont,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------- DarkMode Toggle Widget ----------------------

class DarkModeToggle extends StatelessWidget {
  final bool isDarkMode;
  final Function(bool) onToggle;

  const DarkModeToggle({
    super.key,
    required this.isDarkMode,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 150),
        const Text('වරණ පරිපාලනය', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
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
                  Text("ආලෝකය",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                ],
              ),
              Switch(
                value: isDarkMode,
                onChanged: onToggle,
              ),
              const Row(
                children: [
                  Icon(Icons.dark_mode),
                  SizedBox(width: 4),
                  Text("අඳුරු",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
