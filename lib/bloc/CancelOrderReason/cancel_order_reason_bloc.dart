
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../repository/api/Get_Cancel_Order_Reasons/get_cancel_order_reason_api.dart';
import '../../repository/model_class/CancelOrderReasons/CancelOrderReason.dart';

part 'cancel_order_reason_event.dart';
part 'cancel_order_reason_state.dart';

class CancelOrderReasonBloc extends Bloc<CancelOrderReasonEvent, CancelOrderReasonState> {
  late List<CancelOrderReason> cancelOrderReason;
  GetCancelOrderReasonApi cancelOrderReasonApi=GetCancelOrderReasonApi();
  CancelOrderReasonBloc() : super(CancelOrderReasonInitial()) {
    on<FetchGetCancelOrderReason>((event, emit) async{
      emit(CancelOrderReasonblocloading());
      try {
        cancelOrderReason=await cancelOrderReasonApi.getcancelorderreason();
        emit(CancelOrderReasonblocloaded());

      } catch (e) {
        print("*****$e");
        emit(CancelOrderReasonblocerror());
      }
      // TODO: implement event handler
    });
  }
}
