import 'package:flutter/material.dart';
import 'package:fursan_cart/Ui/Screens/Login_Screen/login_page.dart';
import 'package:fursan_cart/Ui/Screens/Login_Screen/signup_page.dart';

class Login_Animation_page extends StatefulWidget {
  const Login_Animation_page({super.key});

  @override
  State<Login_Animation_page> createState() => _Login_Animation_pageState();
}

class _Login_Animation_pageState extends State<Login_Animation_page> {
  @override
  Widget build(BuildContext context) {
    var mwidth = MediaQuery.of(context).size.width;
    var mheight = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: mheight * 0.04,
              ),
              Padding(
                padding: EdgeInsets.only(left: mwidth * 0.06),
                child: const Text(
                  'Hello!',
                  style: TextStyle(
                      color: Color(0xff264050),
                      fontSize: 36,
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: mheight * 0.03,
              ),
              Center(
                child: SizedBox(
                  width: mwidth * 0.8,
                  height: mheight * 0.4,
                  child: Image.asset(
                    'asset/Icons/login_screen_image.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(
                height: mheight * 0.04,
              ),
              Padding(
                padding: EdgeInsets.only(left: mwidth * 0.078),
                child: const  Text(
                  'Let’s Start your\nnext level shopping.',
                  style: TextStyle(
                      color: Color(0xff264050),
                      fontSize: 25,
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: mheight * 0.06,
              ),
              Center(
                child: GestureDetector(onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext a)=>const  Login_Page())),
                  child: Container(
                    decoration: BoxDecoration(
                        color: const  Color(0xffFFC113),
                        borderRadius: BorderRadius.circular(12)),
                    width: mwidth * 0.92,
                    height: mheight * 0.075,
                    child: const Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: Color(0xff264050),
                            fontSize: 24,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: mheight * 0.043,
              ),
              const  Center(
                  child: Text(
                'Dont have an account?',
                style: TextStyle(
                    color: Color(0xff264050),
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
              )),SizedBox(height: mheight*0.016,),
              Center(
                child: GestureDetector(onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext a)=>const Signup_page())),
                  child: Container(
                    width: mwidth * 0.35,
                    height: mheight * 0.052,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        color: const Color(0xff264050)),
                    child: const Center(
                      child: Text(
                        'Signup',
                        style: TextStyle(
                            color: Color(0xffFFFFFF),
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
