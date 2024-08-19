part of 'news_cubit.dart';

@immutable
abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<NewsList> newsList;
  NewsLoaded({required this.newsList});
}

class NewsSchoolLoaded extends NewsState {
  final List<NewsList> newsSchoolList;
  NewsSchoolLoaded({required this.newsSchoolList});
}

class NewsError extends NewsState {
  final String message;
  NewsError({required this.message});
}
