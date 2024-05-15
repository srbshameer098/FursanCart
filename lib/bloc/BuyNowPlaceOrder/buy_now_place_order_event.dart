part of 'buy_now_place_order_bloc.dart';

@immutable
abstract class BuyNowPlaceOrderEvent {}

class FetchBuyNowPlaceOrder extends BuyNowPlaceOrderEvent {
  final String totalAmount;
  final String deliveryId;
  final String productId;
  final int quantity;
  final String coupanCode;
  final String deliveryTypeId;
  final String paymentType;

  FetchBuyNowPlaceOrder({
    required this.deliveryId,
    required this.quantity,
    required this.productId,
    required this.totalAmount,required this.coupanCode,required this.deliveryTypeId,required this.paymentType
  });
}
