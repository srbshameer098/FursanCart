import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../bloc/GetAllOrders/get_all_orders_bloc.dart';
import '../../../repository/model_class/GetAllOrders/GetAllOrders.dart';
import '../Bottom_Navigation.dart';
import 'order_tracking_page.dart';
import 'package:intl/intl.dart';
class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  @override
  void initState() {
    BlocProvider.of<GetAllOrdersBloc>(context).add(FetchGetAllOrders());
    // TODO: implement initState
    super.initState();
  }

  late List<GetAllOrders> orders;
  late List<int> visible;
  late List<String>canceleddates;
  late List<String>canceledconvertedDate;
  late List<String>deliverddates;
  late List<String>deliverdconvertedDate;
  bool orderd = false;
  bool cancelled = false;
  bool deliverd = false;
  late List<bool> boolvalue;
  @override
  Widget build(BuildContext context) {
    var mHeight = MediaQuery.of(context).size.height;
    var mWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'Orders',
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400),
          ),
          leading: IconButton(
              onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext a) => const Bottom_Navigation()),
                      (route) => false),
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
        ),
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: WillPopScope(onWillPop: ()async{
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext a) => const Bottom_Navigation()),
                  (route) => false);
          return false;
        },
          child: BlocBuilder<GetAllOrdersBloc, GetAllOrdersState>(
              builder: (context, state) {
            if (state is GetAllOrdersblocloading) {
              return Center(
                child: Lottie.asset('asset/Animations/shoppingcart.json',
                    repeat: true,
                    reverse: true,
                    fit: BoxFit.cover,
                    height: mHeight * 0.15),
              );
            }
            if (state is GetAllOrdersblocerror) {
              return RefreshIndicator(
                onRefresh: () async {
                  return BlocProvider.of<GetAllOrdersBloc>(context)
                      .add(FetchGetAllOrders());
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
                            height: mHeight * 0.3),
                      )),
                ),
              );
            }
            if (state is GetAllOrdersblocloaded) {
              orders =
                  BlocProvider.of<GetAllOrdersBloc>(context).getAllOrdersModel;
              return orders.isEmpty
                  ? Center(
                      child: Lottie.asset('asset/Animations/emptybox.json',
                          repeat: true,
                          reverse: true,
                          fit: BoxFit.cover,
                          height: mHeight * 0.3),
                    )
                  : ListView.separated(
                      itemCount: orders.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (ctx, index) {
                        visible = List.generate(orders.length, (index) => 0);
                        boolvalue = List.generate(orders.length, (index) => true);
canceleddates= List.generate(orders.length, (index) => '');

                        canceledconvertedDate= List.generate(orders.length, (index) => '');
                        deliverddates= List.generate(orders.length, (index) => '');
                        deliverdconvertedDate= List.generate(orders.length, (index) => '');

                        for (int i = 0; i < orders.length; i++) {
                          bool orderd = false;
                          bool deliverd = false;
                          bool cancelled = false;

                          if (orders[i].products != null &&
                              orders[i].products!.isNotEmpty &&
                              orders[i].products![0].orderStatuss != null &&
                              orders[i].products![0].orderStatuss!.isNotEmpty) {
                            for (var map
                                in orders[i].products![0].orderStatuss!) {
                              if (map.status == 'Ordered') {
                                orderd = true;
                                deliverd = false;
                                cancelled = false;
                              }
                              if (map.status == 'Cancelled') {
                                cancelled = true;
                                orderd = false;
                                deliverd = false;
                                boolvalue[i] = false;
                                canceleddates[i]=map.createdAt.toString();
                                final parsedDate = DateTime.parse(canceleddates[i]); // Parse the ISO date string into a DateTime object
                                final format = DateFormat('E, d MMM yyyy');
                                canceledconvertedDate[i] = format.format(parsedDate);
                              }
                              if (map.status == 'Delivered') {
                                deliverd = true;
                                orderd = false;
                                cancelled = false;
                                deliverddates[i]=map.createdAt.toString();
                                final parsedDate = DateTime.parse(deliverddates[i]); // Parse the ISO date string into a DateTime object
                                final format = DateFormat('E, d MMM yyyy');
                                deliverdconvertedDate[i] = format.format(parsedDate);
                              }
                            }
                            if (orderd == true) {
                              visible[i] = 0;
                            }
                            if (cancelled == true) {
                              visible[i] = 2;
                            }
                            if (deliverd == true) {
                              visible[i] = 1;
                            }
                          }
                        }

                        print(visible);

                        return Column(
                          children: [
                            IndexedStack(index: visible[index], children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: mWidth * 0.028,
                                  ),
                                  Container(
                                    width: mWidth * 0.1,
                                    height: mHeight * 0.1,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xff264050)),
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
                                                      image: AssetImage(
                                                          'asset/Icons/order.png'))),
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
                              Row(children: [
                                SizedBox(
                                  width: mWidth * 0.028,
                                ),
                                Container(
                                  width: mWidth * 0.1,
                                  height: mHeight * 0.1,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xff264050)),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          top: mHeight * 0.035,
                                          left: mWidth * 0.017,
                                          child: SizedBox(
                                            width: mWidth * 0.062,
                                            height: mHeight * 0.027,
                                            child: Image.asset(
                                                'asset/Icons/order.png'),
                                          )),
                                      Positioned(
                                          left: mWidth * 0.065,
                                          top: mHeight * 0.055,
                                          child: Container(
                                              decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle),
                                              child: const Icon(
                                                Icons.check_circle,
                                                color: Color(0xff006504),
                                                size: 13,
                                              )))
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: mWidth * 0.035,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Deliverd ',
                                      style: TextStyle(
                                          color: Color(0xff006504),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: mHeight * 0.005,
                                    ),
                                    Text(
                                      deliverdconvertedDate.toString(),
                                      style: const TextStyle(
                                          color: Color(0xffC1C1C1),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10),
                                    )
                                  ],
                                )
                              ]),
                              Row(
                                children: [
                                  SizedBox(
                                    width: mWidth * 0.028,
                                  ),
                                  Container(
                                    width: mWidth * 0.1,
                                    height: mHeight * 0.1,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xff264050)),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                            top: mHeight * 0.035,
                                            left: mWidth * 0.017,
                                            child: SizedBox(
                                              width: mWidth * 0.062,
                                              height: mHeight * 0.027,
                                              child: Image.asset(
                                                  'asset/Icons/order.png'),
                                            )),
                                        Positioned(
                                            left: mWidth * 0.065,
                                            top: mHeight * 0.055,
                                            child: Container(
                                                decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle),
                                                child: const Icon(
                                                  Icons.cancel,
                                                  color: Color(0xffA60202),
                                                  size: 13,
                                                )))
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: mWidth * 0.035,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Cancelled ',
                                        style: TextStyle(
                                            color: Color(0xffA60202),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: mHeight * 0.005,
                                      ),
                                      Text(
                                        canceledconvertedDate[index].toString(),
                                        style: const TextStyle(
                                            color: Color(0xffC1C1C1),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ]),
                            Card(
                              elevation: 1,
                              child: Container(
                                width: mWidth * 0.94,
                                height: mHeight * 0.2,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    color: const Color(0xffFCFCFC)),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: mWidth * 0.02,
                                    ),
                                    SizedBox(
                                        width: mWidth * 0.28,
                                        height: mHeight * 0.12,
                                        child: orders[index].products!.isEmpty ||
                                                orders[index]
                                                        .products![0]
                                                        .product ==
                                                    null ||
                                                orders[index]
                                                    .products![0]
                                                    .product!
                                                    .images!.isEmpty
                                            ? Image.asset(
                                                'asset/Images/placeholder.jpg',
                                                fit: BoxFit.cover,
                                              )
                                            : Image.network(
                                                    orders[index].products![0]
                                                        .product!
                                                        .images!.first
                                                        .url
                                                        .toString(),
                                                fit: BoxFit.cover,
                                              )),
                                    SizedBox(
                                      width: mWidth * 0.025,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: mHeight * 0.06,
                                        ),
                                        SizedBox(
                                          width: mWidth * 0.4,
                                          height: mHeight * 0.05,
                                          child: Text(
                                            maxLines: 2,
                                            orders[index].products!.isEmpty ||
                                                    orders[index]
                                                            .products![0]
                                                            .productName ==
                                                        null
                                                ? ''
                                                : orders[index]
                                                    .products![0]
                                                    .productName
                                                    .toString(),
                                            style: const TextStyle(
                                                color: Color(0xff1D1D1B),
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14),
                                          ),
                                        ),
                                        SizedBox(
                                          height: mHeight * 0.009,
                                        ),
                                        orders[index].products!.isEmpty ||
                                                orders[index]
                                                        .products![0]
                                                        .totPrice ==
                                                    null
                                            ? const Text('')
                                            : Text(
                                                'SAR ${orders[index]
                                                        .products![0]
                                                        .totPrice}',
                                                style: const TextStyle(
                                                    color: Color(0xff7C7C7C),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400),
                                              )
                                      ],
                                    ),
                                    SizedBox(
                                      width: mWidth * 0.05,
                                    ),
                                    boolvalue[index] == true
                                        ? IconButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (BuildContext a) =>
                                                          OrderTracking(
                                                            price: orders[index]
                                                                        .products!
                                                                        .isEmpty ||
                                                                    orders[index]
                                                                            .products![
                                                                                0]
                                                                            .totPrice ==
                                                                        null
                                                                ? ''
                                                                : orders[index]
                                                                    .products![0]
                                                                    .totPrice
                                                                    .toString(),
                                                            image: orders[index]
                                                                        .products!
                                                                        .isEmpty ||
                                                                    orders[index]
                                                                            .products![
                                                                                0]
                                                                            .product ==
                                                                        null ||
                                                                    orders[index]
                                                                        .products![
                                                                            0]
                                                                        .product!
                                                                        .images!
                                                                        .isEmpty
                                                                ? ''
                                                                :
                                                                    orders[index]
                                                                        .products![
                                                                            0]
                                                                        .product!
                                                                        .images![
                                                                            0]
                                                                        .url
                                                                        .toString(),
                                                            productName: orders[
                                                                            index]
                                                                        .products!
                                                                        .isEmpty ||
                                                                    orders[index]
                                                                            .products![
                                                                                0]
                                                                            .productName ==
                                                                        null
                                                                ? ''
                                                                : orders[index]
                                                                    .products![0]
                                                                    .productName
                                                                    .toString(),
                                                            orderId: orders[index]
                                                                        .id ==
                                                                    null
                                                                ? ''
                                                                : orders[index]
                                                                    .id
                                                                    .toString(),
                                                            eachOrder:
                                                                orders[index],
                                                            position: index,
                                                            productId: orders[
                                                                            index]
                                                                        .products!
                                                                        .isEmpty ||
                                                                    orders[index]
                                                                            .products![
                                                                                0]
                                                                            .id ==
                                                                        null
                                                                ? ''
                                                                : orders[index]
                                                                    .products![0]
                                                                    .id
                                                                    .toString(),
                                                            visible:
                                                                boolvalue[index], orderPlacedDate: orders[index].createdAt.toString(),
                                                          )));
                                            },
                                            icon: const Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: Color(0xff717171),
                                              size: 25,
                                            ))
                                        : const SizedBox()
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: mHeight * 0.006,
                            ),
                            Card(
                              elevation: 1,
                              child: Container(
                                width: mWidth * 0.94,
                                height: mHeight * 0.075,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    color: const Color(0xffFCFCFC)),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: mWidth * 0.05,
                                    ),
                                    const Text(
                                      'Rate Product',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                          color: Color(0xffC1C1C1)),
                                    ),
                                    SizedBox(
                                      width: mWidth * 0.055,
                                    ),
                                    const Icon(
                                      Icons.star_border_purple500_outlined,
                                      color: Color(0xffC1C1C1),
                                      size: 25,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: mHeight * 0.025,
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (ctx, index) {
                        return Divider(
                          thickness: mWidth * 0.02,
                          color: const Color(0xffFCFCFC),
                        );
                      },
                    );
            } else {
              return Container();
            }
          }),
        ));
  }
}
