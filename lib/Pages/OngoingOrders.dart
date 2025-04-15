import 'package:flutter/material.dart';

class OngoingOrders extends StatefulWidget {
  const OngoingOrders({super.key});

  @override
  State<OngoingOrders> createState() => _OngoingOrdersState();
}

class _OngoingOrdersState extends State<OngoingOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ක්‍රියාකාරී ඇණවුම්",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),),
        backgroundColor: Color(0xFF208A43),

      ),
    );
  }
}
