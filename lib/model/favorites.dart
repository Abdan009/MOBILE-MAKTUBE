part of 'models.dart';

class Favorite extends Equatable {
  Favorite({
    this.id,
    @required this.idUser,
    @required this.idVideo,
  });

  final int id;
  final String idUser;
  final String idVideo;

  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
        id: json["favorite_id"],
        idUser: json["id_user"],
        idVideo: json["id_video"],
      );

  Map<String, dynamic> toJson() => {
        "id_user": idUser,
        "id_video": idVideo,
      };

  @override
  List<Object> get props => [
        id,
        idUser,
        idVideo,
      ];
}
