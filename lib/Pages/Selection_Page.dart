import 'package:dec_app/Pages/CategoryScreen.dart';
import 'package:flutter/material.dart';



class Selection_screen extends StatelessWidget {
  const Selection_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      )
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 48),
          _buildButton("එලවළු", "assets/images/image1.png",true, context),
          SizedBox(height: 48),
          _buildButton("පලතුරු", "assets/images/image2.png",false, context),
        ],
      ),
    );
  }

  Widget _buildButton(String text, String imagePath,bool isVegetable, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CategoryScreen(isVegetable:isVegetable)),
        );
      },
      child: Container(
        padding: EdgeInsets.all(24),
        margin: EdgeInsets.all(32),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: Color(0xFF4CAF50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Image.asset(imagePath, height: 170, width: 170),
          ],
        ),
      ),
    );
  }
}