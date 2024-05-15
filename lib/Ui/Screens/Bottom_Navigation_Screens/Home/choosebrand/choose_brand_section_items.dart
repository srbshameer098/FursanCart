import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fursan_cart/Ui/Screens/Bottom_Navigation_Screens/Home/choosebrand/brand_selection.dart';
import 'package:fursan_cart/bloc/ChooseBrand/brand_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../../repository/model_class/Brand/BrandModel.dart';
import '../../../../Widgets/shimmer.dart';

class ChooseBrand extends StatefulWidget {
  const ChooseBrand({super.key});

  @override
  State<ChooseBrand> createState() => _ChooseBrandState();
}

class _ChooseBrandState extends State<ChooseBrand> {
  @override
  void initState() {
    BlocProvider.of<BrandBloc>(context).add(FetchChooseBrand());
    // TODO: implement initState
    super.initState();
  }

  late List<BrandModel> choosebrand;

  @override
  Widget build(BuildContext context) {
    var mwidth = MediaQuery.of(context).size.width;
    var mheight = MediaQuery.of(context).size.height;
    return BlocBuilder<BrandBloc, BrandState>(builder: (context, state) {
      if (state is ChooseBrandblocLoading) {
        return Container(
          padding: EdgeInsets.only(left: mwidth * 0.035),
          width: mwidth,
          height: mheight * 0.14,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: [
                  ShimmerWidget.rectangular(
                    width: mwidth * 0.21,
                    height: mheight * 0.1,
                    shapeBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  SizedBox(
                    width: mwidth * 0.0265,
                  )
                ],
              );
            },
          ),
        );
      }
      if (state is ChooseBrandblocError) {
        return RefreshIndicator(
          onRefresh: () async {
            return BlocProvider.of<BrandBloc>(context).add(FetchChooseBrand());
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
      if (state is ChooseBrandblocLoaded) {
        choosebrand = BlocProvider.of<BrandBloc>(context).chooseBrand;
        return Container(
          padding: EdgeInsets.only(left: mwidth * 0.035),
          width: mwidth,
          height: mheight * 0.14,
          child: choosebrand.isEmpty
              ? Center(
                  child: Lottie.asset('asset/Animations/nodata.json',
                      repeat: true,
                      reverse: true,
                      fit: BoxFit.cover,
                      height: mheight * 0.3),
                )
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: choosebrand.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      children: [
                        GestureDetector(
                          onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext a) => SeeAllBrand(
                                        brandname:
                                            choosebrand[index].name ?? '',
                                        brandid: choosebrand[index].id ?? '',
                                      ))),
                          child: Container(
                              width: mwidth * 0.21,
                              height: mheight * 0.1,
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(12)),
                              child: choosebrand[index].image == null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.asset(width: mwidth * 0.21,
                                        height: mheight * 0.1,
                                        'asset/Images/placeholder.jpg',
                                      ))
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(width: mwidth * 0.21,
                                        height: mheight * 0.1,
                                            choosebrand[index].image!.first.url.toString(),
                                      ),
                                    )),
                        ),
                        SizedBox(
                          width: mwidth * 0.0265,
                        )
                      ],
                    );
                  },
                ),
        );
      } else {
        return Container();
      }
    });
  }
}
