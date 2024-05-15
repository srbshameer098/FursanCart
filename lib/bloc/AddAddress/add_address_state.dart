part of 'add_address_bloc.dart';

@immutable
abstract class AddAddressState {}

class AddAddressInitial extends AddAddressState {}
class AddAddressblocLoading extends AddAddressState {}
class AddAddressblocLoaded extends AddAddressState {
}
class AddAddressblocError extends AddAddressState{}