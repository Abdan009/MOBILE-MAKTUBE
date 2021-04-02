part of 'services.dart';

class VisitorService {
  final String url = 'http://192.168.100.10:8000';
  Client client = Client();

  Future<bool> addVisitor(Visitor visitor) async {
    final jsonData = visitor.toJson();
    var result = json.encode(jsonData);

    final response = await client.post('$url/add_visitorr',
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

  Future<List<Visitor>> getVisitors(String idVideo) async {
    final response = await client.get('$url/get_visitor_videos/$idVideo');
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      if (result['code'] == 200) {
        List<Visitor> listVisitor =
            (result['data'] as List).map((e) => Visitor.fromJson(e)).toList();
        return listVisitor;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
