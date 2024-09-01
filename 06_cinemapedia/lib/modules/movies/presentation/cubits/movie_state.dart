import 'package:cinemapedia/modules/movies/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

class MovieState extends Equatable {
  final bool isLoading;
  final List<Movie> movies;
  final int currentPage;

  const MovieState(
      {this.isLoading = false, this.movies = const [], this.currentPage = 0});

  MovieState copyWith(
      {bool? isLoading, List<Movie>? movies, int? currentPage}) {
    return MovieState(
        isLoading: isLoading ?? this.isLoading,
        movies: movies ?? this.movies,
        currentPage: currentPage ?? this.currentPage);
  }

  @override
  List<Object> get props => [isLoading, movies, currentPage];
}
