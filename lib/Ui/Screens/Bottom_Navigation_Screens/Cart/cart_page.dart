import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fursan_cart/bloc/DecreaseCartQuantity/decrease_cart_quantity_bloc.dart';
import 'package:fursan_cart/bloc/GetCart/get_cart_bloc.dart';
import 'package:fursan_cart/bloc/RemoveCart/remove_cart_bloc.dart';
import 'package:fursan_cart/main.dart';
import 'package:lottie/lottie.dart';

import '../../../../bloc/AddCart/add_to_cart_bloc.dart';

import '../../../../repository/model_class/GetCart/GetCartModel.dart';
import '../../../Widgets/toast_message.dart';
import '../cart_order_summary.dart';

class Cart_Page extends StatefulWidget {
  const Cart_Page({super.key});

  @override
  State<Cart_Page> createState() => _Cart_PageState();
}

class _Cart_PageState extends State<Cart_Page> {
  @override
  void initState() {
    BlocProvider.of<GetCartBloc>(context).add(FetchGetCart());

    // TODO: implement initState
    super.initState();
  }

  late GetCartModel cartitems;
  List<bool> checkboxvalues = [];
  double totalprice = 0;
  double originalprice = 0;
  late int activeIndex;
  int totalQuantity=0;
  List<CartProducts> selectedproducts = [];
  @override
  Widget build(BuildContext context) {
    print(initial);
    var mwidth = MediaQuery.of(context).size.width;
    var mheight = MediaQuery.of(context).size.height;

    return initial == 1
        ? Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Lottie.asset('asset/Animations/emptybox.json',
                  repeat: true,
                  reverse: true,
                  fit: BoxFit.cover,
                  height: mheight * 0.3),
            ))
        : Scaffold(
            bottomSheet: totalprice != 0
                ? Container(
                    width: mwidth,
                    height: mheight * 0.113,
                    color: const Color(0xffF2F2F2),
                    child: Row(
                      children: [
                        SizedBox(
                          width: mwidth * 0.05,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: mheight * 0.044,
                            ),

                            Text(
                              'Total ${totalprice.toStringAsFixed(2)}/-',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 19),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: mwidth * 0.18,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (totalprice > 0) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext a) => CartOrderSummary(
                                        selectedproducts: selectedproducts,
                                        price: double.parse(
                                            originalprice.toString()),
                                        discountAmount:
                                            double.parse(totalprice.toString()), quantity: totalQuantity,
                                      )));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Invalid Amount')));
                            }
                          },
                          child: Container(
                            width: mwidth * 0.3,
                            height: mheight * 0.05,
                            decoration: BoxDecoration(
                                color: const Color(0xffFF7322),
                                borderRadius: BorderRadius.circular(8)),
                            child: const Center(
                              child: Text(
                                'Continue',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : const SizedBox(),
            appBar: AppBar(
              title: const Text(
                'Cart',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 1,
            ),
            backgroundColor: Colors.white,
            body: bottomNavigationCart==false?screen(context):DoubleBackToCloseApp( snackBar: const SnackBar(
              content: Text(
                'Double Tap To Exit',
              ),
            ),child: screen(context)));
  }
  Widget screen(BuildContext context){
    var mwidth = MediaQuery.of(context).size.width;
    var mheight = MediaQuery.of(context).size.height;
    return  BlocBuilder<GetCartBloc, GetCartState>(
        builder: (context, state) {
          if (state is GetCartblocloading) {
            return Center(
              child: Lottie.asset('asset/Animations/shoppingcart.json',
                  repeat: true,
                  reverse: true,
                  fit: BoxFit.cover,
                  height: mheight * 0.15),
            );
          }
          if (state is GetCartblocerror) {
            return RefreshIndicator(
              onRefresh: () async {
                return BlocProvider.of<GetCartBloc>(context)
                    .add(FetchGetCart());
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
          if (state is GetCartblocloaded) {
            cartitems =
                BlocProvider.of<GetCartBloc>(context).getcartmodel;
            return cartitems.cartProducts == null ||
                cartitems.cartProducts!.isEmpty
                ? Center(
              child: Lottie.asset('asset/Animations/emptybox.json',
                  repeat: true,
                  reverse: true,
                  fit: BoxFit.cover,
                  height: mheight * 0.3),
            )
                : ListView.builder(
                itemCount: cartitems.cartProducts!.length,
                padding: EdgeInsets.only(top: mheight * 0.0045),
                itemBuilder: (BuildContext context, int index) {
                  for (int i = 0; i < cartitems.cartProducts!.length; i++) {
                    checkboxvalues.add(false);
                  }
                  double price = double.parse(cartitems
                      .cartProducts!.isEmpty ||
                      cartitems.cartProducts![index].productVarient ==
                          null ||cartitems.cartProducts![index].productVarient!.product==null||
                      cartitems.cartProducts![index].productVarient!.product!.discountedAmount==
                          null
                      ? ''
                      : cartitems.cartProducts![index].productVarient!.product!.discountedAmount
                      .toString());
                  print(price.toString());
                  return Card(
                    elevation: 2,
                    child: SizedBox(
                      width: mwidth,
                      height: mheight * 0.21,
                      child: ListTileTheme(
                        horizontalTitleGap: 0,
                        contentPadding: EdgeInsets.zero,
                        minVerticalPadding: mheight * 0.013,
                        child: CheckboxListTile(
                          value: checkboxvalues[index],
                          onChanged: (value) {
                            setState(() {
                              checkboxvalues[index] =
                              !checkboxvalues[index];
                              activeIndex = index;
                            });
                            if (checkboxvalues[index] == true) {
                              int quantity = cartitems
                                  .cartProducts!.isEmpty ||
                                  cartitems.cartProducts![index]
                                      .quantity ==
                                      null
                                  ? 0
                                  : cartitems
                                  .cartProducts![index].quantity!;
                              totalprice = totalprice +
                                  double.parse(cartitems.cartProducts![index].productVarient!.product!.discountedAmount
                                      .toString()) *
                                      quantity;

                              originalprice = totalprice +
                                  double.parse(cartitems.cartProducts![index].productVarient!.product!
                                      .price
                                      .toString()) *
                                      quantity;
                              if (cartitems
                                  .cartProducts!.isNotEmpty ||
                                  cartitems.cartProducts == null) {
                                selectedproducts.add(
                                    cartitems.cartProducts![index]);
                                print(selectedproducts);
                              }
                              if(cartitems
                                  .cartProducts!.isNotEmpty ||
                                  cartitems.cartProducts![index]
                                      .quantity !=
                                      null)
                              {

                                totalQuantity=totalQuantity+cartitems
                                    .cartProducts![index].quantity!;

                              }
                            }
                            if (checkboxvalues[index] == false) {
                              if (totalprice > 0) {
                                int quantity = cartitems
                                    .cartProducts!.isEmpty ||
                                    cartitems.cartProducts![index]
                                        .quantity ==
                                        null
                                    ? 0
                                    : cartitems.cartProducts![index]
                                    .quantity!;
                                totalprice = totalprice -
                                    double.parse(cartitems
                                        .cartProducts!
                                        .isEmpty ||
                                        cartitems
                                            .cartProducts![
                                        index]
                                            .productVarient ==
                                            null ||
                                        cartitems
                                            .cartProducts![
                                        index]
                                            .productVarient!
                                            .product ==
                                            null
                                        ? ''
                                        : cartitems.cartProducts![index].productVarient!.product!.discountedAmount
                                        .toString()) *
                                        quantity;
                                originalprice = totalprice -
                                    double.parse(cartitems.cartProducts![index].productVarient!.product!
                                        .price
                                        .toString()) *
                                        quantity;
                                if (cartitems
                                    .cartProducts!.isNotEmpty ||
                                    cartitems.cartProducts == null) {
                                  selectedproducts.remove(
                                      cartitems.cartProducts![index]);
                                  print(selectedproducts);
                                }
                                if(cartitems
                                    .cartProducts!.isNotEmpty ||
                                    cartitems.cartProducts![index]
                                        .quantity !=
                                        null)
                                {

                                  totalQuantity=totalQuantity-cartitems
                                      .cartProducts![index].quantity!;

                                }
                              }
                            }
                          },
                          activeColor: const Color(0xff264050),
                          controlAffinity:
                          ListTileControlAffinity.leading,
                          visualDensity: const VisualDensity(
                              horizontal: 0, vertical: 0),
                          title: Row(
                            children: [
                              SizedBox(
                                width: mwidth * 0.25,
                                height: mheight * 0.12,
                                child: cartitems
                                    .cartProducts!.isEmpty ||
                                    cartitems.cartProducts![index]
                                        .productVarient ==
                                        null ||
                                    cartitems
                                        .cartProducts![index]
                                        .productVarient!.product!.images==null ||
                                    cartitems
                                .cartProducts![index]
                                .productVarient!.product!.images!
                                        .first
                                        .url ==
                                        null
                                    ? Image.asset(
                                  'asset/Images/placeholder.jpg',
                                  fit: BoxFit.cover,
                                )
                                    : Image.network(
                                  cartitems
                                      .cartProducts![index]
                                      .productVarient!.product!.images!
                                      .first
                                      .url
                                          .toString(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                width: mwidth * 0.033,
                              ),
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: mheight * 0.047,
                                  ),
                                  SizedBox(
                                    width: mwidth * 0.5,
                                    child: Text(
                                      cartitems.cartProducts!
                                          .isEmpty ||
                                          cartitems
                                              .cartProducts![
                                          index].productVarient==
                                              null ||
                                          cartitems
                                              .cartProducts![
                                          index]
                                              .productVarient!
                                              .product ==
                                              null
                                          ? ''
                                          : cartitems
                                          .cartProducts![index]
                                          .productVarient!
                                          .product!.name
                                          .toString(),
                                      maxLines: 1,
                                      style: const TextStyle(
                                          color: Color(0xff1D1D1B),
                                          fontSize: 12,
                                          fontWeight:
                                          FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    height: mheight * 0.01,
                                  ),
                                  RatingBar.builder(
                                      itemCount: 5,
                                      initialRating: 3,
                                      allowHalfRating: true,
                                      itemSize: 18,
                                      itemBuilder: (ctx, index) =>
                                          const Icon(
                                            Icons.star,
                                            color: Color(0xffF3603F),
                                          ),
                                      onRatingUpdate: (value) {
                                        print(value);
                                      }),
                                  SizedBox(
                                    height: mheight * 0.008,
                                  ),Row(children:[cartitems.cartProducts!.isEmpty ||
                                      cartitems
                                          .cartProducts![
                                      index]
                                          .productVarient ==
                                          null ||
                                      cartitems
                                          .cartProducts![
                                      index]
                                          .productVarient!.product!.price==
                                          null?const Text('',style:  TextStyle(
                                      fontWeight:
                                      FontWeight.w400,
                                      fontSize: 11,
                                      color:
                                      Color(0xff7C7C7C)),):Text('SAR ${cartitems
                                      .cartProducts![
                                  index]
                                      .productVarient!.product!.price
                                      }',
                                    style: const TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        color: Color(0xff999595),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11),
                                  ),SizedBox(
                                    width: mwidth * 0.025,
                                  ),
                                    cartitems.cartProducts!.isEmpty ||
                                        cartitems
                                            .cartProducts![
                                        index]
                                            .productVarient ==
                                            null
                                        ? const Text(
                                      '',
                                      style: TextStyle(
                                          fontWeight:
                                          FontWeight.w400,
                                          fontSize: 12,
                                          color:
                                          Color(0xff7C7C7C)),
                                    )
                                        : Text(
                                      'SAR ${cartitems
                                              .cartProducts![
                                          index]
                                              .productVarient!.product!
                                              .discountedAmount}',
                                      style: const TextStyle(
                                          fontWeight:
                                          FontWeight.w400,
                                          fontSize: 12,
                                          color:
                                          Color(0xff7C7C7C)),
                                    ),]),
                                  SizedBox(
                                    height: mheight * 0.012,
                                  ),
                                  Row(
                                    children: [
                                      BlocListener<
                                          DecreaseCartQuantityBloc,
                                          DecreaseCartQuantityState>(
                                        listener: (context, state) {
                                          if (state
                                          is DecreseCartQuantityblocLoaded) {
                                            print('loaded');
                                            BlocProvider.of<
                                                GetCartBloc>(
                                                context)
                                                .add(FetchGetCart());
                                            ToastMessage().toastmessage(
                                                message:
                                                'Quantity Decreased');
                                          }
                                          if (state
                                          is DecreseCartQuantityblocLoading) {
                                            print('loading');
                                          }
                                          if (state
                                          is DecreseCartQuantityblocError) {
                                            ToastMessage().toastmessage(
                                                message:
                                                'Oops Something Went Wrong');
                                          }

                                          // TODO: implement listener
                                        },
                                        child: GestureDetector(
                                          onTap: () {
                                            BlocProvider.of<
                                                DecreaseCartQuantityBloc>(
                                                context)
                                                .add(FetchDecreaseCartQuantity(
                                                cartitemid: cartitems
                                                    .cartProducts!
                                                    .isEmpty ||
                                                    cartitems
                                                        .cartProducts![
                                                    index]
                                                        .id ==
                                                        null
                                                    ? ''
                                                    : cartitems
                                                    .cartProducts![
                                                index].id
                                                    .toString(),
                                                quantity: 1));
                                          },
                                          child: Container(
                                            width: mwidth * 0.125,
                                            height: mheight * 0.03,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius
                                                    .circular(5),
                                                border: Border.all(
                                                    color: const Color(
                                                        0xffEEEEEE))),
                                            child: const Center(
                                              child: Icon(
                                                Icons
                                                    .horizontal_rule_rounded,
                                                color:
                                                Color(0xff929292),
                                                size: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: mwidth * 0.01,
                                      ),
                                      Container(
                                        width: mwidth * 0.135,
                                        height: mheight * 0.03,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(
                                                5),
                                            border: Border.all(
                                                color: const Color(
                                                    0xffEEEEEE))),
                                        child: Center(
                                            child: Text(
                                              cartitems.cartProducts!
                                                  .isEmpty ||
                                                  cartitems
                                                      .cartProducts![
                                                  index]
                                                      .quantity ==
                                                      null
                                                  ? ''
                                                  : cartitems
                                                  .cartProducts![
                                              index]
                                                  .quantity
                                                  .toString(),
                                              style: const TextStyle(
                                                  color:
                                                  Color(0xff929292),
                                                  fontSize: 12),
                                            )),
                                      ),
                                      SizedBox(
                                        width: mwidth * 0.01,
                                      ),
                                      BlocListener<AddToCartBloc,
                                          AddToCartState>(
                                        listener: (context, state) {
                                          if (state
                                          is AddToCartblocLoaded) {
                                            print('loaded');
                                            BlocProvider.of<
                                                GetCartBloc>(
                                                context)
                                                .add(FetchGetCart());
                                            ToastMessage().toastmessage(
                                                message:
                                                'Quantity Increased');
                                          }
                                          if (state
                                          is AddToCartblocLoading) {
                                            print('loading');
                                          }
                                          if (state
                                          is AddToCartblocError) {
                                            ToastMessage().toastmessage(
                                                message:
                                                'Oops Something Went Wrong');
                                          }
                                          // TODO: implement listener
                                        },
                                        child: GestureDetector(
                                          onTap: () {
                                            if (checkboxvalues[
                                            index] ==
                                                true) {
                                              ToastMessage().toastmessage(
                                                  message:
                                                  'Unselect Your Item');
                                            }
                                            if (checkboxvalues[
                                            index] ==
                                                false) {
                                              BlocProvider.of<AddToCartBloc>(context).add(FetchAddToCart(
                                                  varientid: cartitems
                                                      .cartProducts!
                                                      .isEmpty ||
                                                      cartitems
                                                          .cartProducts![
                                                      index]
                                                          .productVarient ==
                                                          null ||
                                                      cartitems
                                                          .cartProducts![
                                                      index]
                                                          .productVarient!
                                                          .id ==
                                                          null
                                                      ? ''
                                                      : cartitems
                                                      .cartProducts![
                                                  index]
                                                      .productVarient!
                                                      .id,
                                                  quantity: 1));
                                            }
                                          },
                                          child: Container(
                                            width: mwidth * 0.125,
                                            height: mheight * 0.03,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius
                                                    .circular(5),
                                                border: Border.all(
                                                    color: const Color(
                                                        0xffEEEEEE))),
                                            child: const Center(
                                              child: Icon(
                                                Icons.add,
                                                color:
                                                Color(0xff929292),
                                                size: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: mheight * 0.014),
                                child: Column(
                                  children: [
                                    BlocListener<RemoveCartBloc,
                                        RemoveCartState>(
                                      listener: (context, state) {
                                        if (state
                                        is RemoveCartblocLoading) {
                                          print('loading');
                                        }
                                        if (state
                                        is RemoveCartblocLoaded) {
                                          if (totalprice > 0) {
                                            totalprice = totalprice -
                                                double.parse(cartitems
                                                    .cartProducts!
                                                    .isEmpty ||
                                                    cartitems
                                                        .cartProducts![
                                                    index]
                                                        .price ==
                                                        null
                                                    ? '0'
                                                    : cartitems
                                                    .cartProducts![
                                                index]
                                                    .price
                                                    .toString());
                                          }
                                          print(
                                              totalprice.toString());
                                          ToastMessage().toastmessage(
                                              message:
                                              'Item Removed From Cart');
                                          BlocProvider.of<
                                              GetCartBloc>(
                                              context)
                                              .add(FetchGetCart());
                                          print('loaded');
                                        }
                                        if (state
                                        is RemoveCartblocError) {
                                          ToastMessage().toastmessage(
                                              message:
                                              'Oops Something Went Wrong');
                                        }
                                        // TODO: implement listener
                                      },
                                      child: GestureDetector(
                                        onTap: () {
                                          if (checkboxvalues[index] ==
                                              true) {
                                            ToastMessage().toastmessage(
                                                message:
                                                'Unselect Your Removable Item');
                                          }

                                          if (checkboxvalues[index] ==
                                              false) {
                                            BlocProvider.of<
                                                RemoveCartBloc>(
                                                context)
                                                .add(FetchRemoveCart(
                                                cartproductid: cartitems
                                                    .cartProducts!
                                                    .isEmpty ||
                                                    cartitems
                                                        .cartProducts![
                                                    index]
                                                        .id ==
                                                        null
                                                    ? ''
                                                    : cartitems
                                                    .cartProducts![
                                                index]
                                                    .id));
                                          }
                                        },
                                        child: const Icon(
                                          Icons.close,
                                          size: 22,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return Container();
          }
        });
  }

  @override
  void dispose() {
    bottomNavigationCart=true;
    super.dispose();
    initial = 0;
  }
}
