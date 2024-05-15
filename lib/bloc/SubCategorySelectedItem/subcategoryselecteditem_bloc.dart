

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


import '../../repository/api/Sub_Category_Selected_Item/sub_category_selected_item_api.dart';
import '../../repository/model_class/Product/ProductModel.dart';


part 'subcategoryselecteditem_event.dart';
part 'subcategoryselecteditem_state.dart';

class SubcategoryselecteditemBloc extends Bloc<SubcategoryselecteditemEvent, SubcategoryselecteditemState> {
  late List<ProductModel> subcategoryselecteditemModel;
  SubCategorySelectedItemApi subCategorySelectedItemApi=SubCategorySelectedItemApi();
  SubcategoryselecteditemBloc() : super(SubcategoryselecteditemInitial()) {

    on<FetchSubCategorySelectedItem>((event, emit)async {
      emit(SubCategoryselecteditemblocLoading());

      try {
        subcategoryselecteditemModel = await subCategorySelectedItemApi.getSubCategorySelectedItem(subcategoryid: event.subcategoryid);
        emit(SubCategoryselecteditemblocLoaded());

      } catch (e) {
        print("*****$e");
        emit(SubCategoryselecteditemblocError());
      }
      // TODO: implement event handler
    });
  }
}
