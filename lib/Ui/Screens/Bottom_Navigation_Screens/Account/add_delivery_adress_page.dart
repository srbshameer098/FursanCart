import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fursan_cart/bloc/AddAddress/add_address_bloc.dart';
import 'package:fursan_cart/bloc/GetAllAddress/get_all_address_bloc.dart';
import 'package:fursan_cart/main.dart';

import '../../../Widgets/address_type.dart';
import '../../../Widgets/toast_message.dart';
import '../Cart/cart_page.dart';
import '../favourites.dart';

class AddDeliveryAdress extends StatefulWidget {
  const AddDeliveryAdress({super.key});

  @override
  State<AddDeliveryAdress> createState() => _AddDeliveryAdressState();
}

class _AddDeliveryAdressState extends State<AddDeliveryAdress> {
  TextEditingController fullname = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController houseNoOrBuildingName = TextEditingController();
  TextEditingController landmark = TextEditingController();
  final form_key = GlobalKey<FormState>();

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
                  Navigator.of(context).pop();
                  BlocProvider.of<GetAllAddressBloc>(context)
                      .add(FetchGetAllAddress());
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                )),
            const Text(
              'Add delivery address',
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
        body: SingleChildScrollView(
          child: Form(
            key: form_key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: mheight * 0.035,
                ),
                Center(
                  child: Container(
                      width: mwidth * 0.9,
                      height: mheight * 0.077,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xffEEEEEE),
                              width: mwidth * 0.004),
                          borderRadius: BorderRadius.circular(3)),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: mwidth * 0.04, top: mheight * 0.006),
                        child: TextFormField(textInputAction: TextInputAction.next,
                          controller: fullname,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field should not be empty';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            fullname.text = value!;
                          },
                          decoration: const InputDecoration(
                              hintText: 'Full Name  (Required) *',
                              hintStyle: TextStyle(
                                  color: Color(0xffB8B8B8),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                              focusedBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              disabledBorder: InputBorder.none),
                        ),
                      )),
                ),
                SizedBox(
                  height: mheight * 0.015,
                ),
                Center(
                  child: Container(
                      width: mwidth * 0.9,
                      height: mheight * 0.077,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xffEEEEEE),
                              width: mwidth * 0.004),
                          borderRadius: BorderRadius.circular(3)),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: mwidth * 0.04, top: mheight * 0.006),
                        child: TextFormField(textInputAction: TextInputAction.next,
                          controller: phonenumber,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty || value.length < 10) {
                              return 'Phone number should be  10 character';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            phonenumber.text = value!;
                          },
                          decoration: const InputDecoration(
                              hintText: 'Phone Number  (Required) *',
                              hintStyle: TextStyle(
                                  color: Color(0xffB8B8B8),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                              errorBorder: InputBorder.none),
                        ),
                      )),
                ),
                SizedBox(
                  height: mheight * 0.015,
                ),

                Center(
                  child: SizedBox(
                    width: mwidth * 0.9,
                    height: mheight * 0.077,
                    child: Row(
                      children: [
                        Container(
                            width: mwidth * 0.43,
                            height: mheight * 0.077,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color(0xffEEEEEE),
                                    width: mwidth * 0.004),
                                borderRadius: BorderRadius.circular(3)),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: mwidth * 0.04, top: mheight * 0.006),
                              child: TextFormField(textInputAction: TextInputAction.next,
                                controller: pincode,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Pincode should not be empty';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  pincode.text = value!;
                                },
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    hintText: 'Pincode  (Required) *',
                                    hintStyle: TextStyle(
                                        color: Color(0xffB8B8B8),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                    focusedBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    focusedErrorBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none),
                              ),
                            )),
                        SizedBox(
                          width: mwidth * 0.039,
                        ),
                        Container(
                            width: mwidth * 0.43,
                            height: mheight * 0.077,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color(0xffEEEEEE),
                                    width: mwidth * 0.004),
                                borderRadius: BorderRadius.circular(3)),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: mwidth * 0.04, top: mheight * 0.006),
                              child: TextFormField(validator: (value) {
                                if (value!.isEmpty) {
                                  return 'State should not be empty';
                                }
                                return null;
                              },
                                onSaved: (value) {
                                  state.text = value!;
                                },
                                controller: state,textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                    hintText: 'State  (Required) *',
                                    hintStyle: TextStyle(
                                        color: Color(0xffB8B8B8),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    focusedErrorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none),
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: mheight * 0.015,
                ),
                Center(
                  child: Container(
                      width: mwidth * 0.9,
                      height: mheight * 0.077,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xffEEEEEE),
                              width: mwidth * 0.004),
                          borderRadius: BorderRadius.circular(3)),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: mwidth * 0.04, top: mheight * 0.006),
                        child: TextFormField(textInputAction: TextInputAction.next,
                          controller: city,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'City should not be empty';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            city.text = value!;
                          },
                          decoration: const InputDecoration(
                              hintText: 'City (Required) *',
                              hintStyle: TextStyle(
                                  color: Color(0xffB8B8B8),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                              focusedBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              disabledBorder: InputBorder.none),
                        ),
                      )),
                ),
                SizedBox(
                  height: mheight * 0.015,
                ),
                Center(
                  child: Container(
                      width: mwidth * 0.9,
                      height: mheight * 0.077,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xffEEEEEE),
                              width: mwidth * 0.004),
                          borderRadius: BorderRadius.circular(3)),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: mwidth * 0.04, top: mheight * 0.006),
                        child: TextFormField(textInputAction: TextInputAction.next,
                          controller: houseNoOrBuildingName,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field should not be empty';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            houseNoOrBuildingName.text = value!;
                          },
                          decoration: const InputDecoration(
                              hintText:
                                  'House No., Building Name (Required) *',
                              hintStyle: TextStyle(
                                  color: Color(0xffB8B8B8),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                              focusedBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              disabledBorder: InputBorder.none),
                        ),
                      )),
                ),
                SizedBox(
                  height: mheight * 0.015,
                ),
                Center(
                  child: Container(
                      width: mwidth * 0.9,
                      height: mheight * 0.077,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xffEEEEEE),
                              width: mwidth * 0.004),
                          borderRadius: BorderRadius.circular(3)),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: mwidth * 0.04, top: mheight * 0.006),
                        child: TextFormField(textInputAction: TextInputAction.done,
                          controller: landmark,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field should not be empty';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            landmark.text = value!;
                          },
                          decoration: const InputDecoration(
                              hintText:
                                  'Road name, Area, Colony (Required) *',
                              hintStyle: TextStyle(
                                  color: Color(0xffB8B8B8),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                              focusedBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              disabledBorder: InputBorder.none),
                        ),
                      )),
                ),

                SizedBox(
                  height: mheight * 0.035,
                ),
                Padding(
                  padding: EdgeInsets.only(left: mwidth * 0.05),
                  child: const Text(
                    'Type of address',
                    style: TextStyle(
                        color: Color(0xffB8B8B8),
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: mheight * 0.025,
                ),
                Padding(
                  padding: EdgeInsets.only(left: mwidth * 0.045),child:const AddressType()

                ),
                SizedBox(
                  height: mheight * 0.064,
                ),
                Center(
                  child: BlocListener<AddAddressBloc, AddAddressState>(
                    listener: (context, state) {
                      if (state is AddAddressblocLoading) {
                        print('loading');
                        const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is AddAddressblocLoaded) {
                        BlocProvider.of<GetAllAddressBloc>(context).add(FetchGetAllAddress());
                        ToastMessage().toastmessage(message: 'Address Added Successfully');
                        print('loaded');
                        Navigator.of(context).pop();
                      }
                      if (state is AddAddressblocError) {
                        ToastMessage().toastmessage(message: 'Oops Something Went Wrong');
                        print('error');
                      }
                      // TODO: implement listener
                    },
                    child: GestureDetector(
                      onTap: () {
                        final isvalid = form_key.currentState?.validate();
                        if (isvalid == true&&addressType!='') {
                          form_key.currentState?.save();
                          BlocProvider.of<AddAddressBloc>(context).add(
                              FetchAddAddress(
                                  state: state.text,
                                  fullname: fullname.text,
                                  houseNoOrBuildingName:
                                      houseNoOrBuildingName.text,
                                  landmark: landmark.text,
                                  phonenumber: phonenumber.text,
                                  pincode: int.parse(pincode.text),
                                  city: city.text,type: addressType));
                        }
                        else{
                          ToastMessage().toastmessage(message: 'Please Select Your Address Type');
                        }
                      },
                      child: Container(
                          width: mwidth * 0.9,
                          height: mheight * 0.068,
                          decoration: BoxDecoration(
                              color: const Color(0xffFFC113),
                              borderRadius: BorderRadius.circular(4)),
                          child: Padding(
                              padding: EdgeInsets.only(
                                  left: mwidth * 0.04, top: mheight * 0.006),
                              child: const Center(
                                child: Text(
                                  'SAVE ADDRESS',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16),
                                ),
                              ))),
                    ),
                  ),
                ),Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom))
              ],
            ),
          ),
        ));
  }
  @override
  void dispose() {
    fullname.clear();
    pincode.clear();
    phonenumber.clear();
    state.clear();
    city.clear();
    houseNoOrBuildingName.clear();
    landmark.clear();
    // TODO: implement dispose
    super.dispose();
  }
}
