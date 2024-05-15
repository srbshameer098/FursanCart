part of 'decrease_cart_quantity_bloc.dart';

@immutable
abstract class DecreaseCartQuantityEvent {}
class FetchDecreaseCartQuantity extends DecreaseCartQuantityEvent{
 final String cartitemid;
 final int  quantity;
 FetchDecreaseCartQuantity({required this.cartitemid,required this.quantity});
}