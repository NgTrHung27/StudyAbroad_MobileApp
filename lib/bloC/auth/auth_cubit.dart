import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kltn_mobile/Model/school.dart';
import 'package:kltn_mobile/Model/vn_country.dart';
import 'package:kltn_mobile/bloC/auth/auth_state.dart';
import 'package:kltn_mobile/bloC/repository/repository.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthLoadingState());
  static String token = "";
  APIRepository authRepo = APIRepository();

  void getSchools() async {
    try {
      List<School> school = await authRepo.getSchools();
      emit(AuthLoadedNamedSchoolState(school));
      print('Schools cubit: ` $school');
    } catch (ex) {
      print('Schools cubit: ` $ex');
      emit(AuthErrorNamedSchoolState(ex.toString()));
    }
  }

  void getCity() async {
    try{
      List<City> city = await authRepo.getCity();
      emit(AuthLoadedCityState(city));
      print('City cubit: ` $city');
    }catch (ex) {
      print('City cubit: ` $ex');
      emit(AuthErrorCityState(ex.toString()));
    }
  }
}
