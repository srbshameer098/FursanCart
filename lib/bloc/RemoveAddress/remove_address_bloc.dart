

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


import '../../repository/api/Remove_Address/remove_address_api.dart';
import '../../repository/model_class/RemoveAddress/RemoveAddressModel.dart';


part 'remove_address_event.dart';
part 'remove_address_state.dart';

class RemoveAddressBloc extends Bloc<RemoveAddressEvent, RemoveAddressState> {
  late RemoveAddressModel removeAddressModel;
  RemoveAddressApi removeAddressApi=RemoveAddressApi();
  RemoveAddressBloc() : super(RemoveAddressInitial()) {
    on<FetchRemoveAddress>((event, emit) async{
      emit(RemoveAddressblocLoading());

      try {
        removeAddressModel=await removeAddressApi.removeaddress(addressid: event.addressId);
        emit(RemoveAddressblocLoaded());

      } catch (e) {
        print("*****$e");
        emit(RemoveAddressblocError());
      }
      // TODO: implement event handler
    });
  }
}
