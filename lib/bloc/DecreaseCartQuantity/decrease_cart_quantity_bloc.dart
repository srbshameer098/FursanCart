

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


import '../../repository/api/Decrease_Cart_Quantity/decrease_cart_quantity_api.dart';
import '../../repository/model_class/DecreaseCartQuantity/DecreaseCartQuantityModel.dart';


part 'decrease_cart_quantity_event.dart';
part 'decrease_cart_quantity_state.dart';

class DecreaseCartQuantityBloc extends Bloc<DecreaseCartQuantityEvent, DecreaseCartQuantityState> {
  late  DecreaseCartQuantityModel decreseCartQuantityModel;
  DecreaseCartQuantityApi decreaseCartQuantityApi =DecreaseCartQuantityApi();
  DecreaseCartQuantityBloc() : super(DecreaseCartQuantityInitial()) {
    on<FetchDecreaseCartQuantity>((event, emit)async {
      emit(DecreseCartQuantityblocLoading());
      try {
        decreseCartQuantityModel=await decreaseCartQuantityApi.decreasecartquantity(cartproductid: event.cartitemid, quantity: event.quantity);
        emit(DecreseCartQuantityblocLoaded());

      } catch (e) {
        print("*****$e");
        emit(DecreseCartQuantityblocError());
      }
      // TODO: implement event handler
    });
  }
}
