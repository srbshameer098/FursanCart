

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../repository/api/Buy_Now_Place_Order/buy_now_place_order_api.dart';
import '../../repository/model_class/PlaceOrder/PlaceOrderModel.dart';


part 'buy_now_place_order_event.dart';

part 'buy_now_place_order_state.dart';

class BuyNowPlaceOrderBloc
    extends Bloc<BuyNowPlaceOrderEvent, BuyNowPlaceOrderState> {
  PlaceOrderModel placeOrderModel = PlaceOrderModel();
  BuyNowPlaceOrderApi buyNowPlaceOrderApi = BuyNowPlaceOrderApi();

  BuyNowPlaceOrderBloc() : super(BuyNowPlaceOrderInitial()) {
    on<FetchBuyNowPlaceOrder>((event, emit) async {
      emit(BuyNowPlaceOrderblocLoading());

      try {
        placeOrderModel = await buyNowPlaceOrderApi.buynowplaceorder(
            deliveryId: event.deliveryId,
            productId: event.productId,
            quantity: event.quantity, totalAmount: event.totalAmount, paymentType:event.paymentType, deliveryTypeId: event.deliveryTypeId, coupanCode: event.coupanCode);
        emit(BuyNowPlaceOrderblocLoaded());

      } catch (e) {
        print("*****$e");
        emit(BuyNowPlaceOrderblocError());
      }
      // TODO: implement event handler
    });
  }
}
