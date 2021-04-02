part of 'pages.dart';

class DetailVideoPage extends StatefulWidget {
  final Videos video;
  DetailVideoPage(this.video);
  @override
  _DetailVideoPageState createState() => _DetailVideoPageState();
}

class _DetailVideoPageState extends State<DetailVideoPage> {
  bool isFavorite = false;
  bool isViewFulDesk = false;
  @override
  Widget build(BuildContext context) {
    context.read<VisitorsCubit>().getVisitorInVideo(widget.video.id);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          'Video Detail',
          style: fontTitle.copyWith(fontSize: 20),
        ),
      ),
      body: BlocBuilder<VideosCubit, VideosState>(builder: (_, videoState) {
        Videos video = (videoState as VideosLoaded)
            .listVideos
            .firstWhere((element) => element.id == widget.video.id);
        return Container(
          child: ListView(
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(ViewVideoPage(video: video));
                },
                child: Container(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: Get.width,
                        height: 230,
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(video.thumnails),
                                fit: BoxFit.cover)),
                      ),
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            color: Colors.amber.withOpacity(0.5),
                            shape: BoxShape.circle),
                        child: Icon(
                          Icons.play_arrow,
                          color: mainColor,
                          size: 50,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Text(
                                video.title,
                                style: blackTextFont.copyWith(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          BlocBuilder<UserCubit, UserState>(
                            builder: (_, userState) => (!isFavorite)
                                ? IconButton(
                                    icon: Icon(Icons.favorite,
                                        color: (video.isFavorite)
                                            ? Colors.red
                                            : accentColor2),
                                    onPressed: () {
                                      if (!video.isFavorite) {
                                        Favorite favorite = Favorite(
                                            idUser: (userState as UserLoaded)
                                                .user
                                                .idUser
                                                .toString(),
                                            idVideo: video.id);
                                        context
                                            .read<VideosCubit>()
                                            .addFavorite(favorite);
                                      } else {
                                        context
                                            .read<VideosCubit>()
                                            .removeFavorite(
                                                video.id,
                                                (userState as UserLoaded)
                                                    .user
                                                    .idUser
                                                    .toString());
                                      }
                                    })
                                : loading(1),
                          )
                        ],
                      ),
                    ),
                    Text("Publish : " + video.publisheAt.dateAndTimeNumber,
                        style: blackTextFont),
                    Divider(height: 10, thickness: 3),
                    Text('Deskripsi',
                        style: blackTextFont.copyWith(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          video.description,
                          textAlign: TextAlign.start,
                          maxLines: isViewFulDesk ? null : 10,
                          overflow:
                              isViewFulDesk ? null : TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isViewFulDesk) {
                                isViewFulDesk = false;
                              } else {
                                isViewFulDesk = true;
                              }
                            });
                          },
                          child: Text(
                              isViewFulDesk
                                  ? 'Tampilkan Sedikit'
                                  : 'Baca Selengkapnya ...',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    )),
                    Divider(height: 10, thickness: 3),
                    Text('Visitors',
                        style: blackTextFont.copyWith(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 10,
                    ),
                    BlocBuilder<VisitorsCubit, VisitorsState>(
                      builder: (_, visitorState) {
                        List<Visitor> listVisitor =
                            (visitorState as VisitorLoaded).listVisitor;
                        if (listVisitor != null) {
                          return Container(
                              height: 300, child: showGrafik(listVisitor));
                        } else {
                          return Center(
                            child: loading(4.0),
                          );
                        }
                      },
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  Widget showGrafik(List<Visitor> visitors) {
    List<String> listTime =
        visitors.map((element) => element.timeCreate).toList().toSet().toList();
    List<VisitorGrafik> listVisitor = listTime.map((e) {
      List<Visitor> visitorInTime =
          visitors.where((element) => element.timeCreate == e).toList();
      return VisitorGrafik(e, visitorInTime.length);
    }).toList();

    return charts.BarChart(
      [
        charts.Series(
            domainFn: (visitor, _) => visitor.time,
            measureFn: (visitor, _) => visitor.total,
            id: 'Visitors',
            data: listVisitor)
      ],
      animate: true,
    );
  }
}

class VisitorGrafik {
  final String time;
  final int total;
  VisitorGrafik(this.time, this.total);
}
