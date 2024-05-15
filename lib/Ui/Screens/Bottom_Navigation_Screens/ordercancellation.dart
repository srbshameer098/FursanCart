import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../bloc/CancelOrder/cancel_order_bloc.dart';
import '../../../bloc/CancelOrderReason/cancel_order_reason_bloc.dart';
import '../../../repository/model_class/CancelOrderReasons/CancelOrderReason.dart';
import '../../Widgets/toast_message.dart';

class OrderCancelation extends StatefulWidget {
  final String productId;

  const OrderCancelation({super.key, required this.productId});

  @override
  State<OrderCancelation> createState() => _OrderCancelationState();
}

late List<CancelOrderReason> cancelReasons;
bool isExpanded = false;

class _OrderCancelationState extends State<OrderCancelation> {
  String? selectedReason;
  final int _value = 1;
  TextEditingController other = TextEditingController();
  String reason='';
  List<bool> checkboxValues = [];
  void _onCheckboxValueChanged(bool? value, int index) {
    setState(() {
      for (int i = 0; i < checkboxValues.length; i++) {
        if (i == index) {
          checkboxValues[i] = value ?? false;
        } else {
          checkboxValues[i] = false;
        }
      }
    });
  }
  @override
  void initState() {
    BlocProvider.of<CancelOrderReasonBloc>(context)
        .add(FetchGetCancelOrderReason());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mHeight = MediaQuery
        .of(context)
        .size
        .height;
    var mWidth = MediaQuery
        .of(context)
        .size
        .width;
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
              'Reason For Canceling',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w400),
            ),
          ]),
          centerTitle: false,
          backgroundColor: Colors.white,
          elevation: 1,
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocBuilder<CancelOrderReasonBloc, CancelOrderReasonState>(
            builder: (context, state) {
              if (state is CancelOrderReasonblocloading) {
                return Center(
                  child: Lottie.asset('asset/Animations/shoppingcart.json',
                      repeat: true,
                      reverse: true,
                      fit: BoxFit.cover,
                      height: mHeight * 0.15),
                );
              }
              if (state is CancelOrderReasonblocerror) {
                return RefreshIndicator(
                  onRefresh: () async {
                    return BlocProvider.of<CancelOrderReasonBloc>(context)
                        .add(FetchGetCancelOrderReason());
                  },
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: SizedBox(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * .9,
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
              if (state is CancelOrderReasonblocloaded) {
                cancelReasons = BlocProvider
                    .of<CancelOrderReasonBloc>(context)
                    .cancelOrderReason;
                for (int i = 0; i < cancelReasons.length; i++) {
                  checkboxValues.add(false);
                }

                return Padding(
                  padding: EdgeInsets.only(top: mHeight * 0.02),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: cancelReasons.length + 1,
                    itemBuilder: (context, index) {
                      if (index <= cancelReasons.length - 1) {
                        cancelReasons[index].reason == null
                            ? ''
                            : cancelReasons[index]
                            .reason
                            .toString();
                        return Card(
                            elevation: 2,
                            child: CheckboxListTile(controlAffinity: ListTileControlAffinity.leading,
                                title: Text(
                                  cancelReasons[index].reason == null
                                      ? ''
                                      : cancelReasons[index]
                                      .reason
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                value: checkboxValues[index],
                                activeColor: const Color(0xff264050),
                                onChanged: (value) {
                                  setState(() {
                                    _onCheckboxValueChanged(value, index);
                                    isExpanded = true;
                                    reason=cancelReasons[index].reason.toString();
                                  });
                                }));
                      }
                      if (index == cancelReasons.length) {
                        return Column(
                          children: [
                            Card(
                                elevation: 2,
                                child: ExpansionTile(
                                    onExpansionChanged: (value) =>
                                        setState(() {
                                          isExpanded = false;
                                        }),
                                    title: const Center(
                                        child: Text(
                                          'Other Reason',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )),
                                    children: [
                                      Container(
                                        color: Colors.grey[200],
                                        width: mWidth,
                                        height: mHeight * 0.3,
                                        child: Center(
                                          child: Container(
                                              padding: EdgeInsets.only(
                                                  left: mWidth * 0.04,
                                                  top: mHeight * 0.01),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                      Colors.black),
                                                  color: Colors.white,
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(4)),
                                              width: mWidth * 0.9,
                                              height: mHeight * 0.2,
                                              child: TextFormField(onFieldSubmitted: (value){
                                                other.text=value;
                                              },
                                                autofocus: true,
                                                keyboardType:
                                                TextInputType
                                                    .multiline,
                                                textInputAction:
                                                TextInputAction
                                                    .done,
                                                maxLines: null,
                                                controller: other,
                                                decoration: const InputDecoration(
                                                    enabledBorder:
                                                    InputBorder
                                                        .none,
                                                    focusedBorder:
                                                    InputBorder
                                                        .none,
                                                    errorBorder:
                                                    InputBorder
                                                        .none,
                                                    focusedErrorBorder:
                                                    InputBorder
                                                        .none,
                                                    hintText:
                                                    'Enter Your Reason',
                                                    hintStyle: TextStyle(
                                                        color: Color(
                                                            0xff767676),
                                                        fontSize: 14)),
                                              )),
                                        ),
                                      )
                                    ])),
                            Center(
                              child: BlocListener<CancelOrderBloc,
                                  CancelOrderState>(
                                listener: (context, state) {
                                  if (state
                                  is CancelOrderblocLoading) {

                                  }
                                  if (state
                                  is CancelOrderblocLoaded) {
                                    ToastMessage().toastmessage(
                                        message:
                                        'Order Cancelled Successfully');
                                    Navigator.of(context).pop();
                                  }

                                  if (state is CancelOrderblocError) {
                                    ToastMessage().toastmessage(
                                        message:
                                        'Oops Something Went Wrong');
                                  }
                                },
                                child: TextButton(
                                  onPressed: () {
                                    if(reason==''&&other.text.isEmpty){
                                      ToastMessage().toastmessage(
                                          message:
                                          'Please Select your Reason');
                                    }else{
                                    if (other.text.isEmpty||other.text==''){
                                      BlocProvider.of<
                                          CancelOrderBloc>(
                                          context)
                                          .add(FetchCancelOrder(
                                          orderId: widget.productId,
                                          reason: reason.toString()));}
                                    if(reason==''||reason.isEmpty||reason==''){
                                      BlocProvider.of<
                                          CancelOrderBloc>(
                                          context)
                                          .add(FetchCancelOrder(
                                          orderId: widget.productId,
                                          reason: other.text.toString()));
                                    }}
                                  },
                                  child: Container(
                                      width: mWidth * 0.45,
                                      height: mHeight * 0.06,
                                      decoration: BoxDecoration(
                                          color: const Color(0xff264050),
                                          borderRadius:
                                          BorderRadius.circular(
                                              4)),
                                      child: const Center(
                                          child: Text(
                                            'Submit',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight:
                                                FontWeight.bold),
                                          ))),
                                ),
                              ),
                            )
                          ],
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ));
  }

  @override
  void dispose() {
    other.clear();
    reason='';
    super.dispose();
  }
}
