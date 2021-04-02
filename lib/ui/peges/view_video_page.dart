part of 'pages.dart';

class ViewVideoPage extends StatelessWidget {
  final Videos video;
  ViewVideoPage({@required this.video});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(builder: (_, userState) {
      Visitor visitor = Visitor(
          idUser: (userState as UserLoaded).user.idUser.toString(),
          idVideo: video.id,
          timeCreate: DateTime.now().dateAndTimeNumber);
      context.read<VisitorsCubit>().addVisitorInVideo(visitor);
      return Center(
        child:
            WebviewScaffold(url: "https://youtube.com/embed/${video.idVideo}"),
      );
    });
  }
}
