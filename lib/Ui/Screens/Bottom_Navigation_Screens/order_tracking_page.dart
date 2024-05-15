import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_tracker/order_tracker.dart';

import '../../../bloc/CancelOrder/cancel_order_bloc.dart';
import '../../../bloc/GetAllOrders/get_all_orders_bloc.dart';
import '../../../repository/model_class/GetAllOrders/GetAllOrders.dart';
import '../../Widgets/toast_message.dart';
import 'ordercancellation.dart';
import 'package:intl/intl.dart';
class OrderTracking extends StatefulWidget {
  final String orderPlacedDate;
  final String image;
  final String productName;
  final String price;
  final String orderId;
  final String productId;
  final GetAllOrders eachOrder;
   bool visible;
final int position;

   OrderTracking(
      {super.key,
      required this.price,
      required this.image,
      required this.productName,
      required this.orderId,required this.eachOrder,required this.position,required this.productId,required this.visible,required this.orderPlacedDate});

  @override
  State<OrderTracking> createState() => _OrderTrackingState();
}

bool visible=true;
class _OrderTrackingState extends State<OrderTracking> {

late Status status;
 String isoDate='';
 String orderPlacedDate='';
 String shippedDate='';
 String outOfDeliveryDate='';
 String deliverdDate='';
  @override
  Widget build(BuildContext context) {
    var mHeight = MediaQuery.of(context).size.height;
    var mWidth = MediaQuery.of(context).size.width;


    print(widget.position);
    if(
    widget.eachOrder.products!.isNotEmpty &&
        widget.eachOrder.products![0].orderStatuss != null &&
        widget.eachOrder.products![0].orderStatuss!.isNotEmpty){
      for (var map in widget.eachOrder.products![0].orderStatuss!) {
        if (map.status == 'Ordered') {
          status=Status.order;
          setState(() {
            isoDate=map.createdAt.toString();
            final parsedDate = DateTime.parse(isoDate); // Parse the ISO date string into a DateTime object
            final format = DateFormat('E, d MMM yyyy');
            orderPlacedDate= format.format(parsedDate);
          });
        }
        if(map.status=='Dispatched'){
          setState(() {
            widget.visible=false;
          });
        }
        if(map.status=='Shipped'){
          status=Status.shipped;
          setState(() {
            isoDate=map.createdAt.toString();
            final parsedDate = DateTime.parse(isoDate); // Parse the ISO date string into a DateTime object
            final format = DateFormat('E, d MMM yyyy');
            shippedDate = format.format(parsedDate);
          });
        }
        if(map.status=='Out_For_Delivery'){
          status=Status.outOfDelivery;
          setState(() {
            isoDate=map.createdAt.toString();
            final parsedDate = DateTime.parse(isoDate); // Parse the ISO date string into a DateTime object
            final format = DateFormat('E, d MMM yyyy');
            outOfDeliveryDate= format.format(parsedDate);
          });
        }
        if(map.status=='Delivered'){
          status=Status.delivered;
          setState(() {
            isoDate=map.createdAt.toString();
            final parsedDate = DateTime.parse(isoDate); // Parse the ISO date string into a DateTime object
            final format = DateFormat('E, d MMM yyyy');
            deliverdDate = format.format(parsedDate);
          });
        }if(map.status=='Cancelled'){
          setState(() {
            widget.visible=false;
          });
        }

      }}
 // Format the DateTime object as a string

    List<TextDto> orderList = [
      TextDto("Your order has been placed", orderPlacedDate==''?'':orderPlacedDate.toString()),
    ];

    List<TextDto> shippedList = [
      TextDto("Your order has been shipped",shippedDate==''?'': shippedDate.toString()),
    ];

    List<TextDto> outOfDeliveryList = [
      TextDto("Your order is out for delivery",outOfDeliveryDate==''?'': outOfDeliveryDate.toString()),
    ];

    List<TextDto> deliveredList = [
      TextDto("Your order has been delivered",deliverdDate==''?'': deliverdDate.toString()),
    ];






    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        title: Row(children: [
          IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          const Text(
            'Order Details',
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400),
          ),
        ]),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: mHeight * 0.1,
              child: Row(
                children: [
                  SizedBox(
                    width: mWidth * 0.028,
                  ),
                  Container(
                    width: mWidth * 0.1,
                    height: mHeight * 0.1,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xff264050)),
                    child: Stack(
                      children: [
                        Positioned(
                            top: mHeight * 0.035,
                            left: mWidth * 0.017,
                            child: Container(
                              width: mWidth * 0.062,
                              height: mHeight * 0.027,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage('asset/Icons/order.png'))),
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    width: mWidth * 0.035,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: mHeight * 0.03,
                      ),
                      const Text(
                        'Delivery expected by ',
                        style: TextStyle(
                            color: Color(0xffB4B4B4),
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: mHeight * 0.005,
                      ),
                      const Text(
                        'Mon, 30 May 2023',
                        style: TextStyle(
                            color: Color(0xffC1C1C1),
                            fontWeight: FontWeight.w400,
                            fontSize: 10),
                      )
                    ],
                  )
                ],
              ),
            ),
            Card(
              elevation: 1,
              child: Container(
                width: mWidth,
                height: mHeight * 0.2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: const Color(0xffFCFCFC)),
                child: Row(
                  children: [
                    SizedBox(
                      width: mWidth * 0.053,
                    ),
                    SizedBox(
                        width: mWidth * 0.28,
                        height: mHeight * 0.12,
                        child: Image.network(
                          widget.image,
                          fit: BoxFit.cover,
                        )),
                    SizedBox(
                      width: mWidth * 0.035,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: mHeight * 0.06,
                        ),
                        SizedBox(
                          width: mWidth * 0.55,
                          height: mHeight * 0.05,
                          child: Text(
                            maxLines: 2,
                            widget.productName,
                            style: const TextStyle(
                                color: Color(0xff1D1D1B),
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          height: mHeight * 0.01,
                        ),
                        Text(
                          'SAR ${widget.price}',
                          style: const TextStyle(
                              color: Color(0xff7C7C7C),
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 1,
              child: Container(
                padding:
                    EdgeInsets.only(left: mWidth * 0.1, top: mHeight * 0.054),
                width: mWidth,
                height: mHeight * 0.46,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: const Color(0xffFCFCFC)),
                child: Center(
                  child: OrderTracker(headingDateTextStyle: const TextStyle(color: Colors.transparent),
                    status: status,
                    activeColor: Colors.green,
                    inActiveColor: Colors.grey[300],
                    orderTitleAndDateList: orderList,
                    shippedTitleAndDateList: shippedList,
                    outOfDeliveryTitleAndDateList: outOfDeliveryList,
                    deliveredTitleAndDateList: deliveredList,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: mHeight * 0.005,
            ),
            BlocListener<CancelOrderBloc, CancelOrderState>(
              listener: (context, state) {
                if (state is CancelOrderblocLoading) {
                  print('loading');
                }
                if (state is CancelOrderblocLoaded) {
                  BlocProvider.of<GetAllOrdersBloc>(context).add(FetchGetAllOrders());
                  Navigator.of(context).pop();
                  ToastMessage().toastmessage(message: 'Order Canceled');
                  print('loaded');
                }

                if (state is CancelOrderblocError) {
                  print('error');
                  ToastMessage().toastmessage(message: 'Oops Something Went Wrong');
                }
              },
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext a)=>OrderCancelation(productId: widget.productId, )));

                },
                child: Visibility(visible: widget.visible,
                  child: Card(
                    elevation: 1,
                    child: Container(
                      width: mWidth,
                      height: mHeight * 0.09,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: const Color(0xffFCFCFC)),
                      child: const Center(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                              color: Color(0xff5C5C5C),
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
