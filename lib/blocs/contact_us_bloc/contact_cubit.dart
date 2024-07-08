import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kltn_mobile/blocs/contact_us_bloc/contact_state.dart';
import 'package:kltn_mobile/blocs/repository/repository.dart';
import 'package:kltn_mobile/models/enum.dart';
import 'package:kltn_mobile/models/schools.dart';
import 'package:kltn_mobile/screens/home/contact_us.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  final APIRepository authRepo;

  ContactUsCubit(this.authRepo) : super(ContactInitialState());

  //--------state check
  // Check title form
  void checkTitle(TitleForm? titleForm) {
    if (titleForm == null) {
      emit(ContactErrorTitleErrorState('Please choose a title'));
    } else {
      emit(ContactInitialState());
    }
  }

  // Check email
  void checkEmail(String email) {
    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regExp = RegExp(emailPattern);

    if (!regExp.hasMatch(email)) {
      emit(ContactErrorEmailState('Please enter a valid email'));
    } else {
      emit(ContactInitialState());
    }
  }

  //----------------
  // Fetch data
  void getSchools() async {
    emit(ContactLoadingState());
    try {
      List<Schools> schools = await authRepo.fetchSchools();
      emit(ContactLoadedNamedSchoolState(schools));
    } catch (ex) {
      emit(ContactErrorNamedSchoolState(ex.toString()));
    }
  }

  //----------
  // Send form
  Future<void> sendForm(
    String fullName,
    String email,
    TitleForm valueTitle,
    String phone,
    String message,
    String? selectedSchool,
  ) async {
    emit(ContactLoadingState());
    try {
      ContactUs? contactUs = await authRepo.contactUs(
        fullName,
        email,
        valueTitle.toString().split('.').last.toUpperCase(),
        phone,
        message,
        selectedSchool ?? '',
      );

      if (contactUs != null) {
        emit(ContactSuccessState(contactUs));
      } else {
        emit(ContactErrorState('An error occurred while sending the form.'));
      }
    } catch (e) {
      emit(ContactErrorState(e.toString()));
    }
  }
}
