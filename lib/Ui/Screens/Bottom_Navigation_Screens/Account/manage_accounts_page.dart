import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fursan_cart/bloc/UpdatePassword/update_password_bloc.dart';

import '../../../../bloc/GetUserDetails/get_user_details_bloc.dart';
import '../../../../bloc/UpdateUser/update_user_bloc.dart';
import '../../../../repository/model_class/GetUserDetails/GetUserDetailsModel.dart';
import '../../../Widgets/toast_message.dart';


class ManageAccount extends StatefulWidget {
  const ManageAccount({super.key});

  @override
  State<ManageAccount> createState() => _ManageAccountState();
}

class _ManageAccountState extends State<ManageAccount> {
  late GetUserDetailsModel userDetails;
  bool changepassword = false;
  TextEditingController username = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController oldpassword = TextEditingController();
  TextEditingController newpassword = TextEditingController();
  TextEditingController confirmnewpassword = TextEditingController();
  final form_key = GlobalKey<FormState>();
  String pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";

  @override
  Widget build(BuildContext context) {
    var mwidth = MediaQuery.of(context).size.width;
    var mheight = MediaQuery.of(context).size.height;
    userDetails =
        BlocProvider.of<GetUserDetailsBloc>(context).getUserDetailsModel;
    RegExp regex = RegExp(pattern);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: mheight * 0.085,
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 1,
        title: Row(children: [
          IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          const Text(
            'Manage Your Account',
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400),
          ),
        ]),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: form_key,
            child: BlocListener<UpdateUserBloc, UpdateUserState>(
  listener: (context, state) {
    if(state is UpdateUserblocLoaded){
      BlocProvider.of<GetUserDetailsBloc>(context).add(FetchGetUserDetails());
      ToastMessage().toastmessage(message: 'Updated Successfully');

    }
    if(state is UpdateUserblocLoading){
      print('loading');
    }
    if(state is UpdateUserblocError){
      ToastMessage().toastmessage(message: 'Oops Something Went Wrong');
    }
    // TODO: implement listener
  },
  child: SingleChildScrollView(
    child: Column(
                children: [
                  SizedBox(
                    height: mheight * 0.03,
                  ),
                  Container(
                      width: mwidth * 0.9,
                      height: mheight * 0.0834,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xffEEEEEE), width: mwidth * 0.004),
                          borderRadius: BorderRadius.circular(4)),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: mwidth * 0.04, top: mheight * 0.008),
                        child: TextFormField(
                          controller: phone,
                          autofocus: true,
                          decoration: InputDecoration(
                              suffix: SizedBox(
                                  width: mwidth * 0.58,
                                  child: Row(
                                    children: [
                                      phone.text.length == 10
                                          ? const Icon(
                                              Icons.check_circle_outlined,
                                              color: Color(0xff187A3F),
                                              size: 17,
                                            )
                                          : Container(),
                                      SizedBox(
                                        width: mwidth * 0.35,
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            if (phone.text.isNotEmpty &&
                                                phone.text.length == 10) {
                                              BlocProvider.of<UpdateUserBloc>(
                                                      context)
                                                  .add(FetchUpdatePhone(
                                                      phone: phone.text));
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          'Invalid Phone Number!')));
                                            }
                                          },
                                          child: Text(
                                            userDetails.phone==null?'Add':'Update',
                                            style: const TextStyle(fontSize: 13),
                                          ))
                                    ],
                                  )),
                              hintText:userDetails.phone==null?' ': userDetails.phone.toString(),
                              hintStyle: const TextStyle(
                                  color: Color(0xff101010),
                                  fontWeight: FontWeight.w400),
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              disabledBorder: InputBorder.none),
                        ),
                      )),
                  SizedBox(
                    height: mheight * 0.02,
                  ),
                  Container(
                      width: mwidth * 0.9,
                      height: mheight * 0.0834,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xffEEEEEE), width: mwidth * 0.004),
                          borderRadius: BorderRadius.circular(4)),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: mwidth * 0.04, top: mheight * 0.006),
                        child: TextFormField(
                          autofocus: true,
                          controller: username,
                          decoration: InputDecoration(
                              suffix: TextButton(
                                onPressed: () {
                                  if (username.text.isNotEmpty) {
                                    BlocProvider.of<UpdateUserBloc>(context).add(
                                        FetchUpdateUserName(
                                            username: username.text));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Field should not be empty')));
                                  }
                                },
                                child: const Text(
                                  'Update',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                              hintText:userDetails.username==null?'Null': userDetails.username.toString(),
                              hintStyle: const TextStyle(
                                  color: Color(0xffCACACA),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              disabledBorder: InputBorder.none),
                        ),
                      )),
                  SizedBox(
                    height: mheight * 0.02,
                  ),
                  Container(
                      width: mwidth * 0.9,
                      height: mheight * 0.0834,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xffEEEEEE), width: mwidth * 0.004),
                          borderRadius: BorderRadius.circular(4)),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: mwidth * 0.04, top: mheight * 0.006),
                        child: TextFormField(
                          autofocus: true,
                          controller: email,
                          decoration: InputDecoration(
                              hintText:userDetails.email==null?'******@gmail.com': userDetails.email.toString(),
                              suffix: TextButton(
                                onPressed: () {
                                  if (email.text.isNotEmpty &&
                                      regex.hasMatch(email.text)) {
                                    BlocProvider.of<UpdateUserBloc>(context)
                                        .add(FetchUpdateEmail(email: email.text));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text('Invalid Email!')));
                                  }
                                },
                                child: const Text(
                                  'Update',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                              hintStyle: const TextStyle(
                                  color: Color(0xffCACACA),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none),
                        ),
                      )),
                  SizedBox(
                    height: mheight * 0.036,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        changepassword = !changepassword;
                      });
                    },
                    child: Container(
                        width: mwidth * 0.9,
                        height: mheight * 0.068,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color(0xffEEEEEE), width: mwidth * 0.004),
                            borderRadius: BorderRadius.circular(4)),
                        child: const Center(
                          child: Text(
                            'Change Password',
                            style: TextStyle(
                                color: Color(0xff463607),
                                fontWeight: FontWeight.w700,
                                fontSize: 15),
                          ),
                        )),
                  ),
                  SizedBox(
                    height: mheight * 0.06,
                  ),
                  changepassword == true
                      ? Column(children: [
                          Container(
                              width: mwidth * 0.9,
                              height: mheight * 0.0834,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xffEEEEEE),
                                      width: mwidth * 0.004),
                                  borderRadius: BorderRadius.circular(4)),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: mwidth * 0.04, top: mheight * 0.006),
                                child: TextFormField(textInputAction: TextInputAction.next,
                                  controller: oldpassword,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Field should not be empty';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    oldpassword.text = value!;
                                  },
                                  decoration: const InputDecoration(
                                      hintText: 'Current Password',
                                      hintStyle: TextStyle(
                                          color: Color(0xffCACACA),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedErrorBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none),
                                ),
                              )),
                          SizedBox(
                            height: mheight * 0.012,
                          ),
                          Container(
                              width: mwidth * 0.9,
                              height: mheight * 0.0834,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xffEEEEEE),
                                      width: mwidth * 0.004),
                                  borderRadius: BorderRadius.circular(4)),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: mwidth * 0.04, top: mheight * 0.006),
                                child: TextFormField(textInputAction: TextInputAction.next,
                                  controller: newpassword,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Field should not be empty';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    newpassword.text = value!;
                                  },
                                  decoration: const InputDecoration(
                                      hintText: 'New Password',
                                      hintStyle: TextStyle(
                                          color: Color(0xffCACACA),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                      focusedBorder: InputBorder.none,
                                      focusedErrorBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none),
                                ),
                              )),
                          SizedBox(
                            height: mheight * 0.012,
                          ),
                          Container(
                              width: mwidth * 0.9,
                              height: mheight * 0.0834,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xffEEEEEE),
                                      width: mwidth * 0.004),
                                  borderRadius: BorderRadius.circular(4)),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: mwidth * 0.04, top: mheight * 0.006),
                                child: TextFormField(obscureText: true,textInputAction: TextInputAction.done,
                                  controller: confirmnewpassword,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Field should not be empty';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    confirmnewpassword.text = value!;
                                  },
                                  decoration: const InputDecoration(
                                      hintText: 'Confirm Password',
                                      hintStyle: TextStyle(
                                          color: Color(0xffCACACA),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      focusedErrorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none),
                                ),
                              )),
                          SizedBox(
                            height: mheight * 0.02,
                          ),
                          BlocListener<UpdatePasswordBloc, UpdatePasswordState>(
                            listener: (context, state) {
                              if (state is UpdatePasswordblocLoading) {
                                print('loading');
                                const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (state is UpdatePasswordblocLoaded) {
                                print('loaded');
                                BlocProvider.of<GetUserDetailsBloc>(context)
                                    .add(FetchGetUserDetails());
                                ToastMessage().toastmessage(message: 'Password Updated Successfully');
                                Navigator.of(context).pop();
                              }
                              if (state is UpdatePasswordblocError) {
                                ToastMessage().toastmessage(message: 'Current Password Is Incorrect');
                                print('error');
                              }
                              // TODO: implement listener
                            },
                            child: GestureDetector(
                              onTap: () {
                                final isvalid = form_key.currentState?.validate();
                                if (isvalid == true) {
                                  form_key.currentState?.save();
                                  if (newpassword.text ==
                                      confirmnewpassword.text) {
                                    BlocProvider.of<UpdatePasswordBloc>(context)
                                        .add(FetchUpdatePassword(
                                            oldPassword: oldpassword.text,
                                            newPassword: newpassword.text));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text('Password does not match')));
                                  }
                                }
                              },
                              child: Container(
                                  width: mwidth * 0.9,
                                  height: mheight * 0.068,
                                  decoration: BoxDecoration(
                                      color: const Color(0xffFFC113),
                                      borderRadius: BorderRadius.circular(4)),
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          left: mwidth * 0.04,
                                          top: mheight * 0.006),
                                      child: const Center(
                                        child: Text(
                                          'SAVE DETAILS',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 17),
                                        ),
                                      ))),
                            ),
                          )
                        ])
                      : Container(),Padding(padding: EdgeInsets.only(bottom: MediaQuery
                      .of(context)
                      .viewInsets
                      .bottom))
                ],
              ),
  ),
),
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    phone.clear();
    newpassword.clear();
    oldpassword.clear();
    confirmnewpassword.clear();
    username.clear();
    email.clear();

    // TODO: implement dispose
    super.dispose();
  }
}
