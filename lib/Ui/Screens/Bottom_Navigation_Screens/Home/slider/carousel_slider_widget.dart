import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fursan_cart/bloc/Slider/slider_bloc.dart';
import 'package:lottie/lottie.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../../repository/model_class/SliderModel/SliderModel.dart';
import '../../../../Widgets/shimmer.dart';

class Home_Slider extends StatefulWidget {
  const Home_Slider({super.key});

  @override
  State<Home_Slider> createState() => _Home_SliderState();
}

late List<SliderModel> bannerimg;

class _Home_SliderState extends State<Home_Slider> {
  @override
  void initState() {
    BlocProvider.of<SliderBloc>(context).add(FetchSlider());
    // TODO: implement initState
    super.initState();
  }

  int _activeindex = 0;
  final _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    var mwidth = MediaQuery.of(context).size.width;
    var mheight = MediaQuery.of(context).size.height;
    return BlocBuilder<SliderBloc, SliderState>(
      builder: (context, state) {
        if (state is SliderblocLoading) {
          return ShimmerWidget.rectangular(
            height: mheight * 0.235,
            width: mwidth * 0.95,
            shapeBorder:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
          );
        }
        if (state is SliderblocError) {
          return RefreshIndicator(
            onRefresh: () async {
              return BlocProvider.of<SliderBloc>(context).add(FetchSlider());
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
        if (state is SliderblocLoaded) {
          print("loaded");
          bannerimg = BlocProvider.of<SliderBloc>(context).bannerModel;
          print(bannerimg);
          return Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(17),
                child:bannerimg.isEmpty?Center(
                  child: Lottie.asset('asset/Animations/nodata.json',
                      repeat: true,
                      reverse: true,
                      fit: BoxFit.cover,
                      height: mheight * 0.3),
                ):CarouselSlider.builder(
                    itemCount:bannerimg.length,
                    itemBuilder: (context, index, realindex) {
                      var height = mheight * 0.235;
                      var width = mwidth * 0.95;
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(17),
                        ),
                        width: width,
                        height: height,
                        child:bannerimg[index].banner!.isEmpty?Image.asset('asset/Images/placeholder.jpg',fit: BoxFit.cover,): Image.network(
                              bannerimg[index].banner!.first.url.toString(),
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                    carouselController: _controller,
                    options: CarouselOptions(
                      onPageChanged: (index, reason) =>
                          setState(() => _activeindex = index),
                      viewportFraction: 1,
                      height: mheight * 0.235,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                    )),
              ),
              Positioned(
                  left: mwidth * 0.41,
                  bottom: mheight * 0.008,
                  child: indicator(context, bannerimg.isEmpty?0:bannerimg.length))
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget indicator(BuildContext context, int count) {
    var mwidth = MediaQuery.of(context).size.width;
    var mheight = MediaQuery.of(context).size.height;
    return Container(
      width: mwidth * 0.158,
      height: mheight * 0.018,
      decoration: BoxDecoration(
          color: Colors.black12, borderRadius: BorderRadius.circular(12)),
      child: Center(
        child: AnimatedSmoothIndicator(
          activeIndex: _activeindex,
          count: count,
          effect: const JumpingDotEffect(
              dotWidth: 7,
              dotHeight: 7,
              activeDotColor: Color(0xfff2ec52),
              dotColor: Colors.white),
        ),
      ),
    );
  }
}
