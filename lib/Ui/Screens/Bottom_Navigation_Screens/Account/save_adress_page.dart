import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fursan_cart/bloc/GetAllAddress/get_all_address_bloc.dart';
import 'package:fursan_cart/main.dart';
import 'package:lottie/lottie.dart';

import '../../../../bloc/RemoveAddress/remove_address_bloc.dart';

import '../../../../repository/model_class/GetAllAddress/GetAllAddressModel.dart';
import '../../../Widgets/toast_message.dart';
import '../Cart/cart_page.dart';
import '../favourites.dart';
import 'add_delivery_adress_page.dart';

class SaveAdress extends StatefulWidget {
  const SaveAdress({super.key});

  @override
  State<SaveAdress> createState() => _SaveAdressState();
}

class _SaveAdressState extends State<SaveAdress> {
  @override
  void initState() {
    BlocProvider.of<GetAllAddressBloc>(context).add(FetchGetAllAddress());
    // TODO: implement initState
    super.initState();
  }

  int _value = 1;
  late List<GetAllAddressModel> address;

  @override
  Widget build(BuildContext context) {
    var mwidth = MediaQuery.of(context).size.width;
    var mheight = MediaQuery.of(context).size.height;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: mheight * 0.085,
          titleSpacing: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 1,
          title: Row(children: [
            IconButton(
                onPressed: () {
                  BlocProvider.of<GetAllAddressBloc>(context).add(FetchGetAllAddress());
                  Navigator.of(context).pop();},
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                )),
            const Text(
              'Select Delivery Address',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w400),
            ),
          ]),
          actions: [
            SizedBox(
              width: mwidth * 0.025,
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext a) => const Favourate_Product())),
              child: const Icon(
                Icons.favorite_outline,
                color: Color(0xff636363),
                size: 20,
              ),
            ),
            SizedBox(
              width: mwidth * 0.025,
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext a) => const Cart_Page())),
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
        body: BlocBuilder<GetAllAddressBloc, GetAllAddressState>(
            builder: (context, state) {
          if (state is GetAllAddressblocloading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
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
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: mheight * 0.04,
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext a) => const AddDeliveryAdress())),
                  child: SizedBox(
                    width: mwidth * 0.53,
                    height: mheight * 0.05,
                    child: Row(
                      children: [
                        SizedBox(
                          width: mwidth * 0.035,
                        ),
                        const Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 20,
                        ),
                        const Text(
                          ' Add New Address',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: mheight * 0.055,
                ),
                Padding(
                  padding: EdgeInsets.only(left: mwidth * 0.04),
                  child: Text(
                    '${address.length}  Saved Address',
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 15),
                  ),
                ),
                SizedBox(
                  height: mheight * 0.024,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: address.isEmpty ? 0 : address.length,
                      itemBuilder: (BuildContext context, int index) {
                        String fullname = address[index].fullName == null
                            ? ''
                            : address[index].fullName.toString();
                        String phone = address[index].phone == null
                            ? ''
                            : address[index].phone.toString();
                        String state = address[index].state == null
                            ? ''
                            : address[index].state.toString();
                        String city = address[index].city == null
                            ? ''
                            : address[index].city.toString();
                        String pincode = address[index].pincode == null
                            ? ''
                            : address[index].pincode.toString();
                        String houseNoOrBuildingName =
                            address[index].houseNoOrBuildingName == null
                                ? ''
                                : address[index]
                                    .houseNoOrBuildingName
                                    .toString();
                        String landmark = address[index].landmark == null
                            ? ''
                            : address[index].landmark.toString();
                        String type=address[index].type==null?'':address[index].type.toString();
                        return Card(
                          elevation: 2,
                          child: Container(
                            width: mwidth,
                            height: mheight * 0.185,
                            padding: EdgeInsets.only(top: mheight * 0.02),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Transform.scale(
                                      scale: 0.9,
                                      child: Radio(visualDensity: const VisualDensity(
                                          horizontal: VisualDensity.minimumDensity,
                                          vertical: VisualDensity.minimumDensity),
                                          value: index,
                                          groupValue: _value,
                                          activeColor: const Color(0xff264050),
                                          onChanged: (value) {
                                            setState(() {
                                              _value = value!;
                                              selectedAddress=address[index];
                                            });
                                          }),
                                    ),
                                    SizedBox(
                                      width: mwidth * 0.655,
                                    ),
                                    BlocListener<RemoveAddressBloc,
                                        RemoveAddressState>(
                                      listener: (context, state) {
                                        if (state
                                            is RemoveAddressblocLoading) {}
                                        if (state is RemoveAddressblocLoaded) {
                                          ToastMessage().toastmessage(
                                              message:
                                                  'Address Successfully Removed');
                                          BlocProvider.of<GetAllAddressBloc>(
                                                  context)
                                              .add(FetchGetAllAddress());
                                        }
                                        if (state is RemoveAddressblocError) {
                                          ToastMessage().toastmessage(
                                              message:
                                                  'Oops Something Went Wrong');
                                        }
                                        // TODO: implement listener
                                      },
                                      child: GestureDetector(
                                        onTap: () {
                                          BlocProvider.of<RemoveAddressBloc>(
                                                  context)
                                              .add(FetchRemoveAddress(
                                                  addressId:
                                                      address[index].id == null
                                                          ? ''
                                                          : address[index]
                                                              .id
                                                              .toString()));
                                        },
                                        child: Container(
                                          width: mwidth * 0.2,
                                          height: mheight * 0.04,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: Colors.black26)),
                                          child: const Center(
                                            child: Text(
                                              'Delete',
                                              style: TextStyle(
                                                  color: Color(0xff2D495A),
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: mwidth * 0.03,
                                      top: mheight * 0.006),
                                  child: Row(
                                    children: [
                                      Text(
                                        fullname,
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
                                              type,
                                              style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ))
                                    ],
                                  ),
                                ),SizedBox(height: mheight*0.01,),
                                Container(
                                  padding: EdgeInsets.only(left: mwidth * 0.03),
                                  height: mheight * 0.05,
                                  width: mwidth * 0.95,
                                  child: Text(
                                    '$houseNoOrBuildingName,$landmark,$city,$state, $pincode,$phone',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),maxLines: 2,
                                  ),
                                ),

                              ],
                            ),
                          ),

                        );
                      }),
                ),
              ],
            );
          } else {
            return Container();
          }
        }));
  }
}
