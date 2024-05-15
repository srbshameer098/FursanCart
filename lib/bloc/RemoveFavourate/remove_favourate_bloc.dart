

import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';

import '../../repository/api/Remove_Favourate/remove_favourate_api.dart';
import '../../repository/model_class/RemoveFavourate/RemoveFavourateModel.dart';



part 'remove_favourate_event.dart';
part 'remove_favourate_state.dart';

class RemoveFavourateBloc extends Bloc<RemoveFavourateEvent, RemoveFavourateState> {
  late  RemoveFavourateModel removeFavourateModel;
  RemoveFavourateApi removeFavourateApi = RemoveFavourateApi();
  RemoveFavourateBloc() : super(RemoveFavourateInitial()) {
    on<FetchRemoveFavourate>((event, emit) async {
      emit(RemoveFavourateblocLoading());
      try {
        removeFavourateModel= await removeFavourateApi.removefavourate(productwhislistid: event.productwishlistid);
        emit(RemoveFavourateblocLoaded());

      } catch (e) {
        print("*****$e");
        emit(RemoveFavourateblocError());
      }
      // TODO: implement event handler
    });
  }
}
