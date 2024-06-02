import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_status_state.dart';

class ProfileStatusCubit extends Cubit<ProfileStatusState> {
  ProfileStatusCubit() : super(ProfileStatusInitial());

  void updateStatus(String status) {
    int currentStep;
    if (status == 'APPROVED' || status == 'DENIED') {
      currentStep = 2;
    } else {
      currentStep = 1;
    }
    emit(ProfileStatusLoaded(status: status, currentStep: currentStep));
  }
}
