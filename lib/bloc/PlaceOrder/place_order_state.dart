part of 'place_order_bloc.dart';

@immutable
abstract class PlaceOrderState {}

class PlaceOrderInitial extends PlaceOrderState {}
class PlaceOrderblocLoading extends PlaceOrderState {}
class PlaceOrderblocLoaded extends PlaceOrderState {
}
class PlaceOrderblocError extends PlaceOrderState{}