part of 'models.dart';

class Visitor extends Equatable {
  Visitor(
      {this.id,
      @required this.idUser,
      @required this.idVideo,
      @required this.timeCreate});

  final int id;
  final String idUser;
  final String idVideo;
  final String timeCreate;

  factory Visitor.fromJson(Map<String, dynamic> json) => Visitor(
      id: json["favorite_id"],
      idUser: json["id_user"],
      idVideo: json["id_video"],
      timeCreate: json['time_create']);

  Map<String, dynamic> toJson() => {
        "favorite_id": id,
        "id_user": idUser,
        "id_video": idVideo,
        "time_create": timeCreate
      };

  @override
  List<Object> get props => [id, idUser, idVideo, timeCreate];
}
