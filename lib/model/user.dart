part of 'models.dart';

class User extends Equatable {
  User({
    this.idUser,
    @required this.username,
    @required this.password,
    @required this.nama,
    @required this.alamat,
    @required this.noHp,
  });

  final int idUser;
  final String username;
  final String password;
  final String nama;
  final String alamat;
  final String noHp;

  factory User.fromJson(Map<String, dynamic> json) => User(
        idUser: json["id_user"],
        username: json["username"],
        password: json["password"],
        nama: json["nama"],
        alamat: json["alamat"],
        noHp: json["no_hp"],
      );

  Map<String, dynamic> toJson() => {
        "id_user": idUser,
        "username": username,
        "password": password,
        "nama": nama,
        "alamat": alamat,
        "no_hp": noHp,
      };

  @override
  List<Object> get props => [
        idUser,
        username,
        password,
        nama,
        alamat,
        noHp,
      ];
}
