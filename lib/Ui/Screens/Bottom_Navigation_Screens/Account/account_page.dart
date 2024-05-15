import 'package:clipboard/clipboard.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fursan_cart/Ui/Screens/Bottom_Navigation_Screens/Account/save_adress_page.dart';
import 'package:fursan_cart/Ui/Screens/Bottom_Navigation_Screens/Cart/cart_page.dart';
import 'package:fursan_cart/Ui/Screens/Bottom_Navigation_Screens/favourites.dart';

import 'package:fursan_cart/bloc/GetUserDetails/get_user_details_bloc.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../repository/model_class/GetUserDetails/GetUserDetailsModel.dart';

import '../../../Widgets/toast_message.dart';
import '../../Login_Screen/login_page.dart';
import '../order_page.dart';
import 'manage_accounts_page.dart';

class Account_page extends StatefulWidget {
  const Account_page({super.key});

  @override
  State<Account_page> createState() => _Account_pageState();
}

late GetUserDetailsModel userInfo;

class _Account_pageState extends State<Account_page> {
  @override
  void initState() {
    BlocProvider.of<GetUserDetailsBloc>(context).add(FetchGetUserDetails());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mwidth = MediaQuery.of(context).size.width;
    var mheight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'My Account',
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 1,
        ),
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: DoubleBackToCloseApp(
          snackBar: const SnackBar(
            content: Text(
              'Double Tap To Exit',
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: mheight * 0.03,
                ),
                Padding(
                    padding: EdgeInsets.only(left: mwidth * 0.05),
                    child: Row(children: [
                      CircleAvatar(
                        radius: 33,
                        child: Image.asset('asset/Images/man.png'),
                      ),
                      SizedBox(
                        width: mwidth * 0.05,
                      ),
                      BlocBuilder<GetUserDetailsBloc, GetUserDetailsState>(
                          builder: (context, state) {
                        if (state is GetUserDetailsblocloading) {
                          return const Text(
                            'Name',
                            style: TextStyle(
                                color: Color(
                                  0xff463607,
                                ),
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                          );
                        }
                        if (state is GetUserDetailsblocerror) {
                          return RefreshIndicator(
                            onRefresh: () async {
                              return BlocProvider.of<GetUserDetailsBloc>(
                                      context)
                                  .add(FetchGetUserDetails());
                            },
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height * .9,
                                // color: Colors.red,
                                child: const Center(
                                  child: Text("Oops something went wrong"),
                                ),
                              ),
                            ),
                          );
                        }
                        if (state is GetUserDetailsblocloaded) {
                          userInfo =
                              BlocProvider.of<GetUserDetailsBloc>(context)
                                  .getUserDetailsModel;

                          return Text(
                            userInfo.username == null
                                ? 'Null'
                                : userInfo.username.toString(),
                            style: const TextStyle(
                                color: Color(
                                  0xff463607,
                                ),
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                          );
                        } else {
                          return Container();
                        }
                      })
                    ])),
                SizedBox(
                  height: mheight * 0.038,
                ),
                Padding(
                  padding: EdgeInsets.only(left: mwidth * 0.086),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (BuildContext a) => const Order())),
                        child: Container(
                            width: mwidth * 0.4,
                            height: mheight * 0.075,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                    color: const Color(0xffEEEEEE),
                                    width: mwidth * 0.004)),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: mwidth * 0.11,
                                  height: mheight * 0.033,
                                  child: Image.asset(
                                      'asset/Images/accounticon1.png'),
                                ),
                                SizedBox(
                                  width: mwidth * 0.03,
                                ),
                                const Text(
                                  'Orders',
                                  style: TextStyle(color: Color(0xff463607)),
                                ),
                                SizedBox(
                                  width: mwidth * 0.06,
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Colors.black,
                                  size: 16,
                                )
                              ],
                            )),
                      ),
                      SizedBox(
                        width: mwidth * 0.027,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (BuildContext a) =>
                                    const Favourate_Product())),
                        child: Container(
                            width: mwidth * 0.4,
                            height: mheight * 0.075,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                    color: const Color(0xffEEEEEE),
                                    width: mwidth * 0.004)),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: mwidth * 0.11,
                                  height: mheight * 0.027,
                                  child: Image.asset(
                                      'asset/Images/accounticon2.png'),
                                ),
                                SizedBox(
                                  width: mwidth * 0.013,
                                ),
                                const Text(
                                  'Favourites',
                                  style: TextStyle(color: Color(0xff463607)),
                                ),
                                SizedBox(
                                  width: mwidth * 0.02,
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Colors.black,
                                  size: 16,
                                )
                              ],
                            )),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: mheight * 0.01,
                ),
                Padding(
                  padding: EdgeInsets.only(left: mwidth * 0.085),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (BuildContext a) => const Cart_Page())),
                        child: Container(
                            width: mwidth * 0.4,
                            height: mheight * 0.075,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                    color: const Color(0xffEEEEEE),
                                    width: mwidth * 0.004)),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: mwidth * 0.11,
                                  height: mheight * 0.033,
                                  child: Image.asset(
                                      'asset/Images/accounticon3.png'),
                                ),
                                SizedBox(
                                  width: mwidth * 0.03,
                                ),
                                const Text(
                                  'Cart',
                                  style: TextStyle(color: Color(0xff463607)),
                                ),
                                SizedBox(
                                  width: mwidth * 0.1,
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Colors.black,
                                  size: 16,
                                )
                              ],
                            )),
                      ),
                      SizedBox(
                        width: mwidth * 0.027,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (BuildContext a) => const SaveAdress())),
                        child: Container(
                            width: mwidth * 0.4,
                            height: mheight * 0.075,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                    color: const Color(0xffEEEEEE),
                                    width: mwidth * 0.004)),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: mwidth * 0.05,
                                ),
                                const Text(
                                  'Save Adress',
                                  style: TextStyle(color: Color(0xff463607)),
                                ),
                                SizedBox(
                                  width: mwidth * 0.06,
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Colors.black,
                                  size: 16,
                                )
                              ],
                            )),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: mheight * 0.03,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext a) => const ManageAccount())),
                    child: Container(
                      width: mwidth * 0.824,
                      height: mheight * 0.083,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xffEEEEEE), width: mwidth * 0.004),
                          borderRadius: BorderRadius.circular(4)),
                      child: Row(
                        children: [
                          SizedBox(
                            width: mwidth * 0.12,
                            height: mheight * 0.0265,
                            child:
                                Image.asset('asset/Images/manageaccounts.png'),
                          ),
                          SizedBox(
                            width: mwidth * 0.03,
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: mheight * 0.01,
                              ),
                              const Text(
                                'Manage Accounts',
                                style: TextStyle(
                                    color: Color(0xff463607),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: mheight * 0.0056,
                              ),
                              const Text(
                                'Your account details',
                                style: TextStyle(
                                    color: Color(0xffCACACA),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: mwidth * 0.2,
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.black,
                            size: 22,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: mheight * 0.02,
                ),
                Divider(
                  thickness: mwidth * 0.0067,
                  color: const Color(0xffEEEEEE),
                ),
                SizedBox(
                  height: mheight * 0.02,
                ),
                BlocBuilder<GetUserDetailsBloc, GetUserDetailsState>(
                    builder: (context, state) {
                  if (state is GetUserDetailsblocloading) {
                    return const Text(
                      'z0EB6Mx',
                      style: TextStyle(
                          color: Color(0xff104464),
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    );
                  }
                  if (state is GetUserDetailsblocerror) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        return BlocProvider.of<GetUserDetailsBloc>(context)
                            .add(FetchGetUserDetails());
                      },
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * .9,
                          // color: Colors.red,
                          child: const Center(
                            child: Text("Oops something went wrong"),
                          ),
                        ),
                      ),
                    );
                  }
                  if (state is GetUserDetailsblocloaded) {
                    userInfo = BlocProvider.of<GetUserDetailsBloc>(context)
                        .getUserDetailsModel;
                    String referalCode = userInfo.referralCode.toString();
                    return Row(
                      children: [
                        SizedBox(
                          width: mwidth * 0.014,
                        ),
                        Image.asset(
                          'asset/Icons/gift.png',
                          width: mwidth * 0.12,
                          height: mheight * 0.03,
                        ),
                        SizedBox(
                          width: mwidth * 0.02,
                        ),
                        Column(
                          children: [
                            const Text(
                              'Invite Friends , Get rewards',
                              style: TextStyle(
                                  color: Color(0xff104464),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Share your code ',
                                  style: TextStyle(
                                      color: Color(0xff104464),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(width: mwidth*0.2,height:mheight*0.03,
                                  child: Text(
                                    referalCode.toString(),maxLines: 1,
                                    style: const TextStyle(
                                        color: Color(0xff104464),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                SizedBox(
                                  width: mwidth * 0.01,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    FlutterClipboard.copy(referalCode);
                                    ToastMessage().toastmessage(
                                        message: 'Copied to Clipboard');
                                  },
                                  child: Image.asset(
                                    'asset/Icons/Group.png',
                                    width: mwidth * 0.03,
                                    height: mheight * 0.03,
                                  ),
                                ),
                                SizedBox(
                                  width: mwidth * 0.02,
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          width: mwidth * 0.05,
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (referalCode.isEmpty) {
                              ToastMessage().toastmessage(
                                  message: 'Oops Something Went Wrong');
                            } else {
                              Share.share(referalCode);
                            }
                          },
                          child: Container(
                            width: mwidth * 0.185,
                            height: mheight * 0.035,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color(0xff1C5B82),
                                    width: mwidth * 0.002),
                                borderRadius: BorderRadius.circular(6)),
                            child: const Center(
                              child: Text(
                                'Invite ',
                                style: TextStyle(
                                    color: Color(0xff104464),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  } else {
                    return const SizedBox();
                  }
                }),
                SizedBox(
                  height: mheight * 0.005,
                ),
                Divider(
                  thickness: mwidth * 0.0067,
                  color: const Color(0xffEEEEEE),
                ),
                SizedBox(
                  height: mheight * 0.02,
                ),
                Padding(
                  padding: EdgeInsets.only(left: mwidth * 0.065),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'FAQs',
                        style: TextStyle(
                            color: Color(0xff463607),
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                      SizedBox(
                        height: mheight * 0.012,
                      ),
                      const Text(
                        'ABOUT US',
                        style: TextStyle(
                            color: Color(0xff463607),
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                      SizedBox(
                        height: mheight * 0.012,
                      ),
                      const Text(
                        'TERMS OF USE',
                        style: TextStyle(
                            color: Color(0xff463607),
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                      SizedBox(
                        height: mheight * 0.012,
                      ),
                      const Text(
                        'PRIVACY POLICY',
                        style: TextStyle(
                            color: Color(0xff463607),
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: mheight * 0.025,
                ),
                Divider(
                  thickness: mwidth * 0.0067,
                  color: const Color(0xffEEEEEE),
                ),
                SizedBox(
                  height: mheight * 0.037,
                ),
                Center(
                    child: GestureDetector(
                  onTap: () async {
                    final preferences = await SharedPreferences.getInstance();
                    preferences.clear();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (BuildContext a) => const Login_Page()),
                        (route) => false);
                  },
                  child: Container(
                    width: mwidth * 0.84,
                    height: mheight * 0.065,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                            color: const Color(0xffFFC113), width: mwidth * 0.004)),
                    child: const Center(
                      child: Text(
                        'LOG OUT',
                        style: TextStyle(
                            color: Color(0xffFFC113),
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ))
              ],
            ),
          ),
        ));
  }
}
