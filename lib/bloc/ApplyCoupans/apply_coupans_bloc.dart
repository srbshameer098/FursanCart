
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../Ui/Widgets/toast_message.dart';
import '../../repository/api/ApplyCoupans/apply_coupan_api.dart';
import '../../repository/model_class/Coupan/CouponModel.dart';



part 'apply_coupans_event.dart';
part 'apply_coupans_state.dart';

class ApplyCoupansBloc extends Bloc<ApplyCoupansEvent, ApplyCoupansState> {
  late  List<CouponModel> coupon;
  ApplyCoupanApi applyCoupanApi =ApplyCoupanApi();
  ApplyCoupansBloc() : super(ApplyCoupansInitial()) {
    on<FetchCoupans>((event, emit)async {

      emit(ApplyCoupansblocLoading());
      try {
        coupon=await applyCoupanApi.applycoupan(code: event.code);

        emit(ApplyCoupansblocLoaded());
      } catch (e) {
        print("*****$e");
        ToastMessage()
            .toastmessage(message:e.toString());
        emit(ApplyCoupansblocError());
      }
      // TODO: implement event handler
    });
  }
}
