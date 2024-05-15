import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fursan_cart/Ui/Screens/bottom_navigation.dart';
import 'package:fursan_cart/Ui/Screens/Login_Screen/login_animation_base_page.dart';
import 'package:shared_preferences/shared_preferences.dart';





class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
Future<void>checkuserlogin()async
{
  final preferences=await SharedPreferences.getInstance();

  Future.delayed(const  Duration(seconds: 5),(){
  if(!preferences.containsKey('Token'))
    {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
          builder: (context) => const  Login_Animation_Base_Screen()), (
          route) => false);
    }
  else
    {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
          builder: (context) => const  Bottom_Navigation()), (
          route) => false);
    }
});}


@override
  void initState() {
  checkuserlogin();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var mwidth = MediaQuery.of(context).size.width;
    var mheight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: mwidth * 0.45,
          height: mheight * 0.21,
          decoration: BoxDecoration(
              color: const  Color(0xff264050),
              borderRadius: BorderRadius.circular(51)),
          child: Image.asset('asset/Icons/splash_screen_icon.png'),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
