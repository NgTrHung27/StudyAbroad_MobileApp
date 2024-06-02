part of 'profile_status_cubit.dart';

@immutable
abstract class ProfileStatusState {}

class ProfileStatusInitial extends ProfileStatusState {}

class ProfileStatusLoaded extends ProfileStatusState {
  final String status;
  final int currentStep;

  ProfileStatusLoaded({required this.status, required this.currentStep});
}
