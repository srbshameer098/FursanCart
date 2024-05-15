import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';

import '../../Ui/Widgets/toast_message.dart';
import '../../repository/api/Signup/Signup_api.dart';
import '../../repository/model_class/User/Usermodel.dart';



part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  late  Usermodel signupModel;
  SignupApi signupApi =SignupApi();
  SignupBloc() : super(SignupInitial()) {
    on<FetchSignupApi>((event, emit) async{
      emit(SignupblocLoading());
      try{

        signupModel = await signupApi.getuserdata(event.email,event.username,event.password);
        emit(SignupblocLoaded(signupModel));
      } catch(e){
        ToastMessage().toastmessage(message:e.toString());
        print('*****$e');
        emit(SignupblocError());
      }
      // TODO: implement event handler
    });
  }
}
