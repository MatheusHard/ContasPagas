import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pagamento_de_contas/iu/principal.dart';

class SplashScreenPrincipal extends StatefulWidget {
  @override
  _SplashScreenPrincipalState createState() => _SplashScreenPrincipalState();
}

class _SplashScreenPrincipalState extends State<SplashScreenPrincipal> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    Timer(Duration(seconds: 3), (){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_)=> Principal())
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.deepPurpleAccent,
        padding: EdgeInsets.all(60),
        child: Center(
          child: SpinKitFadingCircle(
            color: Colors.white70,
            size: 50.0,
          ),
        ),
      ),
    );
  }
}



