part of 'selected_product_bloc.dart';

@immutable
abstract class SelectedProductEvent {}
class FetchSelectedProduct extends SelectedProductEvent{
  late String productid;
  FetchSelectedProduct({required this.productid});
}
class IncrementEvent extends SelectedProductEvent {

}
class DecrementEvent extends SelectedProductEvent {
}