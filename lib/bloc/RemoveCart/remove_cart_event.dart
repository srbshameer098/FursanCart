part of 'remove_cart_bloc.dart';

@immutable
abstract class RemoveCartEvent {}
class FetchRemoveCart extends RemoveCartEvent{
  final cartproductid;
  FetchRemoveCart({required this.cartproductid});
}