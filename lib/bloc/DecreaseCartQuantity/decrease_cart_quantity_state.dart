part of 'decrease_cart_quantity_bloc.dart';

@immutable
abstract class DecreaseCartQuantityState {}

class DecreaseCartQuantityInitial extends DecreaseCartQuantityState {}
class DecreseCartQuantityblocLoading extends DecreaseCartQuantityState {}
class DecreseCartQuantityblocLoaded extends DecreaseCartQuantityState {
}
class DecreseCartQuantityblocError extends DecreaseCartQuantityState{}