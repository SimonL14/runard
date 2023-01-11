import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = TextButton.styleFrom(
      // Changer couleur bouton ou police
    );
    return Scaffold(
      appBar: AppBar( // Bar menu
        centerTitle: false,
        titleSpacing: 0.0,
        title:  Transform(
          // you can forcefully translate values left side using Transform
          transform:  Matrix4.translationValues(-50.0, 0.0, 0.0),
          child: Image.asset("assets/logo_151_bon.png", height: 185, width: 185,),
        ),
        backgroundColor: Color(0xFF001420),
        actions: <Widget>[
        TextButton(
        style: style,
        onPressed: () {},
        child: const Icon(Icons.dehaze),
        ),
        ],
      ),
      body: Center(
        child:Text("Home page",textScaleFactor: 2,)
       ),
    );
  }
}