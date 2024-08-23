import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:grocery_app/views/widgets/cart_screen.dart';
import 'package:grocery_app/views/widgets/home.dart';
import 'package:grocery_app/views/widgets/profile_screen.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  late Home homepage;
  late CartScreen cartscrn;
  late ProfileScreen profile;
  late List screens;
  int currentIndex=0;

  @override
  void initState() {
  
  homepage=const Home();
  cartscrn=const CartScreen();
  profile=const ProfileScreen();
  screens=[homepage,cartscrn, profile];
  super.initState();
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(

        bottomNavigationBar: CurvedNavigationBar(
          height: 65,
          backgroundColor: Color.fromARGB(255, 255, 253, 253),
          color: Color.fromARGB(221, 182, 176, 176),
          animationDuration:const Duration(milliseconds: 500),
          onTap: (value){setState(() => currentIndex=value);},
          items: const[
            Icon(Icons.home ,color: Colors.black,),
            Icon(Icons.shopping_cart,color: Colors.black,),
            Icon(Icons.person,color: Colors.black,),
          ],
        ),


   body:screens[currentIndex] ,
        );
  }
}