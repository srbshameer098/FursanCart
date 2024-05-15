part of 'remove_address_bloc.dart';

@immutable
abstract class RemoveAddressState {}

class RemoveAddressInitial extends RemoveAddressState {}
class RemoveAddressblocLoading extends RemoveAddressState {}
class RemoveAddressblocLoaded extends RemoveAddressState {
}
class RemoveAddressblocError extends RemoveAddressState{}