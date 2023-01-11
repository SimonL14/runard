import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'home.dart';


class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 10),
            ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage()))
    );
  }

  @override
  Widget build(BuildContext context) {
    const BackGround = const Color(0xFF001420);
    return Container(
      color: BackGround,
      child: Image.asset("assets/logo_151_bon.png", height: 1000,width: 1000,),
    );
  }
}
