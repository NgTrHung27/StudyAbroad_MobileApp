import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kltn_mobile/blocs/contact_us_bloc/contact_state.dart';
import 'package:kltn_mobile/blocs/repository/repository.dart';
import 'package:kltn_mobile/models/enum.dart';
import 'package:kltn_mobile/models/schools.dart';
import 'package:kltn_mobile/screens/home/contact_us.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  ContactUsCubit() : super(ContactLoadingState());
  APIRepository authRepo = APIRepository();

  //check titleform
  void checkTitle(String titleForm) {
    if (titleForm.isEmpty) {
      emit(ContactErrorTitleErrorState('Please choose title'));
    }
  }

  //----------------
  //fetch data
  void getSchools() async {
    try {
      List<Schools> school = await authRepo.fetchSchools();
      emit(ContactLoadedNamedSchoolState(school));
      print('Schools cubit: ` $school');
    } catch (ex) {
      print('Schools cubit: ` $ex');
      emit(ContactErrorNamedSchoolState(ex.toString()));
    }
  }

  Future<void> accept(String email, fullName, phone, message,
      String selectedSchool, TitleForm valueTitle) async {
    emit(ContactLoadingState());
    try {
      ContactUs? contactUs = await authRepo.contactUs(
        email,
        fullName,
        phone,
        message,
        selectedSchool,
        valueTitle.toString().split('.').last.toUpperCase(),
      );
      if (contactUs != null && contactUs.error == null) {
        emit(ContactSuccessState(contactUs));
      }
    } catch (a) {
      emit(ContactErrorState(a.toString()));
    }
  }
}
