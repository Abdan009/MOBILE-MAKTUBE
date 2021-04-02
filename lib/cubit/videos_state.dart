part of 'videos_cubit.dart';

@immutable
abstract class VideosState {}

class VideosInitial extends VideosState {}

class VideosLoaded extends VideosState {
  final List<Videos> listVideos;
  VideosLoaded(this.listVideos);
}
