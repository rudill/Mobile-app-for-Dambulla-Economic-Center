import 'package:flutter/material.dart';

class OrderWaiting extends StatefulWidget {
  const OrderWaiting({super.key});

  @override
  State<OrderWaiting> createState() => _OrderWaitingState();
}

class _OrderWaitingState extends State<OrderWaiting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [Image(image: AssetImage('assets/images/up_shape.png'))],
        ),
      ),
    );
  }
}
