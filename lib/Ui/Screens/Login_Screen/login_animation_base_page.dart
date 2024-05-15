import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'login_animation_page.dart';
class Login_Animation_Base_Screen extends StatefulWidget {
  const Login_Animation_Base_Screen({super.key});

  @override
  State<Login_Animation_Base_Screen> createState() => _Login_Animation_Base_ScreenState();
}




class _Login_Animation_Base_ScreenState extends State<Login_Animation_Base_Screen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1),() {
      Navigator.of(context).push(PageTransition(
          child: const  Login_Animation_page(),
          type: PageTransitionType.topToBottom,
          childCurrent: widget,duration: const  Duration(seconds: 1)));
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(backgroundColor: Colors.black);
  }
}
