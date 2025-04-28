import 'package:dec_app/Pages/OrderUpdate.dart';
import 'package:flutter/material.dart';

class OnOrderTile extends StatefulWidget {
  const OnOrderTile({super.key});

  @override
  State<OnOrderTile> createState() => _OnOrderTileState();
}

class _OnOrderTileState extends State<OnOrderTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("කැරට්  200Kg",style: TextStyle( fontWeight: FontWeight.w700, fontSize: 15),),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5)
                  ),
                    child: Text("1KG රු. 200.00",style: TextStyle( fontWeight: FontWeight.w500, fontSize: 15),),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(height: 55,width: 55,
                        child: CircularProgressIndicator(
                          value: 0.2,
                          color: Color(0xFF208A43),
                          backgroundColor: Color(0xD1D1D3E4),
                          strokeWidth: 5,
                        ),
                      ),
                      Text(
                        "20%",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),

                  Text("200Kg න් 40Kg සම්පුර්ණ වී ඇත",style: TextStyle( fontWeight: FontWeight.w500, fontSize: 15),)
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OrderUpdate()),
                    );
                  },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                      child: Text("වෙනස් කරන්න",style: TextStyle( fontWeight: FontWeight.w700)),),

                  ElevatedButton(onPressed: (){},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                        foregroundColor: Colors.white,
                      ),
                      child: Text("ඉවත් කරන්න",style: TextStyle( fontWeight: FontWeight.w700)),),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
