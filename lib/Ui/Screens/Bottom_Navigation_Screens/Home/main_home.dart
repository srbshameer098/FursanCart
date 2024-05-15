import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:fursan_cart/Ui/Screens/Bottom_Navigation_Screens/Home/bestoffer/see_all_bestoffer.dart';
import 'package:fursan_cart/Ui/Screens/Bottom_Navigation_Screens/Home/choosebrand/choose_brand_section_items.dart';
import 'package:fursan_cart/Ui/Screens/Bottom_Navigation_Screens/Home/search/search_screen.dart';
import 'package:fursan_cart/Ui/Screens/Bottom_Navigation_Screens/Home/slider/carousel_slider_widget.dart';
import 'package:fursan_cart/Ui/Screens/Bottom_Navigation_Screens/favourites.dart';
import 'package:fursan_cart/Ui/Screens/Bottom_Navigation_Screens/Home/trendingnow/see_all_trendingnow.dart';
import 'package:fursan_cart/Ui/Screens/Bottom_Navigation_Screens/Home/trendingnow/trending_now_section.dart';
import 'package:fursan_cart/Ui/Screens/Bottom_Navigation_Screens/Home/bestoffer/bestoffer_section.dart';


import '../order_page.dart';

class Home_page extends StatefulWidget {
  const Home_page({super.key});

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var mwidth = MediaQuery.of(context).size.width;
    var mheight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 0,
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        primary: false,
        bottom: PreferredSize(
          preferredSize: Size(mwidth, mheight * 0.14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: mwidth * 0.043,
                  ),
                  Container(
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(6)),
                      height: mheight * 0.06,
                      width: mwidth * 0.325,
                      child: Image.asset(
                        'asset/Icons/home_screen_icon.png',
                        fit: BoxFit.contain,
                      )),
                  SizedBox(
                    width: mwidth * 0.445,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext a) => const Favourate_Product())),
                    child: const Icon(
                      Icons.favorite_outline,
                      color: Color(0xff636363),
                      size: 23,
                    ),
                  ),
                  SizedBox(
                    width: mwidth * 0.01,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext a) => const Order())),
                    child:const ImageIcon(AssetImage('asset/Icons/order_icon.png'),
                        color: Color(0xff636363),size: 24,)

                  ),
                  SizedBox(
                    width: mwidth * 0.04,
                  )
                ],
              ),
              SizedBox(
                height: mheight * 0.012,
              ),
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext a) => const SearchPage())),
                  child: Container(
                    width: mwidth * 0.95,
                    height: mheight * 0.065,
                    decoration: BoxDecoration(
                        color: const Color(0xffF3F3F3),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        SizedBox(
                          width: mwidth * 0.045,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: mheight * 0.003),
                          child: const Icon(
                            Icons.search_rounded,
                            color: Color(0xff828282),
                            size: 25,
                          ),
                        ),
                        SizedBox(
                          width: mwidth * 0.03,
                        ),
                        SizedBox(
                            width: mwidth * 0.57,
                            child: const Center(
                                child: Text(
                              'Search by keyword or Brand',
                              style: TextStyle(
                                  color: Color(0xffA5A5A5),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ))),
                        SizedBox(
                          width: mwidth * 0.093,
                        ),
                        SizedBox(
                          height: mheight * 0.03,
                          width: mwidth * 0.075,
                          child: Image.asset(
                            'asset/Icons/mic_icon.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        // SizedBox(
                        //   width: mwidth * 0.023,
                        // ),
                        // Container(
                        //   height: mheight * 0.03,
                        //   width: mwidth * 0.075,
                        //   child: Image.asset(
                        //     'asset/Icons/camera_icon.png',
                        //     fit: BoxFit.contain,
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(content: Text('Double Tap To Exit',),),
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: mheight * 0.018,
            ),
            Center(
                child: SizedBox(
              width: mwidth * 0.953,
              height: mheight * 0.217,
              child: Container(
                width: mwidth * 0.953,
                height: mheight * 0.217,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(17)),
                child: const Home_Slider(),
              ),
            )),
            SizedBox(
              height: mheight * 0.02,
            ),
            Padding(
              padding: EdgeInsets.only(left: mwidth * 0.024),
              child: const Text(
                'Choose Brand',
                style: TextStyle(
                    color: Color(0xff000000),
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
              ),
            ),
            const ChooseBrand(),
            SizedBox(
              height: mheight * 0.005,
            ),
            Row(
              children: [
                SizedBox(
                  width: mwidth * 0.024,
                ),
                const Text(
                  'Trending Now',
                  style: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  width: mwidth * 0.49,
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext a) => const SeeAllTrendingNow())),
                  child: const Text(
                    'See all',
                    style: TextStyle(
                        color: Color(0xff264050),
                        fontWeight: FontWeight.w400,
                        fontSize: 18),
                  ),
                )
              ],
            ),
            SizedBox(
              height: mheight * 0.018,
            ),
            Padding(
                padding: EdgeInsets.only(left: mwidth * 0.035),
                child: SizedBox(
                    height: mheight * 0.27, width: mwidth, child: const TrendingNow())),
            SizedBox(
              height: mheight * 0.0165,
            ),
            Row(
              children: [
                SizedBox(
                  width: mwidth * 0.024,
                ),
                const Text(
                  'Best Offer',
                  style: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  width: mwidth * 0.58,
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext a) => const SeeAllBestoffer())),
                  child: const Text(
                    'See all',
                    style: TextStyle(
                        color: Color(0xff264050),
                        fontWeight: FontWeight.w400,
                        fontSize: 18),
                  ),
                )
              ],
            ),
            SizedBox(
              height: mheight * 0.018,
            ),
            Padding(
              padding:EdgeInsets.only(left: mwidth * 0.035) ,
              child: SizedBox(height: mheight * 0.27, child: const Bestoffer()),
            )
          ]),
        ),
      ),
    );
  }
}
