

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../repository/api/Post_Address/post_adress_api.dart';
import '../../repository/model_class/PostAddress/PostAddressModel.dart';


part 'add_address_event.dart';

part 'add_address_state.dart';

class AddAddressBloc extends Bloc<AddAddressEvent, AddAddressState> {
  late PostAddressModel postAddressModel;
  PostAddressApi addToCartApi = PostAddressApi();

  AddAddressBloc() : super(AddAddressInitial()) {
    on<FetchAddAddress>((event, emit) async {
      emit(AddAddressblocLoading());

      try {
        postAddressModel = await addToCartApi.postadress(state: event.state,
            fullname: event.fullname,
            houseNoOrBuildingName: event.houseNoOrBuildingName,
            landmark: event.landmark,
            phonenumber: event.phonenumber,
            pincode: event.pincode,
            city: event.city,type: event.type);

        emit(AddAddressblocLoaded());

      } catch (e) {
        print("*****$e");
        emit(AddAddressblocError());
      }
      // TODO: implement event handler
    });
  }
}
