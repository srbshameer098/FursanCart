

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


import '../../repository/api/Get_Cart/get_cart_api.dart';
import '../../repository/model_class/GetCart/GetCartModel.dart';




part 'get_cart_event.dart';
part 'get_cart_state.dart';

class GetCartBloc extends Bloc<GetCartEvent, GetCartState> {
  late GetCartModel getcartmodel;
  GetCartApi getCartApi=GetCartApi();
  GetCartBloc() : super(GetCartInitial()) {
    on<FetchGetCart>((event, emit)async {
      emit(GetCartblocloading());

      try {
        getcartmodel=await getCartApi.getcart();
        emit(GetCartblocloaded());

      } catch (e) {
        print("*****$e");
        emit(GetCartblocerror());
      }
      // TODO: implement event handler
    });
  }
}
