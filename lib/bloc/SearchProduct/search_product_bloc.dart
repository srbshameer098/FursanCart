

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../repository/api/Search_Product/search_product_api.dart';
import '../../repository/model_class/SearchProduct/SearchProductModel.dart';


part 'search_product_event.dart';
part 'search_product_state.dart';

class SearchProductBloc extends Bloc<SearchProductEvent, SearchProductState> {
  late List<SearchProductModel> searchProductModel;
  SearchProductApi searchProductApi=SearchProductApi();
  SearchProductBloc() : super(SearchProductInitial()) {
    on<FetchSearchProduct>((event, emit)async {
      emit(SearchProductblocloading());

      try {
        searchProductModel=await searchProductApi.searchproduct(keyword: event.keyword);
        emit(SearchProductblocloaded());

      } catch (e) {
        print("*****$e");
        emit(SearchProductblocerror());
      }
      // TODO: implement event handler
    });
  }
}
