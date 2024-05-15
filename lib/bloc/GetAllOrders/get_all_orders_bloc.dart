

import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';

import '../../repository/api/Get_All_Orders/get_all_orders_api.dart';
import '../../repository/model_class/GetAllOrders/GetAllOrders.dart';



part 'get_all_orders_event.dart';
part 'get_all_orders_state.dart';

class GetAllOrdersBloc extends Bloc<GetAllOrdersEvent, GetAllOrdersState> {
  late List<GetAllOrders> getAllOrdersModel;
  GetAllOrdersApi getAllOrdersApi =GetAllOrdersApi();
  GetAllOrdersBloc() : super(GetAllOrdersInitial()) {


    on<FetchGetAllOrders>((event, emit)async {
      emit(GetAllOrdersblocloading());

      try {
        getAllOrdersModel=await getAllOrdersApi.getallorders();
        emit(GetAllOrdersblocloaded());

      } catch (e) {
        print("*****$e");
        emit(GetAllOrdersblocerror());
      }
      // TODO: implement event handler
    });
  }
}
