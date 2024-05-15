import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fursan_cart/Ui/Screens/Bottom_Navigation_Screens/Home/bestoffer/bestoffer_selected_product.dart';
import 'package:fursan_cart/bloc/Bestoffer/bestoffer_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../../repository/model_class/BestOffer/BestOfferModel.dart';
import '../../../../Widgets/shimmer.dart';

class Bestoffer extends StatefulWidget {
  const Bestoffer({super.key});

  @override
  State<Bestoffer> createState() => _BestofferState();
}

late List<BestOfferModel> bestoffer;

class _BestofferState extends State<Bestoffer> {
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
    return BlocBuilder<BestofferBloc, BestofferState>(
      builder: (context, state) {
        if (state is BestofferblocLoading) {
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (BuildContext context, int index) {
              return ShimmerWidget.rectangular(
                width: mwidth * 0.43,
                height: mheight * 0.265,
                shapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              width: mwidth * 0.0265,
            );
          },
          );
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
                    child: Lottie.asset(
                        'asset/Animations/oopssomethingwentwrong.json',
                        repeat: true,
                        reverse: true,
                        fit: BoxFit.cover,
                        height: mheight * 0.3),
                  )),
            ),
          );
        }
        if (state is BestofferblocLoaded) {
          bestoffer = BlocProvider.of<BestofferBloc>(context).bestoffer;
          return bestoffer.isEmpty
              ? Center(
                  child: Lottie.asset('asset/Animations/nodata.json',
                      repeat: true,
                      reverse: true,
                      fit: BoxFit.cover,
                      height: mheight * 0.3),
                )
              : ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: bestoffer.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext a) =>
                              Bestoffer_Selected_Product(
                                bannersubid:
                                    bestoffer[index].subCategoryId ?? '',
                                productname: bestoffer[index].bannerTitle ?? '',
                              ))),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            width: mwidth * 0.43,
                            height: mheight * 0.265,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: bestoffer[index].banner!.isEmpty
                                    ? Image.asset(
                                        'asset/Images/placeholder.jpg',
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        bestoffer[index]
                                                .banner!
                                                .first
                                                .url.toString(),
                                        fit: BoxFit.cover,
                                      )),
                          ),
                        ],
                      ),
                    );
                  },separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              width: mwidth * 0.0265,
            );
          },

                );
        } else {
          return Container();
        }
      },
    );
  }
}
