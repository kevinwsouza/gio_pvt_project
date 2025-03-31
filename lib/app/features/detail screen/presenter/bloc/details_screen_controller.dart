import 'package:frotalog_gestor_v2/app/features/detail%20screen/presenter/bloc/details_screen_state.dart';
import 'package:frotalog_gestor_v2/app/utils/ecubit.dart';

class DetailsScreenController extends ECubit<DetailsScreenState> {
  
  DetailsScreenController() : super(DetailsScreenInitialState()) {
    emit(DetailsScreenInitialState());
    /*if (failure != null) {
      emit(LoginFailureState(failure: failure));*/
    
  }
}