import 'package:kltn_mobile/models/news_school.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NewsSchoolState {}

class NewsSchoolInitial extends NewsSchoolState {}

class NewsSchoolLoading extends NewsSchoolState {}

class NewsSchoolLoaded extends NewsSchoolState {
  final List<NewsSchoolList> newsSchoolList;
  NewsSchoolLoaded({required this.newsSchoolList});
}

class NewsSchoolError extends NewsSchoolState {
  final String message;
  NewsSchoolError({required this.message});
}
