import 'package:flutter/material.dart';
import 'package:toktik/domain/entities/video_post.dart';
import 'package:toktik/infrastructure/repositories/video_posts_repository_impl.dart';

class DiscoverProvider extends ChangeNotifier {
  final VideoPostsRepositoryImpl videosPostsRepository;

  bool initialLoading = true;
  List<VideoPost> videos = [];

  DiscoverProvider({required this.videosPostsRepository});

  Future<void> loadNextPage() async {
    final newVideos = await videosPostsRepository.getTredingVideosByPage(1);

    videos.addAll(newVideos);
    initialLoading = false;
    notifyListeners();
  }
}
