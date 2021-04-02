import 'package:bloc/bloc.dart';
import 'package:maktube/model/models.dart';
import 'package:maktube/services/services.dart';
import 'package:meta/meta.dart';

part 'videos_state.dart';

class VideosCubit extends Cubit<VideosState> {
  VideosCubit() : super(VideosInitial());

  Future<void> getVideos(String idUser) async {
    List<Favorite> listFavorite = await FavoriteService().getFavorite(idUser);
    List<Videos> listVideos =
        await VideosServices().getVideos().then((videos) => videos.map((video) {
              Favorite favorite = listFavorite.firstWhere(
                (element) => element.idVideo == video.id,
                orElse: () => null,
              );
              if (favorite != null) {
                return video.copyWith(isFavorite: true);
              } else {
                return video;
              }
            }).toList());
    emit(VideosLoaded(listVideos));
  }

  Future<void> addFavorite(Favorite favorite) async {
    bool isUpdate = await FavoriteService().addFavorite(favorite);
    List<Videos> listVideos = (state as VideosLoaded).listVideos;
    if (isUpdate) {
      listVideos = listVideos.map((video) {
        if (video.id == favorite.idVideo) {
          return video.copyWith(isFavorite: true);
        } else {
          return video;
        }
      }).toList();
    }
    emit(VideosLoaded(listVideos));
  }

  Future<void> removeFavorite(String idVideo, String idUser) async {
    bool isUpdate = await FavoriteService().deleteFavorite(idVideo, idUser);
    List<Videos> listVideos = (state as VideosLoaded).listVideos;
    if (isUpdate) {
      listVideos = listVideos.map((video) {
        if (video.id == idVideo) {
          return video.copyWith(isFavorite: false);
        } else {
          return video;
        }
      }).toList();
    }
    emit(VideosLoaded(listVideos));
  }
}
