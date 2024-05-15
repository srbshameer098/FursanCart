import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fursan_cart/Ui/Screens/Bottom_Navigation.dart';
import 'package:fursan_cart/Ui/Screens/Login_Screen/signup_page.dart';
import 'package:fursan_cart/bloc/Login/login_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../repository/Services/google_auth_service.dart';

class Login_Page extends StatefulWidget {
  const Login_Page({super.key});

  @override
  State<Login_Page> createState() => _Login_pageState();
}

class _Login_pageState extends State<Login_Page> {
  final loginpage_email = TextEditingController();
  final loginpage_password = TextEditingController();
  final form_key = GlobalKey<FormState>();
  String loginpage_email1 = '';
  String loginpage_password1 = '';
  String pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";
  bool passwordvisible = false;

  @override
  Widget build(BuildContext context) {
    RegExp regex = RegExp(pattern);
    var mwidth = MediaQuery
        .of(context)
        .size
        .width;
    var mheight = MediaQuery
        .of(context)
        .size
        .height;
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is SignupblocLoaded) {
          Navigator.of(context).pop();
          String tokens = state.data.tokens!.accessToken.toString();
          String userid = state.data.res!.id.toString();

          userInfo(tokens, userid,);
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
              builder: (context) => const Bottom_Navigation()), (
              route) => false);
        }
        if (state is SignupblocLoading) {
          showDialog(
              context: context,
              builder: (BuildContext a) => Center(child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 40,
                child: Image.asset(
                  'asset/Icons/loading .gif', fit: BoxFit.cover,),)));
          }
              if (state is SignupblocError)
          {
            Navigator.of(context).pop();
          }
        },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: mwidth,
                  height: mheight,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('asset/Images/Login.jpg'))),
                  child: Form(
                    key: form_key,
                    child: Column(
                      children: [
                        SizedBox(height: mheight * 0.364),
                        Center(
                          child: Container(
                            padding: EdgeInsets.only(left: mwidth * 0.01),
                            decoration: BoxDecoration(
                                color: const Color(0xffF1F1F1),
                                borderRadius: BorderRadius.circular(12)),
                            width: mwidth * 0.9,
                            height: mheight * 0.085,
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: mwidth * 0.05),
                                  child: SizedBox(
                                    height: mheight * 0.03,
                                    width: mwidth * 0.075,
                                    child: Image.asset(
                                      'asset/Icons/email.png',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: mwidth * 0.04,
                                    top: mheight * 0.01,
                                  ),
                                  width: mwidth * 0.756,
                                  height: mheight * 0.08,
                                  child: TextFormField(
                                    textInputAction: TextInputAction.next,
                                    controller: loginpage_email,

                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty ||
                                          !regex.hasMatch(value)) {
                                        return 'Invalid email';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      loginpage_email1 = value!.trim();
                                      value.replaceAll(RegExp(r'\s+'), '');
                                    },onChanged: (value) {
                                    loginpage_email.value = TextEditingValue(
                                      text: value.trim(),
                                      selection: loginpage_email.selection,
                                    );
                                  },
                                    decoration: const InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      focusedErrorBorder: InputBorder.none,
                                      hintText: 'email',
                                      hintStyle: TextStyle(color: Color(0xff767676)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: mheight * 0.02,
                        ),
                        Center(
                          child: Container(
                            padding: EdgeInsets.only(left: mwidth * 0.01),
                            decoration: BoxDecoration(
                                color: const Color(0xffF1F1F1),
                                borderRadius: BorderRadius.circular(12)),
                            width: mwidth * 0.9,
                            height: mheight * 0.085,
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: mwidth * 0.04),
                                  child: SizedBox(
                                    width: mwidth * 0.075,
                                    height: mheight * 0.03,
                                    child: Image.asset(
                                      'asset/Icons/Vector.png',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                Container(
                                    padding: EdgeInsets.only(
                                        left: mwidth * 0.04, top: mheight * 0.01),
                                    width: mwidth * 0.756,
                                    height: mheight * 0.08,
                                    child: TextFormField(
                                      textInputAction: TextInputAction.done,
                                      obscureText: passwordvisible ? false : true,
                                      controller: loginpage_password,
                                      validator: (value) {
                                        if (value!.isEmpty || value.length < 3) {
                                          return 'Password should be atleast 3 character';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        loginpage_password1 = value!.trimRight();
                                      },
                                      decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  passwordvisible =
                                                  !passwordvisible;
                                                });
                                              },
                                              icon: passwordvisible ? const Icon(
                                                Icons.remove_red_eye,
                                                color: Color(0xff767676),
                                              ) : const Icon(
                                                FontAwesomeIcons.eyeSlash,
                                                color: Color(0xff767676), size: 18,
                                              )

                                          ),
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          focusedErrorBorder: InputBorder.none,
                                          hintText: 'Password',
                                          hintStyle:
                                          const TextStyle(color: Color(0xff767676))),
                                    )),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: mheight * 0.03,
                        ),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              final isvalid = form_key.currentState?.validate();
                              if (isvalid == true) {
                                form_key.currentState?.save();
                                BlocProvider.of<LoginBloc>(context).add(
                                    FetchLoginApi(
                                        loginpage_email.text.trimRight(),
                                        loginpage_password.text.trimRight()));
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.only(left: mwidth * 0.01),
                              decoration: BoxDecoration(
                                  color: const Color(0xffFFC113),
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
                          height: mheight * 0.022,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: mwidth * 0.63,
                            ),
                            const Text(
                              'Forgot password?',
                              style: TextStyle(color: Color(0xff264050)),
                            )
                          ],
                        ),
                        SizedBox(
                          height: mheight * 0.051,
                        ),
                        Center(
                          child: Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(onTap: (){
                                GoogleAuthService().signInWithFacebook(context);
                                setState(() {

                                });
                              },child: Image.asset('asset/Icons/facebook.png',width: mwidth*0.2,height: mheight*0.0525,)),
                              GestureDetector(onTap: (){
                                GoogleAuthService() .loginWithGoogle(context);
                              },child: Image.asset('asset/Icons/google.png',width: mwidth*0.2,height: mheight*0.05,)),
                              Image.asset('asset/Icons/iphone.png',width: mwidth*0.2,height: mheight*0.0525,),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: mheight * 0.025,
                        ),
                        Center(
                          child: Row(
                            children: [
                              SizedBox(
                                width: mwidth * 0.225,
                              ),
                              const Text(
                                'Dont have an account?',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff264050)),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext a) =>
                                            const Signup_page())),
                                child: const Text(
                                  'Signup',
                                  style: TextStyle(
                                      fontSize: 14.5,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff264050)),
                                ),
                              )
                            ],
                          ),
                        ), ]),
                    ),
                  ),
                Padding(padding: EdgeInsets.only(bottom: MediaQuery
        .of(context)
        .viewInsets
        .bottom)
    )],
            ),
          )),
    );
  }
  @override
  void dispose() {
    loginpage_password.clear();
    loginpage_email.clear();
    // TODO: implement dispose
    super.dispose();
  }

  void userInfo(String token, String userid) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString('Token', token);
    await preferences.setString('UserId', userid);

  }


}
