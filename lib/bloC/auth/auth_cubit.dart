import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kltn_mobile/Model/school.dart';
import 'package:kltn_mobile/bloC/auth/auth_state.dart';
import 'package:kltn_mobile/bloC/repository/repository.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthLoadingState());
  static String token = "";
  APIRepository authRepo = APIRepository();

  void getSchools() async {
    try {
      List<School> school = await authRepo.getSchools();
      emit(AuthLoadedState(school));
    } catch (ex) {
      print('Schools: ` $ex');
      emit(AuthErorrState(ex.toString()));
    }
  }
}
