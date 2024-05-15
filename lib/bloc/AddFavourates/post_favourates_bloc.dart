

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../repository/api/Add_To_Favourates/add_to_favourites_api.dart';
import '../../repository/model_class/PostFavourates/PostFavouratesModel.dart';

part 'post_favourates_event.dart';
part 'post_favourates_state.dart';

class PostFavouratesBloc extends Bloc<PostFavouratesEvent, PostFavouratesState> {
  late  PostFavouratesModel postFavouratesModel;
  AddToFavouritesApi addToFavouritesApi=AddToFavouritesApi();
  PostFavouratesBloc() : super(PostFavouratesInitial()) {
    on<FetchAddToFavourates>((event, emit) async {
      emit(PostToFavourateblocLoading());
      try {
        postFavouratesModel=await addToFavouritesApi.addtofavourites(productid: event.productid);
        emit(PostToFavourateblocLoaded());
      } catch (e) {
        print("*****$e");
        emit(PostToFavourateblocError());
      }
      // TODO: implement event handler
    });
  }
}
