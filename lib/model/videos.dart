part of 'models.dart';

class Videos extends Equatable {
  final String id, idVideo, thumnails, description, title;
  final bool isFavorite;
  final DateTime publisheAt;

  Videos(
      {@required this.id,
      @required this.idVideo,
      @required this.thumnails,
      @required this.description,
      this.isFavorite,
      @required this.title,
      @required this.publisheAt});

  Videos copyWith({
    bool isFavorite,
  }) {
    return Videos(
        id: this.id,
        idVideo: this.idVideo,
        thumnails: this.thumnails,
        description: this.description,
        title: this.title,
        publisheAt: this.publisheAt,
        isFavorite: isFavorite ?? this.isFavorite);
  }

  @override
  List<Object> get props =>
      [id, idVideo, thumnails, description, title, isFavorite, publisheAt];
}
