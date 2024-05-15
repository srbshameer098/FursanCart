import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fursan_cart/Ui/Screens/Bottom_Navigation_Screens/selected_product.dart';
import 'package:fursan_cart/bloc/Trendingnow/trendingnow_bloc.dart';
import 'package:lottie/lottie.dart';


import '../../../../../repository/model_class/Product/ProductModel.dart';
import '../../../../Widgets/shimmer.dart';

class TrendingNow extends StatefulWidget {
  const TrendingNow({super.key});

  @override
  State<TrendingNow> createState() => _TrendingNowState();
}

class _TrendingNowState extends State<TrendingNow> {
  late List<ProductModel> trendingnow;

  @override
  void initState() {
    BlocProvider.of<TrendingnowBloc>(context).add(FetchTrendingNow());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mwidth = MediaQuery.of(context).size.width;
    var mheight = MediaQuery.of(context).size.height;
    return BlocBuilder<TrendingnowBloc, TrendingnowState>(
        builder: (context, state) {
      if (state is TrendingnowblocLoading) {
        return ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) {
            return ShimmerWidget.rectangular(
              width: mwidth * 0.43,
              height: mheight * 0.27,
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
      if (state is TrendingnowblocError) {
        return RefreshIndicator(
          onRefresh: () async {
            return BlocProvider.of<TrendingnowBloc>(context)
                .add(FetchTrendingNow());
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
      if (state is TrendingnowblocLoaded) {
        trendingnow = BlocProvider.of<TrendingnowBloc>(context).productModel;
        return trendingnow.isEmpty?Center(
          child: Lottie.asset('asset/Animations/nodata.json',
              repeat: true,
              reverse: true,
              fit: BoxFit.cover,
              height: mheight * 0.3),
        ):ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount:trendingnow.length,
          itemBuilder: (BuildContext context, int index) => GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext a) => Selected_Product(
                      productid: trendingnow[index].id??'',
                    ))),
            child: Stack(children: [
              Container(
                width: mwidth * 0.43,
                height: mheight * 0.27,
                decoration: BoxDecoration(
                    color:  const Color(0xffEFEEEE),
                    borderRadius: BorderRadius.circular(10)),
              ),
              Positioned(
                top: mheight * 0.172,
                left: mwidth * 0.01,
                child: Container(
                  width: mwidth * 0.41,
                  height: mheight * 0.09,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: mwidth * 0.023, top: mheight * 0.01),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          trendingnow[index].name.toString()??'',
                          style: const TextStyle(
                              color: Color(0xff000000),
                              fontSize: 12.5,
                              fontWeight: FontWeight.w400),
                          maxLines: 2,
                        ),
                        SizedBox(
                          height: mheight * 0.005,
                        ),
                        SizedBox(
                          height: mheight * 0.005,
                        ),
                        Row(
                          children: [trendingnow[index].price==null?const Text(''):
                            Text('SAR ${trendingnow[index].price}',
                              style: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Color(0xff999595),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11),
                            ),
                            SizedBox(
                              width: mwidth * 0.012,
                            ),
            trendingnow[index].discountedAmount==null?const Text(''):
            Text('SAR ${trendingnow[index].discountedAmount}',
              style: const TextStyle(
                  color: Color(0xff999595),
                  fontWeight: FontWeight.w500,
                  fontSize: 11),
            ),])
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                  left: mwidth * 0.039,
                  top: mheight * 0.0231,
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10))),
                    width: mwidth * 0.35,
                    height: mheight * 0.13,
                    child: trendingnow[index].images!.isEmpty?Image.asset('asset/Images/placeholder.jpg',fit: BoxFit.cover,):Image.network(
                          trendingnow[index].images!.first.url.toString(),
                      fit: BoxFit.cover,
                    ),
                  ))
            ]),
          ),
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              width: mwidth * 0.0265,
            );
          },
        );
      } else {
        return Container();
      }
    });
  }
}
