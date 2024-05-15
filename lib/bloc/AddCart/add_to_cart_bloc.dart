

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../repository/api/Post_To_Cart/post_to_cart_api.dart';
import '../../repository/model_class/PostCart/PostCartModel.dart';


part 'add_to_cart_event.dart';
part 'add_to_cart_state.dart';

class AddToCartBloc extends Bloc<AddToCartEvent, AddToCartState> {
  late  PostCartModel postToCartModel;
  AddToCartApi addToCartApi =AddToCartApi();
  AddToCartBloc() : super(AddToCartInitial()) {
    on<FetchAddToCart>((event, emit)async {
      emit(AddToCartblocLoading());
      try {
        postToCartModel=await addToCartApi.addtocart(varientid: event.varientid,quantity: event.quantity);

        emit(AddToCartblocLoaded());
      } catch (e) {
        print("*****$e");
        emit(AddToCartblocError());
      }
      // TODO: implement event handler
    });
  }
}
