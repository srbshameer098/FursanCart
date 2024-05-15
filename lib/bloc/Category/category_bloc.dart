

import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';

import '../../repository/api/Category_Page/category_page_api.dart';
import '../../repository/model_class/Category/CategoryModel.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  late List<CategoryModel> categoryModel;
  CategoryPageApi categoryPageApi=CategoryPageApi();
  CategoryBloc() : super(CategoryInitial()) {
    on<FetchCategory>((event, emit)async {
      emit(CategoryblocLoading());
      try {
        categoryModel = await categoryPageApi.getCategory();
        emit(CategoryblocLoaded());
      } catch (e) {
        print("*****$e");
        emit(CategoryblocError());
      }
      // TODO: implement event handler
    });
  }
}
