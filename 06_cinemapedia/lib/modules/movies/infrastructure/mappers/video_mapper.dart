import 'package:cinemapedia/modules/movies/infrastructure/models/models.dart';

class VideoMapper {
  static String idVideoToEntity(VideosResponse data) {
    final videos = data.results;

    if (videos.isEmpty) return '';

    final video = videos.lastWhere((video) =>
        video.type == 'Trailer' && video.site == 'YouTube' && video.official);

    return video.key;
  }
}
