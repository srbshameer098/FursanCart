part of 'add_to_cart_bloc.dart';

@immutable
abstract class AddToCartEvent {}
class FetchAddToCart extends AddToCartEvent{
  final varientid;
  final quantity;
  FetchAddToCart({required this.varientid,required this.quantity});
}