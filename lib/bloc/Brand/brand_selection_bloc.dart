

import 'package:bloc/bloc.dart';


import 'package:meta/meta.dart';

import '../../repository/api/Choose_Brand/choose_brand_api.dart';
import '../../repository/api/Selected_Brand/selected_brand_api.dart';
import '../../repository/model_class/Product/ProductModel.dart';



part 'brand_selection_event.dart';
part 'brand_selection_state.dart';

class BrandSelectionBloc extends Bloc<BrandSelectionEvent, BrandSelectionState> {
  late List<ProductModel> productModel;
  ChooseBrandApi choosebrandapi=ChooseBrandApi();
  late List<ProductModel> selectedBrand;
  SelectedBrandApi selectedbrandapi=SelectedBrandApi();
  BrandSelectionBloc() : super(BrandSelectionInitial()) {
    on<FetchSelectedBrand>((event, emit) async{
      emit(SelectedBrandblocLoading());
      try {
        productModel = await selectedbrandapi.selectedbrand(event.brandid);
        emit(SelectedBrandblocLoaded());

      } catch (e) {
        if(e.toString().contains('Unauthorized')){
          emit(SectionExpired());
        }
        print("*****$e");
        emit(SelectedBrandblocError());
      }
      // TODO: implement event handler
    });
  }
}
