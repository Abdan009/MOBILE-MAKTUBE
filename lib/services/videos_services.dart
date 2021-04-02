part of 'services.dart';

class VideosServices {
  final String url = 'https://listvideoflutteryoutube.herokuapp.com/';
  Client client = Client();

  Future<List<Videos>> getVideos() async {
    final response = await client.get('$url');
    if (response.statusCode == 200) {
      List result = jsonDecode(response.body);
      List<Videos> listVideos = result.map((videos) {
        return Videos(
            id: videos['id'],
            idVideo: videos['contentDetails']['videoId'],
            thumnails: videos['snippet']['thumbnails']['high']['url'],
            description: videos['snippet']['description'],
            title: videos['snippet']['title'],
            publisheAt: DateTime.parse(videos['snippet']['publishedAt']),
            isFavorite: false);
      }).toList();
      return listVideos;
    } else {
      return null;
    }
  }
}
