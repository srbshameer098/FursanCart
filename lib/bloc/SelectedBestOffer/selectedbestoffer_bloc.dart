

import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';

import '../../repository/api/Selected_Bestoffer/selected_bestoffer_api.dart';
import '../../repository/model_class/Product/ProductModel.dart';



part 'selectedbestoffer_event.dart';
part 'selectedbestoffer_state.dart';

class SelectedbestofferBloc extends Bloc<SelectedbestofferEvent, SelectedbestofferState> {
  SelectedBestofferApi choosebrandapi=SelectedBestofferApi();
  late List<ProductModel> productmodel;
  SelectedbestofferBloc() : super(SelectedbestofferInitial()) {
    on<FetchSelectedBestoffer>((event, emit) async{
      emit(SelectedBestofferblocLoading());

      try {
        productmodel = await choosebrandapi.getselectedbanner(event.bannersubid);
        emit(SelectedBestofferblocLoaded());

      } catch (e) {
        print("*****$e");
        emit(SelectedBestofferblocError());
      }
      // TODO: implement event handler
    });
  }
}
