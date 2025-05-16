import 'package:flutter/material.dart';

import '../../Firestore/productData.dart';
import '../../Models/product_model.dart';
import 'package:intl/intl.dart';

class OrderUpdate extends StatefulWidget {
  final Product product;
  const OrderUpdate({super.key, required this.product});

  @override
  State<OrderUpdate> createState() => _OrderUpdateState();
}

class _OrderUpdateState extends State<OrderUpdate> {

  late TextEditingController priceController;
  late TextEditingController quantityController;

  @override
  void initState() {
    super.initState();
    priceController = TextEditingController(text: widget.product.price.toString());
    quantityController = TextEditingController(text: widget.product.quantity.toString());
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("යාවත්කාලීන කිරීම",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),),
        backgroundColor: Color(0xFF208A43),
      ),


      body: SingleChildScrollView(
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
                  widget.product.name,
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
                    controller: quantityController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder() ,
                    ),
                  ),
                ),
                Text("KG" , style: TextStyle( fontWeight: FontWeight.w600, fontSize: 20)),
                SizedBox(width: 180,),
              ],
            ),
            SizedBox(height: 15,),

            Text("මිල",style: TextStyle( fontWeight: FontWeight.w600, fontSize: 17)),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
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
                  widget.product.shopno,
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
                    DateFormat('yyyy-MM-dd').format(widget.product.date ),
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
              ),
            ),
            SizedBox(height: 45,),

            Center(
              child: ElevatedButton(onPressed: () async{
                Map<String,dynamic>productDetails ={
                  'price':double.parse(priceController.text),
                  'quantity' :int.parse(quantityController.text)
                };
                Database().updateProduct(productDetails, widget.product.id, context);
                priceController.clear();
                quantityController.clear();
              },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text("තහවුරු කරන්න",style: TextStyle( fontWeight: FontWeight.w700,fontSize: 20)),
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
