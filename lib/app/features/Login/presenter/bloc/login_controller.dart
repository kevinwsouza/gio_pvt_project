import 'package:frotalog_gestor_v2/app/features/Login/presenter/bloc/login_state.dart';
import 'package:frotalog_gestor_v2/app/utils/ecubit.dart';

class LoginController extends ECubit<LoginState>{
  
  LoginController() : super(LoginInitialState()) {
    emit(LoginInitialState());
    /*if (failure != null) {
      emit(LoginFailureState(failure: failure));*/
    
  }
}