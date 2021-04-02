part of 'pages.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<bool> init() async {
      SharedPreferences storagePref = await SharedPreferences.getInstance();
      try {
        if (storagePref.getString('username') != null) {
          await context.read<UserCubit>().login(
              storagePref.getString('username'),
              storagePref.getString('password'));
          return true;
        } else {
          context.read<UserCubit>().toUserLoaded();
          return false;
        }
      } catch (e) {
        print(e.toString());
        return false;
      }
    }

    return FutureBuilder(
      future: init(),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          return BlocBuilder<UserCubit, UserState>(builder: (_, userState) {
            if (userState is UserLoaded) {
              if (userState.user != null) {
                context
                    .read<VideosCubit>()
                    .getVideos(userState.user.idUser.toString());
                return MainPage();
              } else {
                return LoginPage();
              }
            } else {
              return Scaffold(
                body: Center(
                  child: loading(4.0),
                ),
              );
            }
          });
        } else {
          return Scaffold(
            body: Center(
              child: loading(4.0),
            ),
          );
        }
      },
    );
  }
}
