



import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../repository/api/Slider/slider_api.dart';
import '../../repository/model_class/SliderModel/SliderModel.dart';




part 'slider_event.dart';
part 'slider_state.dart';

class SliderBloc extends Bloc<SliderEvent, SliderState> {
  late List<SliderModel> bannerModel;

  SliderApi sliderapi=SliderApi();

  SliderBloc() : super(SliderInitial()) {
    on<FetchSlider>((event, emit) async {
      emit(SliderblocLoading());

      try {
        bannerModel = await sliderapi.getBanner();
        emit(SliderblocLoaded());

      } catch (e) {
         print("*****$e");
        emit(SliderblocError());
      }

      // TODO: implement event handler
    });
  }
}
