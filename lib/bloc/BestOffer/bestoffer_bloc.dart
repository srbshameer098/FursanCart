

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../repository/api/Best_Offer/best_offer_api.dart';
import '../../repository/model_class/BestOffer/BestOfferModel.dart';


part 'bestoffer_event.dart';
part 'bestoffer_state.dart';

class BestofferBloc extends Bloc<BestofferEvent, BestofferState> {
  late List<BestOfferModel> bestoffer ;
  BestofferApi bestofferApi=BestofferApi();
  BestofferBloc() : super(BestofferInitial()) {
    on<FetchBestOffer>((event, emit) async {
      emit(BestofferblocLoading());

      try {
        bestoffer = await bestofferApi.getBanner();
        emit(BestofferblocLoaded());

      } catch (e) {
        print("*****$e");
        emit(BestofferblocError());
      }

      // TODO: implement event handler
    });
  }
  }

