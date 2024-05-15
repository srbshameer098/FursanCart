part of 'buy_now_place_order_bloc.dart';

@immutable
abstract class BuyNowPlaceOrderState {}

class BuyNowPlaceOrderInitial extends BuyNowPlaceOrderState {}
class BuyNowPlaceOrderblocLoading extends BuyNowPlaceOrderState {}
class BuyNowPlaceOrderblocLoaded extends BuyNowPlaceOrderState {
}
class BuyNowPlaceOrderblocError extends BuyNowPlaceOrderState{}