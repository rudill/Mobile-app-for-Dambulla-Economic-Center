import 'package:flutter/material.dart';



class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile UI',
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      home: const ProfileScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: const [
                UserProfileCard(),
                SizedBox(height: 40),
                GreenActionButton(),
                SizedBox(height: 16),
                SupportButton(),
                SizedBox(height: 16),
                FontSizeControl(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UserProfileCard extends StatelessWidget {
  const UserProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
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
                backgroundImage: AssetImage('assets/images/faramer1.jpg'), // your image
              ),
              const SizedBox(width: 16),
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ඒ.වී.කේ සිරිසේන',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '1007667',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
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
              onPressed: () {
                // Handle close
              },
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
        // Handle edit action
      },
      icon: const Icon(Icons.edit),
      label: const Text(
        'තොරතුරු වෙනස් කිරිම',
        style: TextStyle(fontSize: 16),
      ),
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
        // Handle support action
      },
      icon: const Icon(Icons.settings),
      label: const Text(
        'තාක්ෂණික සහාය',
        style: TextStyle(fontSize: 16),
      ),
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
      if (fontSize < 2.0) fontSize += 0.1;
    });
  }

  void _decreaseFont() {
    setState(() {
      if (fontSize > 0.6) fontSize -= 0.1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 333,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 52),
      decoration: BoxDecoration(
        color: Colors.green.shade800,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(blurRadius: 4, color: Colors.black26),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'අකුරු ප්‍රමාණය වෙනස් කිරීම',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 6),
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
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
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
    );
  }
}
