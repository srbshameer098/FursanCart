

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../repository/api/Order_Cancel/order_cancel_api.dart';
import '../../repository/model_class/CancelOrder/CancelOrder.dart';


part 'cancel_order_event.dart';
part 'cancel_order_state.dart';

class CancelOrderBloc extends Bloc<CancelOrderEvent, CancelOrderState> {
  late  CancelOrder orderCancelModel;
  CancelOrderApi cancelOrderApi=CancelOrderApi();
  CancelOrderBloc() : super(CancelOrderInitial()) {
    on<FetchCancelOrder>((event, emit)async {

      emit(CancelOrderblocLoading());
      try {

        orderCancelModel = await cancelOrderApi.cancelOrder(orderId: event.orderId,  reason: event.reason);

        emit(CancelOrderblocLoaded());
      } catch (e) {
        print('*****$e');
        emit(CancelOrderblocError());
      }
      // TODO: implement event handler
    });
  }
}
