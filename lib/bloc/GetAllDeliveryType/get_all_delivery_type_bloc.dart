
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../repository/api/Get_Delivery_Type/get_delicery_type_api.dart';
import '../../repository/model_class/GetDeliveryType/GetDeliveryTypeModel.dart';

part 'get_all_delivery_type_event.dart';
part 'get_all_delivery_type_state.dart';

class GetAllDeliveryTypeBloc extends Bloc<GetAllDeliveryTypeEvent, GetAllDeliveryTypeState> {
  late List<GetDeliveryTypeModel> getAllDeliveryTypeModel;
  GetDeliveryTypesApi getAllDeliveryTypeApi =GetDeliveryTypesApi();
  GetAllDeliveryTypeBloc() : super(GetAllDeliveryTypeInitial()) {
    on<FetchGetAllDeliveryType>((event, emit) async{
      emit(GetAllDeliveryTypeblocloading());

      try {
        getAllDeliveryTypeModel=await getAllDeliveryTypeApi.getalldeliverytype();
        emit(GetAllDeliveryTypeblocloaded());

      } catch (e) {
        print("*****$e");
        emit(GetAllDeliveryTypeblocerror());
      }
    });
  }
}
