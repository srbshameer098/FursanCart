part of 'cancel_order_reason_bloc.dart';

@immutable
abstract class CancelOrderReasonState {}

class CancelOrderReasonInitial extends CancelOrderReasonState {}
class CancelOrderReasonblocloading extends CancelOrderReasonState{}
class CancelOrderReasonblocloaded extends CancelOrderReasonState{}
class CancelOrderReasonblocerror extends CancelOrderReasonState{}