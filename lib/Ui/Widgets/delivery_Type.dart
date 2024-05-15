import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../bloc/GetAllDeliveryType/get_all_delivery_type_bloc.dart';
import '../../main.dart';
import '../../repository/model_class/GetDeliveryType/GetDeliveryTypeModel.dart';

class DeliveryTypeBottomSheet extends StatefulWidget {
  const DeliveryTypeBottomSheet({super.key});

  @override
  State<DeliveryTypeBottomSheet> createState() =>
      _DeliveryTypeBottomSheetState();
}

List<bool> checkboxValues = [];

class _DeliveryTypeBottomSheetState extends State<DeliveryTypeBottomSheet> {

  late List<GetDeliveryTypeModel> deliveryTypes;

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
    BlocProvider.of<GetAllDeliveryTypeBloc>(context)
        .add(FetchGetAllDeliveryType());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double mWidth = MediaQuery.of(context).size.width;
    double mHeight = MediaQuery.of(context).size.height;
    return Container(
      width: mWidth,
      height: mHeight * 0.38,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: mHeight * 0.045,
          ),
          const Text(
            'Select Your Delivery Type',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(child:
              BlocBuilder<GetAllDeliveryTypeBloc, GetAllDeliveryTypeState>(
                  builder: (context, state) {
            if (state is GetAllDeliveryTypeblocloading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is GetAllDeliveryTypeblocerror) {
              return RefreshIndicator(
                onRefresh: () async {
                  return BlocProvider.of<GetAllDeliveryTypeBloc>(context)
                      .add(FetchGetAllDeliveryType());
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
            if (state is GetAllDeliveryTypeblocloaded) {
              deliveryTypes = BlocProvider.of<GetAllDeliveryTypeBloc>(context)
                  .getAllDeliveryTypeModel;
              for (int i = 0; i < deliveryTypes.length; i++) {
                checkboxValues.add(false);
              }

              return ListView.builder(
                itemCount: deliveryTypes.length,
                itemBuilder: (BuildContext context, int index) {
                  return CheckboxListTile(activeColor: const Color(0xff264050),
                    title: Text(deliveryTypes[index].name ?? ''),
                    value: checkboxValues[index],
                    onChanged: (bool? value) {

                      setState(() {
                        deliveryTypeId=deliveryTypes[index].id.toString();
                        slabAmount=double.parse(deliveryTypes[index].amountSlab.toString());
                        deliveryCharge=double.parse(deliveryTypes[index].deliveryCharge.toString());

                      });

                      _onCheckboxValueChanged(value, index);
                      if(checkboxValues[index]==true){
                        Navigator.of(context).pop();
                      }


                    },
                  );
                },
              );
            } else {
              return const SizedBox();
            }
          })),

        ],
      ),
    );
  }

}
