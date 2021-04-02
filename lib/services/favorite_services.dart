part of 'services.dart';

class FavoriteService {
  final String url = 'http://192.168.100.10:8000';
  Client client = Client();

  Future<bool> addFavorite(Favorite favorite) async {
    final jsonData = favorite.toJson();
    var result = json.encode(jsonData);

    final response = await client.post('$url/store_favorite',
        headers: {"content-type": "application/json"}, body: result);

    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      if (result['code'] == 200) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> deleteFavorite(String idVideo, String idUser) async {
    final response = await client.delete(
        '$url/delete_favorite/$idUser/$idVideo',
        headers: {"content-type": "application/json"});
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      if (result['code'] == 200) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<List<Favorite>> getFavorite(String idUser) async {
    final response = await client.get('$url/get_my_favorite/$idUser');
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      if (result['code'] == 200) {
        List<Favorite> listFavorite =
            (result['data'] as List).map((e) => Favorite.fromJson(e)).toList();
        return listFavorite;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
