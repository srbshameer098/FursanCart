import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fursan_cart/Ui/Screens/Bottom_Navigation_Screens/Home/bestoffer/bestoffer_selected_product.dart';
import 'package:fursan_cart/Ui/Screens/Bottom_Navigation_Screens/Cart/cart_page.dart';
import 'package:fursan_cart/Ui/Screens/Bottom_Navigation_Screens/favourites.dart';
import 'package:lottie/lottie.dart';

import '../../../../../bloc/Bestoffer/bestoffer_bloc.dart';


import '../../../../Widgets/shimmer.dart';
class SeeAllBestoffer extends StatefulWidget {
  const SeeAllBestoffer({super.key});

  @override
  State<SeeAllBestoffer> createState() => _SeeAllBestofferState();
}

late List<dynamic> bestoffer;

class _SeeAllBestofferState extends State<SeeAllBestoffer> {
  @override
  void initState() {
    BlocProvider.of<BestofferBloc>(context).add(FetchBestOffer());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mwidth = MediaQuery.of(context).size.width;
    var mheight = MediaQuery.of(context).size.height;
    final double itemHeight = mheight*0.27;
    final double itemWidth = mwidth*0.43;

    return Scaffold(
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
            'Best Offers',
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400),
          ),
        ]),
        actions: [

          SizedBox(
            width: mwidth * 0.025,
          ),
          GestureDetector(onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext a)=>const Favourate_Product())),
            child: const Icon(
              Icons.favorite_outline,
              color: Color(0xff636363),
              size: 20,
            ),
          ),
          SizedBox(
            width: mwidth * 0.025,
          ),
          GestureDetector(onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext a)=>const Cart_Page())),
            child: SizedBox(
              width: mwidth * 0.06,
              height: mheight * 0.04,
              child: Stack(children: [
                Positioned(
                  top: mheight * 0.0312,
                  child: const Icon(
                    Icons.shopping_cart_outlined,
                    color: Color(0xff636363),
                    size: 19.36,
                  ),
                ),
                Positioned(
                    top: mheight * 0.0238,
                    left: mwidth * 0.0383,
                    child: Container(
                      width: mwidth * 0.017,
                      height: mheight * 0.017,
                      decoration: const BoxDecoration(
                          color: Colors.red, shape: BoxShape.circle),
                    ))
              ]),
            ),
          ),
          SizedBox(
            width: mwidth * 0.04,
          )
        ],
      ),
      body: BlocBuilder<BestofferBloc, BestofferState>(
        builder: (context, state) {
          if (state is BestofferblocLoading) {
            return GridView.count(
                childAspectRatio: (itemWidth / itemHeight),
                padding: EdgeInsets.only(
                    top: mheight * 0.02,
                    left: mwidth * 0.03,
                    right: mwidth*0.03),
                crossAxisCount: 2,
                crossAxisSpacing: mwidth * 0.0265,
                mainAxisSpacing:mwidth * 0.0265,
                controller: ScrollController(keepScrollOffset: false),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: List.generate(
                  14,
                      (index) {
                    return ShimmerWidget.rectangular(width: mwidth * 0.43,
                      height: mheight * 0.27,shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    );
                  },
                ));
          }
          if (state is BestofferblocError) {
            return RefreshIndicator(
              onRefresh: () async {
                return BlocProvider.of<BestofferBloc>(context)
                    .add(FetchBestOffer());
              },
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * .9,
                  // color: Colors.red,
                  child: Center(
                    child: Lottie.asset('asset/Animations/oopssomethingwentwrong.json',
                        repeat: true,
                        reverse: true,
                        fit: BoxFit.cover,
                        height: mheight * 0.3),
                  )
                ),
              ),
            );
          }
          if (state is BestofferblocLoaded) {
            bestoffer = BlocProvider.of<BestofferBloc>(context).bestoffer;
            return SafeArea(
              child: bestoffer.isEmpty?Center(
                child: Lottie.asset('asset/Animations/nodata.json',
                    repeat: true,
                    reverse: true,
                    fit: BoxFit.cover,
                    height: mheight * 0.3),):GridView.count(
                  childAspectRatio: (itemWidth / itemHeight),
                  padding: EdgeInsets.only(
                      top: mheight * 0.02,
                      left: mwidth * 0.03,
                  right: mwidth*0.03),
                  crossAxisCount: 2,
                  crossAxisSpacing: mwidth * 0.0265,
                  mainAxisSpacing:mwidth * 0.0265,
                  controller: ScrollController(keepScrollOffset: false),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: List.generate(
                    bestoffer.length,
                        (index) {
                      return GestureDetector(
                        onTap: () =>  Navigator.of(context).push(MaterialPageRoute(
                                 builder: (BuildContext a) =>
                                      Bestoffer_Selected_Product(
                                      bannersubid: bestoffer[index].subCategoryId??'',
                                       productname: bestoffer[index].bannerTitle??''))),
                        child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child:bestoffer[index].banner!.isEmpty?Image.asset('asset/Images/placeholder.jpg',fit: BoxFit.cover,): Image.network(
                                            bestoffer[index]
                                                .banner!
                                                .first
                                                .url
                                                .toString(),
                                        fit: BoxFit.cover,
                                      )),
                                ),
                      );
                    },
                  )),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
