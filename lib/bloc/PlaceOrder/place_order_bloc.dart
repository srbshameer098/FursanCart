import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';

import '../../repository/api/Place_Order/place_order_api.dart';
import '../../repository/model_class/PlaceOrder/PlaceOrderModel.dart';

part 'place_order_event.dart';

part 'place_order_state.dart';

class PlaceOrderBloc extends Bloc<PlaceOrderEvent, PlaceOrderState> {
  PlaceOrderModel placeOrderModel = PlaceOrderModel();
  PlaceOrderApi placeOrderApi = PlaceOrderApi();

  PlaceOrderBloc() : super(PlaceOrderInitial()) {
    on<FetchPlaceOrder>((event, emit) async {
      emit(PlaceOrderblocLoading());

      try {
        placeOrderModel = await placeOrderApi.placeorder(
            deliveryId: event.deliveryId,
            listOfCartItemId2: event.ListOfCartItemId1,
            paymentMethod: event.paymentMethod,
            coupan: event.coupan, deliveryTypeId: event.deiverytypeid);
        emit(PlaceOrderblocLoaded());
      } catch (e) {
        print("*****$e");
        emit(PlaceOrderblocError());
      }
      // TODO: implement event handler
    });
  }
}
