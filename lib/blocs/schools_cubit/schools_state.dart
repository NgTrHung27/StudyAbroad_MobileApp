part of 'schools_cubit.dart';

abstract class SchoolsState {}

class SchoolsInitial extends SchoolsState {}

class SchoolsLoading extends SchoolsState {}

class SchoolsLoaded extends SchoolsState {
  final List<Schools> schoolList;
  SchoolsLoaded({required this.schoolList});
}
class CountryLoaded extends SchoolsState {
  final List<String> countryList;
  CountryLoaded({required this.countryList});
}
class SchoolsError extends SchoolsState {
  final String message;
  SchoolsError({required this.message});
}
