import 'package:flutter/material.dart';

import 'HiveBase.dart';

class HiveForm extends StatefulWidget {
  const HiveForm({super.key});

  @override
  State<HiveForm> createState() => _HiveFormState();
}

class _HiveFormState extends State<HiveForm> {
  late TextEditingController nameController;
  late TextEditingController indexController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    indexController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    indexController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(title: Text('Add to hive box')),
          body: Align(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: indexController,
                    decoration: InputDecoration(
                      labelText: 'Index',
                      hintText: 'Enter an index',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      prefixIcon: Icon(Icons.numbers),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      hintText: 'Enter a name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    final int? index = int.tryParse(indexController.text);
                    if (index != null) {
                      HiveArchive().addToHiveBoxFromForm(
                        index,
                        nameController.text,
                      );
                    } else {
                      // Handle the case where the input is not a valid integer
                      print('Invalid index: ${indexController.text}');
                    }
                  },
                  child: Text('Add'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
