

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../repository/api/Get_User_Details/get_user_details_api.dart';
import '../../repository/model_class/GetUserDetails/GetUserDetailsModel.dart';


part 'get_user_details_event.dart';
part 'get_user_details_state.dart';

class GetUserDetailsBloc extends Bloc<GetUserDetailsEvent, GetUserDetailsState> {
  late  GetUserDetailsModel getUserDetailsModel;
  GetUserDetailsApi getUserDetailsApi=GetUserDetailsApi();
  GetUserDetailsBloc() : super(GetUserDetailsInitial()) {
    on<FetchGetUserDetails>((event, emit)async {
      emit(GetUserDetailsblocloading());

      try {
        getUserDetailsModel=await getUserDetailsApi.getuserdetails();
        emit(GetUserDetailsblocloaded());

      } catch (e) {
        print("*****$e");
        emit(GetUserDetailsblocerror());
      }
      // TODO: implement event handler
    });
  }
}
