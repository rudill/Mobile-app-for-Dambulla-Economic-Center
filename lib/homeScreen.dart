import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tessting home page'),
      ),
      body: const Column(
        children: [
          Align( 
            alignment: Alignment.center,
            child: Card(
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.home,
                      ),
                      Text('This is home page'),

                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
