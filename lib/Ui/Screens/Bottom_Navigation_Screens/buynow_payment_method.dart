import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/ApplyCoupans/apply_coupans_bloc.dart';
import '../../../bloc/BuyNowPlaceOrder/buy_now_place_order_bloc.dart';

import '../../../main.dart';
import '../../../repository/model_class/Coupan/CouponModel.dart';
import '../../Widgets/delivery_Type.dart';
import '../../Widgets/order_success_animation.dart';
import '../../Widgets/toast_message.dart';

class BuyNowPayment extends StatefulWidget {
  final double discountAmount;
  final double price;
  final String productId;
  final int quantity;
  final String deliveryId;

  const BuyNowPayment({
    super.key,
    required this.quantity,
    required this.productId,
    required this.price,
    required this.discountAmount,
    required this.deliveryId,
  });

  @override
  State<BuyNowPayment> createState() => _BuyNowPaymentState();
}

List<CouponModel> coupans = [];
bool isVisible = false;
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
String _selectedOption = '';
TextEditingController coupan = TextEditingController();
late String paymentMethod;
String deliveryCharge1='';
double totalAmount = 0;
double coupanDiscount=0;
double slabAmount1=0;
double deliveryCharge2=0;
class _BuyNowPaymentState extends State<BuyNowPayment> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scaffoldKey.currentState!.showBottomSheet((context) {
        return const DeliveryTypeBottomSheet();
      }).closed.then((value) {
        setState(() {
          slabAmount1 = slabAmount;
          deliveryCharge2 = deliveryCharge;
        });
      });
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var mwidth = MediaQuery.of(context).size.width;
    var mheight = MediaQuery.of(context).size.height;
    double discount = widget.price - widget.discountAmount;
    double baseTotalAmount=widget.discountAmount*widget.quantity;

    if(baseTotalAmount<slabAmount1){

      setState(() {
        totalAmount=(widget.price+deliveryCharge2)-(coupanDiscount+discount);
        deliveryCharge1=deliveryCharge2.toStringAsFixed(2);
      });

    }
    if(baseTotalAmount>slabAmount1){
      setState(() {
        totalAmount=widget.price-(coupanDiscount+discount);
        deliveryCharge1='Free Delivery';
      });


    }
    if (coupan.text != '') {
      setState(() {
        isVisible = !isVisible;
      });
    }
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
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
              'Payments',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(
                thickness: mwidth * 0.05,
                color: const Color(0xffF3F3F3),
              ),
              SizedBox(
                height: mheight * 0.012,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: mheight * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: mwidth * 0.05),
                    child: const Text(
                      'Payment Methods',
                      style: TextStyle(
                          color: Color(0xff636363),
                          fontSize: 17,
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
                    height: mheight * 0.008,
                  ),
                  SizedBox(
                    height: mheight * 0.045,
                    child: RadioListTile(
                        activeColor: const Color(0xff264050),
                        visualDensity: const VisualDensity(
                            horizontal: VisualDensity.minimumDensity,
                            vertical: VisualDensity.minimumDensity),
                        title: const Text(
                          "Cash on Delivery",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                        value: "Cash on Delivery",
                        groupValue: _selectedOption,
                        onChanged: (value) {
                          setState(() {
                            _selectedOption = value.toString();
                          });
                        }),
                  ),
                  SizedBox(
                    height: mheight * 0.01,
                  ),
                  SizedBox(
                    height: mheight * 0.045,
                    child: RadioListTile(
                      activeColor: const Color(0xff264050),
                      visualDensity: const VisualDensity(
                          horizontal: VisualDensity.minimumDensity,
                          vertical: VisualDensity.minimumDensity),
                      title: const Text(
                        "Payfort",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                      value: "Payfort",
                      groupValue: _selectedOption,
                      onChanged: (value) {
                        setState(
                              () {
                            _selectedOption = value.toString();
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: mheight * 0.04,
              ),
              Divider(
                thickness: mwidth * 0.05,
                color: const Color(0xffF3F3F3),
              ),
              SizedBox(
                height: mheight * 0.026,
              ),
              Padding(
                padding: EdgeInsets.only(left: mwidth * 0.075),
                child: const Text(
                  "Apply Coupon",
                  style: TextStyle(
                      color: Color(0xff636363),
                      fontWeight: FontWeight.w400,
                      fontSize: 18),
                ),
              ),
              SizedBox(
                height: mheight * 0.032,
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: mwidth * 0.075),
                    child: Container(
                        decoration: BoxDecoration(
                            color: const Color(0xffF3F3F3),
                            borderRadius: BorderRadius.circular(12)),
                        width: mwidth * 0.62,
                        height: mheight * 0.061,
                        padding: EdgeInsets.only(
                          left: mwidth * 0.04,
                        ),
                        child: TextFormField(
                          textInputAction: TextInputAction.done,
                          controller: coupan,
                          decoration: const InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                          ),
                        )),
                  ),
                  SizedBox(
                    width: mwidth * 0.023,
                  ),
                  BlocListener<ApplyCoupansBloc, ApplyCoupansState>(
                    listener: (context, state) {
                      if (state is ApplyCoupansblocLoading) {
                        print('loading');
                      }
                      if (state is ApplyCoupansblocLoaded) {
                        coupans = BlocProvider.of<ApplyCoupansBloc>(context).coupon;
                        coupanDiscount=double.parse(coupans.first.discountAmount.toString());
                        setState(() {
                          isVisible = false;
                        });
                        if (coupans.isEmpty) {
                          ToastMessage()
                              .toastmessage(message: 'Invalid Coupon Code');
                        } else {
                          ToastMessage()
                              .toastmessage(message: 'Coupon Added Successfully');
                          coupan.clear();
                          print('loaded');
                        }
                      }

                      if (state is ApplyCoupansblocError) {
                        ToastMessage()
                            .toastmessage(message: 'Oops Something Went Wrong');
                        coupan.clear();
                        print('error');
                      }
                    },
                    child: Visibility(
                      visible: isVisible,
                      child: TextButton(
                          onPressed: () {
                            BlocProvider.of<ApplyCoupansBloc>(context)
                                .add(FetchCoupans(
                              code: coupan.text.toString(),
                            ));
                          },
                          child: const Text('Apply',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15))),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: mheight * 0.05,
              ),
              Divider(
                thickness: mwidth * 0.05,
                color: const Color(0xffF3F3F3),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                    EdgeInsets.only(left: mwidth * 0.045, top: mheight * 0.017),
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
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        width: mwidth * 0.58,
                      ),
                      Text(
                        'SAR ${widget.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                            color: Color(0xff6A6969),
                            fontSize: 13,
                            fontWeight: FontWeight.w400),
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
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        width: mwidth * 0.5,
                      ),
                      Text(
                        '- SAR ${discount.toStringAsFixed(2)}',
                        style: const TextStyle(
                            color: Color(0xff0A8300),
                            fontSize: 13,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: mheight * 0.02,
                  ),
                  coupans.isEmpty
                      ? SizedBox(
                    height: mheight * 0.0001,
                  )
                      : Row(
                    children: [
                      SizedBox(
                        width: mwidth * 0.044,
                      ),
                      const Text(
                        'Coupon Discount',
                        style: TextStyle(
                            color: Color(0xff6A6969),
                            fontSize: 13,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        width: mwidth * 0.386,
                      ),
                      Text(
                        'SAR ${coupans.first.discountAmount.toString()}',
                        style: const TextStyle(
                            color: Color(0xff0A8300),
                            fontSize: 13,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: mheight * 0.02,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: mwidth * 0.045,
                      ),
                      const Text(
                        'Delivery Charges',
                        style: TextStyle(
                            color: Color(0xff6A6969),
                            fontSize: 13,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        width: mwidth * 0.395,
                      ),
                      Text(
                        deliveryCharge1,
                        style: const TextStyle(
                            color: Color(0xff006504),
                            fontSize: 13,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: mheight * 0.017,
                  ),
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
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: mwidth * 0.41,
                      ),
                      Text(
                        'SAR ${totalAmount.toStringAsFixed(2)}',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: mheight * 0.033,
              ),
              Divider(
                thickness: mwidth * 0.05,
                color: const Color(0xffF3F3F3),
              ),
              Card(
                  elevation: 1,
                  child: SizedBox(
                    width: mwidth,
                    height: mheight * 0.1,
                    child: Row(
                      children: [
                        SizedBox(
                          width: mwidth * 0.04,
                        ),
                        Text(
                          'SAR ${totalAmount.toStringAsFixed(2)}',
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          width: mwidth * 0.28,
                        ),
                        BlocListener<BuyNowPlaceOrderBloc, BuyNowPlaceOrderState>(
                          listener: (context, state) {
                            if (state is BuyNowPlaceOrderblocLoading) {
                              print('loading');
                            }
                            if (state is BuyNowPlaceOrderblocLoaded) {
                              deliveryTypeId = '';
                              print('loaded');
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext a) =>
                                      const OrderSuccessAnimation()));
                            }
                            if (state is BuyNowPlaceOrderblocError) {
                              ToastMessage().toastmessage(
                                  message: 'Oops Something Went Wrong');
                              print('error');
                            }
                          },
                          child: TextButton(
                            onPressed: () {
                              if (_selectedOption == '') {
                                ToastMessage().toastmessage(
                                    message: 'Please Select Your Payment Method');
                              }
                              if (_selectedOption == 'Cash on Delivery') {
                                paymentMethod = 'CashOnDelivery';
                              }
                              if (_selectedOption == 'Payfort') {
                                paymentMethod = 'Online';
                              }
                              if (deliveryTypeId == '') {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const DeliveryTypeBottomSheet();
                                  },
                                );
                              }
                              if( deliveryTypeId!=''&&paymentMethod!='Online'){
                                BlocProvider.of<BuyNowPlaceOrderBloc>(context).add(
                                    FetchBuyNowPlaceOrder(
                                        deliveryId: widget.deliveryId,
                                        quantity:
                                        int.parse(widget.quantity.toString()),
                                        productId: widget.productId,
                                        totalAmount: totalAmount.toString(),
                                        coupanCode: coupan.text,
                                        deliveryTypeId: deliveryTypeId,
                                        paymentType: paymentMethod));}
                            },
                            child: Container(
                              width: mwidth * 0.3,
                              height: mheight * 0.05,
                              decoration: BoxDecoration(
                                  color: const Color(0xffFFC113),
                                  borderRadius: BorderRadius.circular(8)),
                              child: const Center(
                                child: Text(
                                  'Place Order',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
              Divider(
                thickness: mwidth * 0.05,
                color: const Color(0xffF3F3F3),
              ),
            ],
          )),
    );
  }

  @override
  void dispose() {
    deliveryTypeId='';
    coupan.clear();
    deliveryCharge1 = '';
    slabAmount1=0;
    deliveryCharge2=0;
    isVisible = false;
    super.dispose();
  }
}