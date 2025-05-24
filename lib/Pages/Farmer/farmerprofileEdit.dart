import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Azure_Translation/translatable_text.dart';

class FarmerProfileEditPage extends StatefulWidget {
  const FarmerProfileEditPage({super.key});

  @override
  State<FarmerProfileEditPage> createState() => _FarmerProfileEditPageState();
}

class _FarmerProfileEditPageState extends State<FarmerProfileEditPage> {
  final TextEditingController fnameController = TextEditingController();
  final TextEditingController phnoController = TextEditingController();
  final TextEditingController nicController = TextEditingController();

  String? documentId;
  bool isLoading = true;
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    fetchFarmerData();
  }

  Future<void> fetchFarmerData() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance
              .collection('FramerReg')
              .where(FieldPath.documentId, isEqualTo: user!.uid)
              .get();

      if (snapshot.docs.isNotEmpty) {
        final doc = snapshot.docs.first;
        final data = doc.data();
        documentId = doc.id;

        setState(() {
          fnameController.text = data['First Name'] ?? '';
          phnoController.text = data['Phone Number'] ?? '';
          nicController.text = data['NIC'] ?? '';
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: TranslatableText('Data not found')),
        );
      }
    } catch (e) {
      print('Error fetching farmer data: $e');
      setState(() => isLoading = false);
    }
  }

  Future<void> updateFarmerData() async {
    if (documentId == null) return;

    try {
      await FirebaseFirestore.instance
          .collection('FramerReg')
          .doc(documentId)
          .update({
            'First Name': fnameController.text,
            'Phone Number': phnoController.text,
            'NIC': nicController.text,
          });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: TranslatableText('තොරතුරු යාවත්කාලීන කරන ලදී')),
      );

      // Return updated name to Menuf page
      Navigator.pop(context, fnameController.text);
    } catch (e) {
      print('Error updating farmer data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: TranslatableText('දෝෂයක්: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const TranslatableText(
          'තොරතුරු වෙනස් කිරිම',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green.shade800,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body:
          isLoading
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
                    const SizedBox(height: 40),

                    buildField(fnameController, 'නම'),
                    buildField(phnoController, 'ජංගම දුරකථන අංකය'),
                    buildField(nicController, 'ජාතික හැඳුනුම්පත් අංකය'),

                    const SizedBox(height: 40),

                    ElevatedButton(
                      onPressed: updateFarmerData,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade800,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 100,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const TranslatableText(
                        'තහවුරු කරන්න',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),

                    const SizedBox(height: 15),

                    TextButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                      label: const TranslatableText('ආපසු'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                      ),
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
          label: TranslatableText(label),
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
    );
  }
}
