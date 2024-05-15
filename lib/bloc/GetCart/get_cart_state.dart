part of 'get_cart_bloc.dart';

@immutable
abstract class GetCartState {}

class GetCartInitial extends GetCartState {}
class GetCartblocloading extends GetCartState{}
class GetCartblocloaded extends GetCartState{}
class GetCartblocerror extends GetCartState{}