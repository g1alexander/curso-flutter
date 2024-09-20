import 'package:cinemapedia/modules/movies/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/modules/movies/domain/entities/movie.dart';
import 'package:cinemapedia/modules/movies/domain/repositories/movies_repository.dart';

class MovieRepositoryImpl extends MoviesRepository {
  final MoviesDatasource datasource;

  MovieRepositoryImpl(this.datasource);

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlaying(page: page);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return datasource.getPopular(page: page);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    return datasource.getTopRated(page: page);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) {
    return datasource.getUpcoming(page: page);
  }

  @override
  Future<Movie> getMovieById(String id) {
    return datasource.getMovieById(id);
  }

  @override
  Future<List<Movie>> searchMovies(String query, {int page = 1}) {
    return datasource.searchMovies(query, page: page);
  }

  @override
  Future<String> getVideoByMovieId(String id) {
    return datasource.getVideoByMovieId(id);
  }

  @override
  Future<List<Movie>> getRecommendationsByMovieId(String id) {
    return datasource.getRecommendationsByMovieId(id);
  }
}
