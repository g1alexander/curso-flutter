part of 'movie_info_cubit.dart';

class MovieInfoState extends Equatable {
  final bool isLoading;
  final Map<String, Movie> movieMap;

  const MovieInfoState({this.isLoading = false, this.movieMap = const {}});

  MovieInfoState copyWith({bool? isLoading, Map<String, Movie>? movieMap}) =>
      MovieInfoState(
          isLoading: isLoading ?? this.isLoading,
          movieMap: movieMap ?? this.movieMap);

  @override
  List<Object> get props => [isLoading, movieMap];
}
