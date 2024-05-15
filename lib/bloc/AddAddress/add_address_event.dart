part of 'add_address_bloc.dart';

@immutable
abstract class AddAddressEvent {}

class FetchAddAddress extends AddAddressEvent {
  final String fullname;
  final String phonenumber;
  final int pincode;
  final String state;
  final String houseNoOrBuildingName;
  final String landmark;
  final String city;
  final String type;

  FetchAddAddress(
      {required this.state,required this.type,
      required this.fullname,
      required this.houseNoOrBuildingName,
      required this.landmark,
      required this.phonenumber,
      required this.pincode,required this.city});
}
