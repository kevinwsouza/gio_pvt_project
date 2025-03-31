import 'package:frotalog_gestor_v2/app/features/home%20screen/presenter/bloc/home_screen_state.dart';
import 'package:frotalog_gestor_v2/app/utils/ecubit.dart';

class HomeScreenController extends ECubit<HomeScreenState> {
  
  HomeScreenController() : super(HomeScreenInitialState()) {
    emit(HomeScreenInitialState());
    /*if (failure != null) {
      emit(LoginFailureState(failure: failure));*/
    
  }
}