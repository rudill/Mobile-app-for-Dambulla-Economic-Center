import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'SellerLogin.dart';


class SellerRegistration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: SignUpScreen());
  }
}

class SignUpScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  //Define karanawa variable tika firebase ekata danna

  final FullNameController = TextEditingController();
  final ShopNameController = TextEditingController();
  final ShopRegNumController = TextEditingController();
  final PhnoController = TextEditingController();
  final NICController = TextEditingController();
  final EmailController = TextEditingController();
  final PWDController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'වෙළදසැල් හිමිවරයෙකු ලෙස ලියාපදිංචිය.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 29,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 5),
                Image.asset('assets/images/signup_image.png', height: 150),
                SizedBox(height: 30),
                Text(
                  'ඔබගේ තොරතුරු ලබා දෙන්න.',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 5),
                TextFormField(
                  // Full Name Section------------------------------------------(1)
                  controller: FullNameController,
                  decoration: InputDecoration(
                    labelText: 'සම්පූර්ණ නම',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ඇතුලත් කිරීම අනිවාර්ය වේ!';
                    } else if (value.length > 200) {
                      return 'සම්පූර්ණ නම අක්ෂර 200කට වඩා වැඩි විය නොහැක!';
                    } else if (RegExp(r'[^a-zA-Z\s]').hasMatch(value)) {
                      return 'මසම්පූර්ණ නම තුළ අංක සහ විශේෂ ලක්ෂණ අඩංගු විය නොහැක!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  //Shop Name Section-------------------------------------------(2)
                  controller: ShopNameController,
                  decoration: InputDecoration(
                    labelText: 'වෙළදසැලේ නම',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'වෙළදසැලේ නම ඇතුලත් කිරීම අනිවාර්ය වේ!';
                    } else if (value.length > 200) {
                      return 'වෙළදසැලේ නම අක්ෂර 200කට වඩා වැඩි විය නොහැක!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  //Shop Reg Num Section----------------------------------------(3)
                  controller: ShopRegNumController,
                  obscureText: false, //Need to Remove this.
                  decoration: InputDecoration(
                    labelText: 'වෙළදසැල් ලියාපදිංචි අංකය',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'වෙළදසැල් ලියාපදිංචි අංකය ඇතුලත් කිරීම අනිවාර්ය වේ!';
                    } else if (value.length > 50) {
                      return 'වෙළදසැලේ නම අක්ෂර 50කට වඩා වැඩි විය නොහැක!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  //Phone Number Section----------------------------------------(4)
                  controller: PhnoController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'දුරකථන අංකය ඇතුලත් කරන්න.',
                    hintText: '07X-XXX-XXXX',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'දුරකථන අංකය ඇතුලත් කිරීම අනිවාර්ය වේ!';
                    } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                      return 'දුරකථන අංකය අංක 10ක් විය යුතුය!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  //NIC Number Section------------------------------------------(5)
                  controller: NICController,
                  decoration: InputDecoration(
                    labelText: 'ජාතික හැදුනුම්පත් අංකය ඇතුලත් කරන්න.',
                    hintText: '20012800000V',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ජාතික හැදුනුම්පත් අංකය ඇතුලත් කිරීම අනිවාර්ය වේ!';
                    } else if (value.length != 12) {
                      return 'ජාතික හැදුනුම්පත් අංකය අක්ෂර 12ක් වියයුතුයී!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  //Email Section-----------------------------------------------(6)
                  controller: EmailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'විද්‍යුත් ලිපිනය ඇතුලත් කරනන. ',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'විද්‍යුත් ලිපිනය ඇතුලත් කිරීම අනිවාර්ය වේ!';
                    } else if (!RegExp(
                      r'^[\w\.-]+@[\w\.-]+\.\w{2,4}$',
                    ).hasMatch(value)) {
                      return 'ඇතුලත් කල විද්‍යුත් ලිපිනය නිවැරදි නොවේ!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  //Password Section--------------------------------------------(7)
                  controller: PWDController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'නව මුරපදයක් ඇතුලත් කරන්න.',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'නව මුරපදයක් ඇතුලත් කිරීම අනිවාර්ය වේ!';
                    } else if (value.length <= 6) {
                      return 'මුරපදය අක්ෂර 6කට වඩා වැඩි විය යුතුය!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          CollectionReference collRef = FirebaseFirestore
                              .instance
                              .collection("SellerReg");
                          collRef.add({
                            'Email': EmailController.text,
                            'Full Name': FullNameController.text,
                            'NIC': NICController.text,
                            'PWD': PWDController.text,
                            'Shop Name': ShopNameController.text,
                            'Shop Reg Num': ShopRegNumController.text,
                          });
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("සාර්ථකයි!"),
                                content: Text("ඔබේ දත්ත සාර්ථකව උඩුගත විය."),
                                actions: [
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.green,
                                    ),
                                    child: Text("හරි"),
                                    onPressed: () {
                                      //Closed Cutton eka
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SellerloginPage(),
                                        ), // Home Page ekata dala thiyenne
                                      );
                                    },
                                  ),
                                ],
                              );
                            },
                          );

                          EmailController.clear();
                          FullNameController.clear();
                          NICController.clear();
                          PWDController.clear();
                          ShopNameController.clear();
                          ShopRegNumController.clear();

                        } catch (error) {
                          //Error msg display karanawa
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("අසාර්ථකයි!"),
                                content: Text(
                                  "කිසියම් දෝෂයක්. නැවත උත්සහ කරන්න!",
                                ),
                              );
                            },
                          );
                        }
                      }
                    },
                    child: Text(
                      'ලියාපදිංචි කරන්න',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SellerloginPage(),
                      ),
                    );
                  },
                  child: Text('ගිණුමක්‌ තීබේද? මෙතන ක්ලික් කරන්න.'),
                ),
                SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
