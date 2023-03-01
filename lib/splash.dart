import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'home.dart';


class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);
  @override
  State<Splash> createState() => _SplashState();


}

class _SplashState extends State<Splash> {

  final spinkit = SpinKitFadingCircle(
  itemBuilder: (BuildContext context, int index) {
  return DecoratedBox(
  decoration: BoxDecoration(
  color: index.isEven ? Color(0xFF0386E8F) : Color(0xFF0386E8F),
  ),
  );
  },
  );

  @override
  void initState(){
    super.initState();


    Timer(Duration(seconds: 10),
            ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage()
    )),
    );
  }

  @override
  Widget build(BuildContext context) {
    const BackGround = const Color(0xFF001420);
    return Container(
      color: BackGround,
      child: Column(
        children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 150),
          child: Image.asset("assets/logo_151_bon.png"),),
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: spinkit,
          ),
        ],
      ),
    );
  }
}
