part of 'get_all_address_bloc.dart';

@immutable
abstract class GetAllAddressState {}

class GetAllAddressInitial extends GetAllAddressState {}
class GetAllAddressblocloading extends GetAllAddressState{}
class GetAllAddressblocloaded extends GetAllAddressState{}
class GetAllAddressblocerror extends GetAllAddressState{}