

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


import '../../repository/api/Selected_Product/selected_product_api.dart';

import '../../repository/model_class/SelectedProductModel/SelectedProductModel.dart';




part 'selected_product_event.dart';
part 'selected_product_state.dart';

class SelectedProductBloc extends Bloc<SelectedProductEvent, SelectedProductState> {
  late SelectedProductModel productmodel;
  SelectedProductApi selectedproductapi=SelectedProductApi();
  SelectedProductBloc() : super(SelectedProductInitial()) {
    on<FetchSelectedProduct>((event, emit)async {
      emit(SelectedProductblocLoading());

      try {
        productmodel = await selectedproductapi.getselectedproduct(event.productid);
        emit(SelectedProductblocLoaded());
      } catch (e) {
        print("*****$e");
        emit(SelectedProductblocError());
      }

      // TODO: implement event handler
    });
    }
  }

