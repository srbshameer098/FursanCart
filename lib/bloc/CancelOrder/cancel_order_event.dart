part of 'cancel_order_bloc.dart';

@immutable
abstract class CancelOrderEvent {}
class FetchCancelOrder extends CancelOrderEvent{
  final String orderId;
  final String reason;
  FetchCancelOrder({required this.orderId,required this.reason});
}