

import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';

import '../../repository/api/Trending_Now/Trendingnow_api.dart';
import '../../repository/model_class/Product/ProductModel.dart';


part 'trendingnow_event.dart';
part 'trendingnow_state.dart';

class TrendingnowBloc extends Bloc<TrendingnowEvent, TrendingnowState> {
  late List<ProductModel> productModel;
  late List<ProductModel> trendingnow ;
  TrendingNowApi trendingnowapi=TrendingNowApi();
  TrendingnowBloc() : super(TrendingnowInitial()) {
    on<FetchTrendingNow>((event, emit) async{
      emit(TrendingnowblocLoading());

      try {
        productModel = await trendingnowapi.gettrendingnow();
        emit(TrendingnowblocLoaded());
      } catch (e) {
        print("*****$e");
        emit(TrendingnowblocError());
      }

      // TODO: implement event handler
    });
  }
}
