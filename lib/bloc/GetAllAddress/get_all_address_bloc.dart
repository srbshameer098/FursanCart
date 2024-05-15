

import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';

import '../../repository/api/Get_All_Address/get_all_address_api.dart';
import '../../repository/model_class/GetAllAddress/GetAllAddressModel.dart';


part 'get_all_address_event.dart';
part 'get_all_address_state.dart';

class GetAllAddressBloc extends Bloc<GetAllAddressEvent, GetAllAddressState> {
  late List<GetAllAddressModel> getAllAddressModel;
  GetAllAddressApi getAllAddressApi=GetAllAddressApi();
  GetAllAddressBloc() : super(GetAllAddressInitial()) {
    on<FetchGetAllAddress>((event, emit)async {
      emit(GetAllAddressblocloading());
      try {
        getAllAddressModel=await getAllAddressApi.getalladdress();
        emit(GetAllAddressblocloaded());

      } catch (e) {
        print("*****$e");
        emit(GetAllAddressblocerror());
      }
      // TODO: implement event handler
    });
  }
}
