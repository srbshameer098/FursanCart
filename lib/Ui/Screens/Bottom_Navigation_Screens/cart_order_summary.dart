import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:fursan_cart/main.dart';
import 'package:lottie/lottie.dart';

import '../../../bloc/GetAllAddress/get_all_address_bloc.dart';
import '../../../repository/model_class/GetAllAddress/GetAllAddressModel.dart';
import '../../../repository/model_class/GetCart/GetCartModel.dart';
import '../../Widgets/toast_message.dart';
import 'Account/save_adress_page.dart';
import 'cart_payment_method.dart';

class CartOrderSummary extends StatefulWidget {
  final List<CartProducts> selectedproducts;
  final double price;
  final double discountAmount;
  final int quantity;

  const CartOrderSummary(
      {super.key,
      required this.selectedproducts,
      required this.price,
      required this.discountAmount,
      required this.quantity});

  @override
  State<CartOrderSummary> createState() => _CartOrderSummaryState();
}

class _CartOrderSummaryState extends State<CartOrderSummary> {
  @override
  void initState() {
    BlocProvider.of<GetAllAddressBloc>(context).add(FetchGetAllAddress());
    super.initState();
  }
  List<Map<String, dynamic>> ListOfCartItemId = [];
  List<GetAllAddressModel>? address;
  @override
  Widget build(BuildContext context) {
    var mwidth = MediaQuery.of(context).size.width;
    var mheight = MediaQuery.of(context).size.height;
    String price = widget.price.toStringAsFixed(2);
    List<CartProducts> selectedproducts1 = widget.selectedproducts;
    String discountAmount =
        (widget.price - widget.discountAmount).toStringAsFixed(2);
    double price1 = widget.price;
    double discountAmount1 = double.parse(discountAmount);
    String totalprice = (price1 - discountAmount1).toStringAsFixed(2);

    return Scaffold(
      backgroundColor: Colors.white,
      bottomSheet: SizedBox(
        width: mwidth,
        height: mheight * 0.108,
        child: Row(
          children: [
            SizedBox(
              width: mwidth * 0.04,
            ),
            Text(
              'SAR $totalprice',
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: mwidth * 0.265,
            ),
            TextButton(
              onPressed: () {
                if (selectedAddress != null) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext a) => CartPayment(addressId:selectedAddress!.id.toString(),
                            quantity: widget.quantity,
                            price: price1,
                            discountAmount: discountAmount1,
                            totalprice: double.parse(totalprice.toString()), ListOfCartItemId1: ListOfCartItemId,
                          )));
                } else {
                  ToastMessage()
                      .toastmessage(message: 'Please Select Your Address');
                }
              },
              child: Container(
                width: mwidth * 0.3,
                height: mheight * 0.05,
                decoration: BoxDecoration(
                    color: const Color(0xffFFC113),
                    borderRadius: BorderRadius.circular(8)),
                child: const Center(
                  child: Text(
                    'Continue',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        toolbarHeight: mheight * 0.085,
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                )),
            const Text(
              'Order Summary',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<GetAllAddressBloc, GetAllAddressState>(
            builder: (context, state) {
          if (state is GetAllAddressblocloading) {
            return const SizedBox();
          }
          if (state is GetAllAddressblocerror) {
            return RefreshIndicator(
              onRefresh: () async {
                return BlocProvider.of<GetAllAddressBloc>(context)
                    .add(FetchGetAllAddress());
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
          if (state is GetAllAddressblocloaded) {
            address =
                BlocProvider.of<GetAllAddressBloc>(context).getAllAddressModel;
            return SingleChildScrollView(
              child: SizedBox(
                height: mheight,
                child: Column(
                  children: [
                    Divider(
                      thickness: mwidth * 0.05,
                      color: const Color(0xffF3F3F3),
                    ),
                    Container(
                      width: mwidth,
                      height: mheight * 0.2,
                      padding: EdgeInsets.only(top: mheight * 0.02),
                      child: selectedAddress == null || address!.isEmpty
                          ? Center(
                              child: TextButton(
                                onPressed: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (BuildContext a) =>
                                            const SaveAdress())),
                                child: SizedBox(
                                  width: mwidth * 0.5,
                                  child: const Row(
                                    children: [
                                      Text(
                                        'Select Your Address',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Icon(
                                        Icons.navigate_next,
                                        color: Colors.black,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: mwidth * 0.025,
                                    ),
                                    const Text(
                                      'Deliver to :',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(
                                      width: mwidth * 0.44,
                                    ),
                                    GestureDetector(
                                      onTap: () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext a) =>
                                                  const SaveAdress())),
                                      child: Container(
                                        width: mwidth * 0.28,
                                        height: mheight * 0.05,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            border: Border.all(
                                                color: const Color(0xffF4F4F4))),
                                        child: const Center(
                                          child: Text(
                                            'Change Address',
                                            style: TextStyle(
                                                color: Color(0xff2D495A),
                                                fontSize: 11,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: mwidth * 0.03),
                                  child: Row(
                                    children: [
                                      Text(
                                        selectedAddress!.fullName.toString(),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        width: mwidth * 0.02,
                                      ),
                                      Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              color: Colors.grey[200]),
                                          width: mwidth * 0.17,
                                          height: mheight * 0.034,
                                          child: Center(
                                            child: Text(
                                              selectedAddress!.type,
                                              style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: mwidth * 0.03),
                                  height: mheight * 0.038,
                                  width: mwidth * 0.95,
                                  child: Text(
                                    '${selectedAddress!.houseNoOrBuildingName},${selectedAddress!.landmark},${selectedAddress!.city},${selectedAddress!.state},${selectedAddress!.pincode}',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: mwidth * 0.03),
                                  child: Text(
                                    selectedAddress!.phone.toString(),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                )
                              ],
                            ),
                    ),
                    Divider(
                      thickness: mwidth * 0.05,
                      color: const Color(0xffF3F3F3),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: widget.selectedproducts.length + 1,
                          itemBuilder: (ctx, index) {

                            if (index <= widget.selectedproducts.length - 1) {
                              for (int i=0;i<=widget.selectedproducts.length - 1;i++){
                                ListOfCartItemId.add({
                                  'cartItemId':widget.selectedproducts[index].id.toString()
                                });
                              }
                              return SizedBox(
                                width: mwidth,
                                height: mheight * 0.22,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: mwidth * 0.05,
                                    ),
                                    SizedBox(
                                      width: mwidth * 0.35,
                                      height: mheight * 0.16,
                                      child: widget.selectedproducts[index]
                                                      .productVarient ==
                                                  null ||
                                              widget.selectedproducts[index].productVarient!
                                                  .product!.images!.isEmpty
                                          ? Image.asset(
                                              'asset/Images/placeholder.jpg',
                                              fit: BoxFit.cover,
                                            )
                                          : Image.network(
                                        widget.selectedproducts[index].productVarient!
                                                  .product!.images!.first.url
                                                  .toString(),
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                    SizedBox(
                                      width: mwidth * 0.015,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: mheight * 0.055,
                                          left: mwidth * 0.024),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              width: mwidth * 0.532,
                                              padding: EdgeInsets.only(
                                                  left: mwidth * 0.023),
                                              child: Text(
                                                widget.selectedproducts[index]
                                                    .productVarient!.product!.name
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: Color(0xff1D1D1B),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              )),
                                          SizedBox(
                                            height: mheight * 0.008,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: mwidth * 0.02),
                                            child: RatingBar.builder(
                                                itemCount: 5,
                                                initialRating: 3,
                                                allowHalfRating: true,
                                                itemSize: 14,
                                                itemBuilder: (ctx, index) =>
                                                    const Icon(
                                                      Icons.star,
                                                      color: Color(0xffF3603F),
                                                    ),
                                                onRatingUpdate: (value) {
                                                  print(value);
                                                }),
                                          ),
                                          SizedBox(
                                            height: mheight * 0.006,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: mwidth * 0.023),
                                            child: Text(
                                              'SAR ${selectedproducts1[index].productVarient!.product!.price.toString()}',
                                              style: const TextStyle(
                                                  color: Color(0xff7C7C7C),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }
                            if (index == widget.selectedproducts.length) {
                              return SizedBox(
                                height: mheight * 0.49,
                                child: Column(children: [
                                  Divider(
                                    thickness: mwidth * 0.05,
                                    color: const Color(0xffF3F3F3),
                                  ),
                                  SizedBox(
                                      width: mwidth,
                                      height: mheight * 0.27,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: mwidth * 0.045,
                                                top: mheight * 0.017),
                                            child: const Text(
                                              'Price Details',
                                              style: TextStyle(
                                                  color: Color(0xff535353),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                          SizedBox(
                                            height: mheight * 0.01,
                                          ),
                                          Divider(
                                            thickness: mwidth * 0.00045,
                                            color: const Color(0xff9E9999),
                                          ),
                                          SizedBox(
                                            height: mheight * 0.015,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: mwidth * 0.045,
                                              ),
                                              const Text(
                                                'Price',
                                                style: TextStyle(
                                                    color: Color(0xff6A6969),
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              SizedBox(
                                                width: mwidth * 0.58,
                                              ),
                                              Text(
                                                'SAR $price',
                                                style: const TextStyle(
                                                    color: Color(0xff6A6969),
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: mheight * 0.02,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: mwidth * 0.044,
                                              ),
                                              const Text(
                                                'Discount',
                                                style: TextStyle(
                                                    color: Color(0xff6A6969),
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              SizedBox(
                                                width: mwidth * 0.5,
                                              ),
                                              Text(
                                                '- SAR $discountAmount',
                                                style: const TextStyle(
                                                    color: Color(0xff0A8300),
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: mheight * 0.02,
                                          ),
                                          // Row(
                                          //   children: [
                                          //     SizedBox(
                                          //       width: mwidth * 0.045,
                                          //     ),
                                          //     const Text(
                                          //       'Delivery Charges',
                                          //       style: TextStyle(
                                          //           color: Color(0xff6A6969),
                                          //           fontSize: 13,
                                          //           fontWeight:
                                          //               FontWeight.w400),
                                          //     ),
                                          //     SizedBox(
                                          //       width: mwidth * 0.395,
                                          //     ),
                                          //     const Text(
                                          //       'Free Delivery',
                                          //       style: TextStyle(
                                          //           color: Color(0xff006504),
                                          //           fontSize: 13,
                                          //           fontWeight:
                                          //               FontWeight.w400),
                                          //     ),
                                          //   ],
                                          // ),
                                          // SizedBox(
                                          //   height: mheight * 0.017,
                                          // ),
                                          Divider(
                                            thickness: mwidth * 0.00045,
                                            color: const Color(0xff9E9999),
                                          ),
                                          SizedBox(
                                            height: mheight * 0.005,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: mwidth * 0.04,
                                              ),
                                              const Text(
                                                'Total Amount',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              SizedBox(
                                                width: mwidth * 0.41,
                                              ),
                                              Text(
                                                'SAR $totalprice',
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          )
                                        ],
                                      )),
                                  Divider(
                                    thickness: mwidth * 0.05,
                                    color: const Color(0xffF3F3F3),
                                  ),
                                ]),
                              );
                            }
                            return null;
                          }),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        }),
      ),
    );
  }
}
