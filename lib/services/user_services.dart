part of 'services.dart';

class UserServices {
  final String url = 'http://192.168.100.10:8000';
  Client client = Client();

  Future<User> createUser(User user) async {
    final userJson = user.toJson();
    var userResult = json.encode(userJson);

    final response = await client.post('$url/register',
        headers: {"content-type": "application/json"}, body: userResult);

    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      if (result['code'] == 200) {
        return User.fromJson(result['data']);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<User> login(String username, String password) async {
    Map<String, dynamic> data = {'username': username, 'password': password};
    var userResult = json.encode(data);
    final response = await client.post('$url/login',
        headers: {"content-type": "application/json"}, body: userResult);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      if (result['message'] == "Login Berhasil") {
        return User.fromJson(result['data']);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<User> getUser(String id) async {
    try {
      final response = await client.get("$url/users/$id");
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        if (data['code'] == 200) {
          return User.fromJson(data['data']);
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      print('Terjadi error Get User');
      return null;
    }
  }
}
