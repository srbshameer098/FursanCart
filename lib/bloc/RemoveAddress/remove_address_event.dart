part of 'remove_address_bloc.dart';

@immutable
abstract class RemoveAddressEvent {}
class FetchRemoveAddress extends RemoveAddressEvent{
  final String addressId;
  FetchRemoveAddress({required this.addressId});
}