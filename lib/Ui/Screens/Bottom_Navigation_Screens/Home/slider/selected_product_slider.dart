import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


import '../../../../../repository/model_class/SelectedProductModel/SelectedProductModel.dart';

class Selected_Product_Slider extends StatefulWidget {
  final SelectedProductModel;

  const Selected_Product_Slider({super.key, required this.SelectedProductModel});

  @override
  State<Selected_Product_Slider> createState() =>
      _Selected_Product_SliderState();
}

int _activeindex = 0;
final _controller = CarouselController();

class _Selected_Product_SliderState extends State<Selected_Product_Slider> {
  @override
  Widget build(BuildContext context) {
    var mwidth = MediaQuery.of(context).size.width;
    var mheight = MediaQuery.of(context).size.height;
    SelectedProductModel selectedProductModel = widget.SelectedProductModel;
    return Stack(
      children: [
        selectedProductModel.product!.images!.isEmpty
            ?Center(
          child: Lottie.asset('asset/Animations/nodata.json',
              repeat: true,
              reverse: true,
              fit: BoxFit.cover,
              height: mheight * 0.3),
        )
            : CarouselSlider.builder(
                itemCount: selectedProductModel.product!.images!.length,
                itemBuilder: (context, index, realindex) {
                  var height = mheight * 0.335;
                  var width = mwidth;
                  return SizedBox(
                    width: width,
                    height: height,
                    child: selectedProductModel.product!.images!.isEmpty
                        ? Image.asset(
                            'asset/Images/placeholder.jpg',
                            fit: BoxFit.contain,
                          )
                        : Image.network(
                                selectedProductModel.product!.images![index].url.toString(),
                            fit: BoxFit.contain,
                          ),
                  );
                },
                carouselController: _controller,
                options: CarouselOptions(
                  onPageChanged: (index, reason) =>
                      setState(() => _activeindex = index),
                  viewportFraction: 1,
                  height: mheight * 0.335,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                )),
        Positioned(
            left: mwidth * 0.41,
            bottom: mheight * 0.008,
            child: indicator(
                context,
                selectedProductModel.product!.images!.isEmpty
                    ? 0
                    : selectedProductModel.product!.images!.length)),
      ],
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
