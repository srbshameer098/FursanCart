

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import 'package:meta/meta.dart';

import '../../repository/api/Choose_Brand/choose_brand_api.dart';
import '../../repository/model_class/Brand/BrandModel.dart';



part 'brand_event.dart';
part 'brand_state.dart';

class BrandBloc extends Bloc<BrandEvent, BrandState> {
  late List<BrandModel> brandModel;
  late List<BrandModel> chooseBrand ;
  ChooseBrandApi choosebrandapi=ChooseBrandApi();
  BrandBloc() : super(BrandInitial()) {
    on<FetchChooseBrand>((event, emit) async{
      emit(ChooseBrandblocLoading());

      try {
        brandModel = await choosebrandapi.getBrand();
        chooseBrand=brandModel.where((element) => element.image!=null).toList();
        emit(ChooseBrandblocLoaded());

      } catch (e) {
        print("*****$e");
        emit(ChooseBrandblocError());
      }

      // TODO: implement event handler
    });
  }
}
