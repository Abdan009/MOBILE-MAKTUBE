part of 'pages.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Profile',
          style: fontTitle.copyWith(fontSize: 20),
        ),
      ),
      body: BlocBuilder<UserCubit, UserState>(builder: (_, userState) {
        if (userState is UserLoaded) {
          User user = userState.user;
          return Container(
            child: ListView(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      color: accentColor1, shape: BoxShape.circle),
                  child: Icon(
                    Icons.person,
                    color: Colors.grey,
                    size: 50,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Column(
                    children: [
                      Text(
                        'Nama Lengkap',
                        style:
                            blackTextFont.copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(user.nama)
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Column(
                    children: [
                      Text(
                        'Nomor Hp',
                        style:
                            blackTextFont.copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(user.noHp)
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Column(
                    children: [
                      Text(
                        'Alamat',
                        style:
                            blackTextFont.copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(user.alamat)
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Container(
                      width: Get.width / 2,
                      child: RaisedButton(
                          color: mainColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            'Logout',
                            style: whiteTextFont.copyWith(
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () async {
                            context.read<UserCubit>().logout();
                          }),
                    ),
                  ],
                )
              ],
            ),
          );
        } else {
          return Center(
            child: loading(4),
          );
        }
      }),
    );
  }
}
