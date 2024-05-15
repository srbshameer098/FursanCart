part of 'place_order_bloc.dart';

@immutable
abstract class PlaceOrderEvent {}
class FetchPlaceOrder extends PlaceOrderEvent{
  final String deliveryId;
  final List<Map<String, dynamic>> ListOfCartItemId1;
  final String paymentMethod;
  final String coupan;
  final String deiverytypeid;
  FetchPlaceOrder({required this.deliveryId,required this.paymentMethod,required this.ListOfCartItemId1,required this.coupan,required this.deiverytypeid});
}