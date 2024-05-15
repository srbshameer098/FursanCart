

import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';

import '../../Ui/Widgets/toast_message.dart';
import '../../repository/api/Login/Login_api.dart';
import '../../repository/model_class/User/Usermodel.dart';



part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  late  Usermodel loginModel;
  LoginApi signupApi =LoginApi();
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {
      on<FetchLoginApi>((event, emit) async{
        emit(SignupblocLoading());
        try{
          loginModel = await signupApi.postuserdata(event.email,event.password);
          emit(SignupblocLoaded(loginModel));
        } catch(e){
          ToastMessage().toastmessage(message:e.toString());

          print('*****$e');
          emit(SignupblocError());
        }
        // TODO: implement event handler
      });
      // TODO: implement event handler
    });
  }
}
