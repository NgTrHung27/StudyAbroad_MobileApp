import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kltn_mobile/Model/country.dart';
import 'package:kltn_mobile/Model/schools.dart';
import 'package:kltn_mobile/bloC/auth/auth_state.dart';
import 'package:kltn_mobile/bloC/repository/repository.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthLoadingState());
  static String token = "";
  APIRepository authRepo = APIRepository();

  void getSchools() async {
    try {
      List<Schools> school = await authRepo.fetchSchools();
      emit(AuthLoadedNamedSchoolState(school));
      print('Schools cubit: ` $school');
    } catch (ex) {
      print('Schools cubit: ` $ex');
      emit(AuthErrorNamedSchoolState(ex.toString()));
    }
  }

  void getCity() async {
    try {
      List<Country> city = await authRepo.fetchCountry();
      emit(AuthLoadedCityState(city));
      print('City cubit: ` $city');
    } catch (ex) {
      print('City cubit: ` $ex');
      emit(AuthErrorCityState(ex.toString()));
    }
  }
}
