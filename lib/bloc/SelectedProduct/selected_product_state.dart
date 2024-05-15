part of 'selected_product_bloc.dart';

@immutable
abstract class SelectedProductState {

}

class SelectedProductInitial extends SelectedProductState {}
class SelectedProductblocLoading extends  SelectedProductState {}
class SelectedProductblocLoaded extends SelectedProductState {
}
class SelectedProductblocError extends SelectedProductState {}