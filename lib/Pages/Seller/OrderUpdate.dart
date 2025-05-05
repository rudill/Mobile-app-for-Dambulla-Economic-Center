import 'package:flutter/material.dart';

class OrderUpdate extends StatefulWidget {
  const OrderUpdate({super.key});

  @override
  State<OrderUpdate> createState() => _OrderUpdateState();
}

class _OrderUpdateState extends State<OrderUpdate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("යාවත්කාලීන කිරීම",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),),
        backgroundColor: Color(0xFF208A43),
      ),


      body: Padding(
        padding:  EdgeInsets.symmetric(vertical: 17,horizontal: 15),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("එළවලු/පලතුරු නම",style: TextStyle( fontWeight: FontWeight.w600, fontSize: 17)),
            SizedBox(height: 10,),
            Container(
              width: 250,
              padding: EdgeInsets.symmetric( horizontal: 13,vertical: 13),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(5)
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "කැරට්",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
              ),
            ),


            SizedBox(height: 15,),

            Text("ප්‍රමාණය",style: TextStyle( fontWeight: FontWeight.w600, fontSize: 17)),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        //labelText: "ප්‍රමාණය",
                        hintText: "200",
                      border: OutlineInputBorder() ,
                    ),
                  ),
                ),
                Text("KG" , style: TextStyle( fontWeight: FontWeight.w600, fontSize: 20)),
                SizedBox(width: 200,),
              ],
            ),
            SizedBox(height: 15,),

            Text("මිල",style: TextStyle( fontWeight: FontWeight.w600, fontSize: 17)),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      //labelText: "ප්‍රමාණය",
                      hintText: "රු.300.00",
                      border: OutlineInputBorder() ,
                    ),
                  ),
                ),

                SizedBox(width: 150,),
              ],
            ),
            SizedBox(height: 15,),

            Text("කඩ අංකය", style: TextStyle( fontWeight: FontWeight.w600, fontSize: 17)),
            SizedBox(height: 10,),
            Container(
              width: 200,
              padding: EdgeInsets.symmetric( horizontal: 13,vertical: 13),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(5)
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "B/25",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
              ),
            ),
            SizedBox(height: 15,),

            Text("දිනය",style: TextStyle( fontWeight: FontWeight.w600, fontSize: 17)),
            SizedBox(height: 10,),
            Container(
              width: 150,
              padding: EdgeInsets.symmetric( horizontal: 13,vertical: 13),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(5)
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "2025/04/16",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
              ),
            ),
            SizedBox(height: 45,),

            Center(
              child: ElevatedButton(onPressed: (){},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text("තහවුරු කරන්න",style: TextStyle( fontWeight: FontWeight.w700,fontSize: 20)),
                ),),
            ),


          ],
        ),
      ),





    );
  }
}
