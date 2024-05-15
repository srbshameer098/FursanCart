import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fursan_cart/Ui/Screens/Bottom_Navigation_Screens/Cart/cart_page.dart';
import 'package:fursan_cart/bloc/SubCategorySelectedItem/subcategoryselecteditem_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../bloc/AddFavourates/post_favourates_bloc.dart';
import '../../../../repository/model_class/Product/ProductModel.dart';
import '../../../Widgets/toast_message.dart';
import '../favourites.dart';
import '../selected_product.dart';

class SubCategorySelectedItem extends StatefulWidget {
  final subcategoryid;

  const SubCategorySelectedItem({super.key, required this.subcategoryid});

  @override
  State<SubCategorySelectedItem> createState() =>
      _SubCategorySelectedItemState();
}

class _SubCategorySelectedItemState extends State<SubCategorySelectedItem> {
  late List<ProductModel> subcategoryselecteditem;

  @override
  void initState() {
    BlocProvider.of<SubcategoryselecteditemBloc>(context)
        .add(FetchSubCategorySelectedItem(subcategoryid: widget.subcategoryid));
    // TODO: implement initState
    super.initState();
  }
  TextEditingController keyvalue = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var mwidth = MediaQuery.of(context).size.width;
    var mheight = MediaQuery.of(context).size.height;
    print(widget.subcategoryid);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: mheight * 0.085,
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 1,
        title:isLoading==false? Row(children: [
          IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          const Text(
            'Products',
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400),
          ),
        ]):Padding(
          padding: EdgeInsets.only(left: mwidth*0.012),
          child: Container(
              width: mwidth * 0.68,
              height: mheight * 0.06,
              decoration: BoxDecoration(
                  color: const Color(0xffF3F3F3),
                  borderRadius: BorderRadius.circular(10)),
              child: TextFormField(controller: keyvalue,
                onChanged: (value) {
                  BlocProvider.of<SubcategoryselecteditemBloc>(context)
                      .add(FetchSubCategorySelectedItem(subcategoryid: widget.subcategoryid));
                },
                autofocus: true,
                decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.mic,
                      color: Color(0xff828282),
                      size: 25,
                    ),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: 'Search by keyword ',
                    hintStyle: TextStyle(
                        color: Color(0xffA5A5A5),
                        fontSize: 16,
                        fontWeight: FontWeight.w400)),
              )),
        ),
        actions: [
          GestureDetector(onTap: ()=>setState(() {
            isLoading=!isLoading;
          }),
            child: const Icon(
              Icons.search,
              color: Color(0xff828282),
              size: 23.5,
            ),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext a) => const Favourate_Product())),
            icon: const Icon(
              Icons.favorite_outline,
              color: Color(0xff636363),
              size: 20,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext a) => const Cart_Page())),
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
      body: BlocBuilder<SubcategoryselecteditemBloc,
          SubcategoryselecteditemState>(builder: (context, state) {
        if (state is SubCategoryselecteditemblocLoading) {
          return Center(
            child: Lottie.asset('asset/Animations/shoppingcart.json',
                repeat: true,
                reverse: true,
                fit: BoxFit.cover,
                height: mheight * 0.15),
          );
        }
        if (state is SubCategoryselecteditemblocError) {
          return RefreshIndicator(
            onRefresh: () async {
              return BlocProvider.of<SubcategoryselecteditemBloc>(context).add(
                  FetchSubCategorySelectedItem(
                      subcategoryid: widget.subcategoryid));
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
        if (state is SubCategoryselecteditemblocLoaded) {
          subcategoryselecteditem =
              BlocProvider.of<SubcategoryselecteditemBloc>(context)
                  .subcategoryselecteditemModel;
          return subcategoryselecteditem.isEmpty
              ? Center(
                  child: Lottie.asset('asset/Animations/nodata.json',
                      repeat: true,
                      reverse: true,
                      fit: BoxFit.cover,
                      height: mheight * 0.3),
                )
              : ListView.builder(
                  itemCount: subcategoryselecteditem.length,
                  itemBuilder: (BuildContext context, int index) {
                    if(keyvalue.text.isEmpty){
                    return Padding(
                      padding: EdgeInsets.only(top: mheight * 0.015),
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (BuildContext a) => Selected_Product(
                                    productid:
                                        subcategoryselecteditem[index].id ??
                                            ''))),
                        child:  Card(
                          elevation: 2,
                          child: SizedBox(
                            width: mwidth,
                            height: mheight * 0.16,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: mwidth * 0.026,
                                ),
                                SizedBox(
                                  width: mwidth * 0.27,
                                  height: mheight * 0.12,
                                  child: subcategoryselecteditem[index]
                                          .images!
                                          .isEmpty
                                      ? Image.asset(
                                          'asset/Images/placeholder.jpg',
                                          fit: BoxFit.cover,
                                        )
                                      : Image.network(
                                              subcategoryselecteditem[index]
                                                  .images!
                                                  .first
                                                  .url
                                                  .toString(),
                                          fit: BoxFit.cover,
                                        ),
                                ),
                                SizedBox(
                                  width: mwidth * 0.03,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: mheight * 0.028,
                                    ),
                                    SizedBox(
                                      width: mwidth * 0.5,
                                      child: Text(
                                        subcategoryselecteditem[index].name ==
                                                null
                                            ? ''
                                            : subcategoryselecteditem[index]
                                                .name
                                                .toString(),
                                        maxLines: 2,
                                        style: const TextStyle(
                                            color: Color(0xff1D1D1B),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    SizedBox(
                                      height: mheight * 0.01,
                                    ),
                                    RatingBar.builder(
                                        itemCount: 5,
                                        initialRating: 3,
                                        allowHalfRating: true,
                                        itemSize: 17,
                                        itemBuilder: (ctx, index) => const Icon(
                                              Icons.star,
                                              color: Color(0xffF3603F),
                                            ),
                                        onRatingUpdate: (value) {
                                          print(value);
                                        }),
                                    SizedBox(
                                      height: mheight * 0.01,
                                    ),
                                    Row(
                                        children: [subcategoryselecteditem[index].price==null?const Text(''):
                                        Text('SAR ${subcategoryselecteditem[index].price}',
                                          style: const TextStyle(
                                              decoration: TextDecoration.lineThrough,
                                              color: Color(0xff999595),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13),
                                        ),
                                          SizedBox(
                                            width: mwidth * 0.025,
                                          ),
                                          subcategoryselecteditem[index].discountedAmount==null?const Text(''):
                                          Text('SAR ${subcategoryselecteditem[index].discountedAmount}',
                                            style: const TextStyle(
                                                color: Color(0xff999595),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13),
                                          ),])
                                  ],
                                ),
                                SizedBox(
                                  width: mwidth * 0.01,
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      height: mheight * 0.0134,
                                    ),
                                    BlocListener<PostFavouratesBloc,
                                        PostFavouratesState>(
                                      listener: (context, state) {
                                        if (state
                                            is PostToFavourateblocLoading) {
                                          print('loading');
                                        }
                                        if (state
                                            is PostToFavourateblocLoaded) {


                                          ToastMessage().toastmessage(
                                              message:
                                                  'Item Added To Wishlist');
                                          print('loaded');
                                        }
                                        if (state is PostToFavourateblocError) {
                                          ToastMessage().toastmessage(
                                              message:
                                                  'Item Already In Wishlist');
                                          print('error');
                                        }
                                      },
                                      child:  IconButton(
                                              onPressed: () {
                                                BlocProvider.of<
                                                            PostFavouratesBloc>(
                                                        context)
                                                    .add(FetchAddToFavourates(
                                                        productid: subcategoryselecteditem[
                                                                        index]
                                                                    .id ==
                                                                null
                                                            ? ''
                                                            : subcategoryselecteditem[
                                                                    index]
                                                                .id
                                                                .toString()));
                                              },
                                              icon: const Icon(Icons.favorite,
                                                  color: Color(0xffFFC113),
                                                  size: 23)),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
    if(
    subcategoryselecteditem[index]
        .name!.toUpperCase().contains(keyvalue.text.toUpperCase())){
      return  Padding(
        padding: EdgeInsets.only(top: mheight * 0.03),
        child: GestureDetector(
          onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (BuildContext a) => Selected_Product(
                      productid:
                      subcategoryselecteditem[index].id ??
                          ''))),
          child:  Card(
            elevation: 2,
            child: SizedBox(
              width: mwidth,
              height: mheight * 0.16,
              child: Row(
                children: [
                  SizedBox(
                    width: mwidth * 0.026,
                  ),
                  SizedBox(
                    width: mwidth * 0.27,
                    height: mheight * 0.12,
                    child: subcategoryselecteditem[index]
                        .images!
                        .isEmpty
                        ? Image.asset(
                      'asset/Images/placeholder.jpg',
                      fit: BoxFit.cover,
                    )
                        : Image.network(
                          subcategoryselecteditem[index]
                              .images!
                              .first
                              .url
                              .toString(),
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: mwidth * 0.03,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: mheight * 0.028,
                      ),
                      SizedBox(
                        width: mwidth * 0.5,
                        child: Text(
                          subcategoryselecteditem[index].name ==
                              null
                              ? ''
                              : subcategoryselecteditem[index]
                              .name
                              .toString(),
                          maxLines: 2,
                          style: const TextStyle(
                              color: Color(0xff1D1D1B),
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        height: mheight * 0.01,
                      ),
                      RatingBar.builder(
                          itemCount: 5,
                          initialRating: 3,
                          allowHalfRating: true,
                          itemSize: 17,
                          itemBuilder: (ctx, index) => const Icon(
                            Icons.star,
                            color: Color(0xffF3603F),
                          ),
                          onRatingUpdate: (value) {
                            print(value);
                          }),
                      SizedBox(
                        height: mheight * 0.01,
                      ),
                      subcategoryselecteditem[index]
                          .discountedAmount ==
                          null
                          ? const Text('0',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Color(0xff7C7C7C)))
                          : Text(
                        'SAR ${subcategoryselecteditem[index]
                                .discountedAmount}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Color(0xff7C7C7C)),
                      )
                    ],
                  ),
                  SizedBox(
                    width: mwidth * 0.01,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: mheight * 0.0134,
                      ),
                      BlocListener<PostFavouratesBloc,
                          PostFavouratesState>(
                        listener: (context, state) {
                          if (state
                          is PostToFavourateblocLoading) {
                            print('loading');
                          }
                          if (state
                          is PostToFavourateblocLoaded) {

                            ToastMessage().toastmessage(
                                message:
                                'Item Added To Wishlist');
                            print('loaded');
                          }
                          if (state is PostToFavourateblocError) {
                            ToastMessage().toastmessage(
                                message:
                                'Item Already In Wishlist');
                            print('error');
                          }
                        },
                        child:  IconButton(
                            onPressed: () {
                              BlocProvider.of<
                                  PostFavouratesBloc>(
                                  context)
                                  .add(FetchAddToFavourates(
                                  productid: subcategoryselecteditem[
                                  index]
                                      .id ==
                                      null
                                      ? ''
                                      : subcategoryselecteditem[
                                  index]
                                      .id
                                      .toString()));
                            },
                            icon: const Icon(Icons.favorite,
                                color: Color(0xffFFC113),
                                size: 23)),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }
    return null;


                  });
        } else {
          return Container();
        }
      }),
    );
  }
  @override
  void dispose() {
    keyvalue.clear();
    // TODO: implement dispose
    super.dispose();
  }
}
