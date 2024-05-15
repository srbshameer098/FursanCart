

import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';

import '../../repository/api/Get_Favourates/get_favourates_api.dart';
import '../../repository/model_class/GetFavourates/GetFavouratesModel.dart';





part 'get_favourates_event.dart';
part 'get_favourates_state.dart';

class GetFavouratesBloc extends Bloc<GetFavouratesEvent, GetFavouratesState> {
  late GetFavouratesModel getFavouratesModel;
  GetFavouratesApi getAllFavouritesApi=GetFavouratesApi();
  GetFavouratesBloc() : super(GetFavouratesInitial()) {
    on<FetchGetFavourates>((event, emit) async {
      emit(GetFavouratesblocloading());
      try {
        getFavouratesModel=await getAllFavouritesApi.getfavourates();
        emit(GetFavouratesblocloaded());

      } catch (e) {
        print("*****$e");
        emit(GetFavouratesblocerror());
      }
      // TODO: implement event handler
    });
  }
}
