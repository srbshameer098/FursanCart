import 'package:flutter/material.dart';

import '../../main.dart';

class AddressType extends StatefulWidget {
  const AddressType({super.key});

  @override
  _AddressTypeState createState() => _AddressTypeState();
}

class _AddressTypeState extends State<AddressType> {

  @override
  Widget build(BuildContext context) {
    final mwidth = MediaQuery.of(context).size.width;
    final mheight = MediaQuery.of(context).size.height;

    return Row(
      children: [SizedBox(
                    width: mwidth * 0.022,
                  ),
        GestureDetector(
          onTap: () {
            setState(() {
              addressType = 'Home';
            });
          },
          child: Container( width: mwidth * 0.23,
            height: mheight * 0.043,
            decoration: BoxDecoration(
                border: Border.all(
                    color: const Color(0xffEEEEEE), width: mwidth * 0.004),
                borderRadius: BorderRadius.circular(44)),
            child: Row(
              children: [
                SizedBox(
                  width: mwidth * 0.022,
                ),
                SizedBox(
                  width: mwidth * 0.06,
                  height: mheight * 0.023,
                  child: Image.asset('asset/Images/house.png'),
                ),
                SizedBox(
                  width: mwidth * 0.01,
                ),
                Text(
                  'Home',
                  style: TextStyle(
                      color: addressType == 'Home' ? Colors.blue : Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 12),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          width: mwidth * 0.014,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              addressType = 'Office';
            });
          },
          child: Container(
            width: mwidth * 0.23,
            height: mheight * 0.043,
            decoration: BoxDecoration(
                border: Border.all(
                    color: const Color(0xffEEEEEE), width: mwidth * 0.004),
                borderRadius: BorderRadius.circular(44)),
            child: Row(
              children: [
                SizedBox(
                  width: mwidth * 0.022,
                ),
                SizedBox(
                  width: mwidth * 0.06,
                  height: mheight * 0.023,
                  child: Image.asset('asset/Images/office.png'),
                ),
                SizedBox(
                  width: mwidth * 0.01,
                ),
                Text(
                  'Office',
                  style: TextStyle(
                      color:
                      addressType == 'Office' ? Colors.blue : Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 12),
                )
              ],
            ),
          ),
        ),SizedBox(
          width: mwidth * 0.014,
        ),GestureDetector(onTap: () {
          setState(() {
            addressType = 'Other';
          });
        },
          child: Container(
    width: mwidth * 0.23,
    height: mheight * 0.043,
    decoration: BoxDecoration(
          border: Border.all(
              color: const Color(0xffEEEEEE),
              width: mwidth * 0.004),
          borderRadius: BorderRadius.circular(44)),child: Center(
            child: Text(
              'Other',
              style: TextStyle(
                  color:
                  addressType == 'Other' ? Colors.blue : Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 12),
            ))),
        ),
      ],
    );
  }
}
