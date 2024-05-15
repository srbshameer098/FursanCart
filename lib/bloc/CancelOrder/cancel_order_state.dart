part of 'cancel_order_bloc.dart';

@immutable
abstract class CancelOrderState {}

class CancelOrderInitial extends CancelOrderState {}
class CancelOrderblocLoading extends CancelOrderState {}
class CancelOrderblocLoaded extends CancelOrderState {
}
class CancelOrderblocError extends CancelOrderState {}