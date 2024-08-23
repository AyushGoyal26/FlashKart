import 'dart:async';

import 'package:flutter/material.dart';


import 'package:grocery_app/views/widgets/signup.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {




  void _moveToLogin(){
    Timer(const Duration(seconds: 4), (){
      Navigator.of(context).push(MaterialPageRoute(builder: (_){
        return const Signup();
      }));
    });
  }

  @override
  void initState() {

    super.initState();
    _moveToLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(image: DecorationImage(fit: BoxFit.fill, image:AssetImage('assets/images/splash.jpeg'))),
              ),

               const Center(
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [     
                         
                
                  CircularProgressIndicator(),
              ],),)
          ],
        ),
      ),
    );
  }
}