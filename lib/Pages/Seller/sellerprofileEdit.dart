import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key });

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController shopNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController regNumberController = TextEditingController();

  bool isLoading = true;
  String? documentId;
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    fetchSellerData();
  }

  Future<void> fetchSellerData() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('SellerReg')
          .where(FieldPath.documentId, isEqualTo:user!.uid )
          .limit(5)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final doc = snapshot.docs.first;
        final data = doc.data();
        documentId = doc.id;

        nameController.text = data['FullName'] ?? '';
        shopNameController.text = data['ShopName'] ?? '';
        phoneController.text = data['PhoneNo'] ?? '';
        regNumberController.text = data['ShopReg'] ?? '';
      }
    } catch (e) {
      print('Error fetching seller data: $e');
    }

    setState(() => isLoading = false);
  }

  Future<void> updateSellerData() async {
    if (documentId == null) return;

    try {
      await FirebaseFirestore.instance.collection('SellerReg').doc(documentId!).update({
        'FullName': nameController.text,
        'ShopName': shopNameController.text,
        'PhoneNo': phoneController.text,
        'ShopReg': regNumberController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('තොරතුරු යාවත්කාලීන කරන ලදී')),
      );

      Navigator.pop(context, nameController.text); // Pass updated name back
    } catch (e) {
      print('Error updating data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('දෝෂයක් ඇති විය: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color dynamicGreen = isDark ? Colors.green.shade900 : Colors.green.shade800;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'තොරතුරු වෙනස් කිරිම',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: dynamicGreen,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 30),
            const CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('assets/images/faramer1.jpg'),
            ),
            const SizedBox(height: 60),
            buildField(nameController, 'නම වෙනස් කරන්න'),
            buildField(shopNameController, 'වෙලදසැල් නම'),
            buildField(phoneController, 'ජංගම දුරකථන අංකය'),
            buildField(regNumberController, 'ලියාපදිංචි අංකය'),
            const SizedBox(height: 60),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: dynamicGreen,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: updateSellerData,
              child: const Text('තහවුරු කරන්න', style: TextStyle(fontSize: 20)),
            ),

            const SizedBox(height: 15),
            TextButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text('ආපසු'),
              style: TextButton.styleFrom(foregroundColor: Colors.black),
            ),
          ],

        ),
      ),
    );
  }

  Widget buildField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }
}
