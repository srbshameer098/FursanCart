

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


import '../../repository/api/Sub_Category/subcategory_page_api.dart';
import '../../repository/model_class/Subcategory/SubCategoryModel.dart';


part 'sub_category_event.dart';
part 'sub_category_state.dart';

class SubCategoryBloc extends Bloc<SubCategoryEvent, SubCategoryState> {
  late List<SubCategoryModel> subcategoryModel;
  SubCategoryPageApi subcategoryPageApi=SubCategoryPageApi();
  SubCategoryBloc() : super(SubCategoryInitial()) {
    on<FetchSubCategory>((event, emit)async {
      emit(SubCategoryblocLoading());

      try {
        subcategoryModel = await subcategoryPageApi.getSubCategory(categoryId: event.categoryId);
        emit(SubCategoryblocLoaded());

      } catch (e) {
        print("*****$e");
        emit(SubCategoryblocError());
      }
      // TODO: implement event handler
    });
  }
}
