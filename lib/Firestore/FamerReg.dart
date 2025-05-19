import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<void> registerFarmer({
  required BuildContext context,
  required TextEditingController emailController,
  required TextEditingController pwdController,
  required TextEditingController fnameController,
  required TextEditingController lnameController,
  required TextEditingController nicController,
  required TextEditingController phnoController,
  required GlobalKey<FormState> formKey,
  required Function(String userId) onSuccess,
}) async {
  final auth = FirebaseAuth.instance;
  User? user;

  if (formKey.currentState!.validate()) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              CircularProgressIndicator(),
              SizedBox(width: 16),
              Text("කරුණාකර රැඳී සිටින්න..."),
            ],
          ),
        ),
      ),
    );

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: pwdController.text.trim(),
      );

      user = userCredential.user;
      await user!.updateDisplayName(fnameController.text.trim());
      await user.reload();
      user = auth.currentUser;

      await FirebaseFirestore.instance
          .collection("FramerReg")
          .doc(user!.uid)
          .set({
        'Email': emailController.text.trim(),
        'First Name': fnameController.text.trim(),
        'Last Name': lnameController.text.trim(),
        'NIC': nicController.text.trim(),
        'Phone Number': phnoController.text.trim(),
      });


      await FirebaseFirestore.instance.collection('Users').doc(user.uid).set({
        'email': emailController.text.trim(),
        'role': 'farmer',
      });

      Navigator.pop(context);
      onSuccess(user.uid);

      emailController.clear();
      pwdController.clear();
      fnameController.clear();
      lnameController.clear();
      nicController.clear();
      phnoController.clear();

    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Password too weak.')),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Email already in use.')),
        );
      }
    } catch (e) {
      Navigator.pop(context);
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred.')),
      );
    }
  }
}
