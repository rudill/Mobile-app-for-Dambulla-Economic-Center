import 'package:flutter/material.dart';

class OnOrderTile extends StatefulWidget {
  const OnOrderTile({super.key});

  @override
  State<OnOrderTile> createState() => _OnOrderTileState();
}

class _OnOrderTileState extends State<OnOrderTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("කැරට්  200Kg"),
              Container( decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(5)
              ),
                child: Text("කිලෝවකට රු. 200.00"),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircularProgressIndicator(),
              Text("200Kg න් 40Kg සම්පුර්ණ වී ඇත")
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(onPressed: (){},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  child: Text("වෙනස් කරන්න")),

              ElevatedButton(onPressed: (){},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                    foregroundColor: Colors.white,
                  ),
                  child: Text("ඉවත් කරන්න")),


            ],
          )
        ],
      ),
    );
  }
}
