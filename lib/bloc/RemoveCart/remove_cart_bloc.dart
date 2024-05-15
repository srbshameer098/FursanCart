

import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';

import '../../repository/api/Remove_Cart/remove_cart_api.dart';
import '../../repository/model_class/RemoveCart/remove_cart_model.dart';



part 'remove_cart_event.dart';
part 'remove_cart_state.dart';

class RemoveCartBloc extends Bloc<RemoveCartEvent, RemoveCartState> {
  late  RemoveCartModel removeCartModel;
  RemoveCartApi removeCartApi =RemoveCartApi();
  RemoveCartBloc() : super(RemoveCartInitial()) {
    on<FetchRemoveCart>((event, emit) async {
      emit(RemoveCartblocLoading());

      try {
        removeCartModel= await removeCartApi.removecart(cartproductid:event.cartproductid);
        emit(RemoveCartblocLoaded());

      } catch (e) {
        print("*****$e");
        emit(RemoveCartblocError());
      }
      // TODO: implement event handler
    });
  }
}
